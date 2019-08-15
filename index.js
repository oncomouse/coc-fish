const {sources} = require('coc.nvim')
const {exec} = require('child_process')

function execPromise(command) {
  return new Promise(function (resolve, reject) {
    exec(command, (error, stdout) => {
      if (error) {
        reject(error);
        return;
      }

      resolve(stdout.trim());
    });
  });
}

exports.activate = async context => {
  const source = {
    name: 'fish',
    doComplete: async opt => {
      const cmd = opt.input.replace(/(["\s'$`\\])/g, '\\$1')
      const result = await execPromise(`fish -c "complete -C${cmd}"`)
      return {
        items: result
          .split('\n')
          .map(l => l.split('\t'))
          .map(pieces => ({
            word: pieces[0],
            abbr: `${pieces[0]}${pieces[1] ? ` (${pieces[1]})` : ''}`,
            menu: this.menu || '[fish]'
          }))
      }
    },
  }

  context.subscriptions.push(sources.createSource(source))
}
