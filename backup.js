// The directory to backup your plugins
const BACKUP_PATH="/Users/robb/Sites/personal/xbar-plugins"

//The directory where your plugins live
const PLUGIN_PATH="/Users/robb/Library/Application Support/xbar/plugins"

function run() {
	const app = Application.currentApplication();
	app.includeStandardAdditions = true;

	const se = Application('System Events');
	const plugins = se.folders.byName(PLUGIN_PATH).diskItems.name()

	plugins.forEach(pi => {
		app.doShellScript(`cd "${PLUGIN_PATH}"`)
		const contents = app.read(Path(`${PLUGIN_PATH}/${pi}`))
	
		if (contents.includes('Robb Knight'))
		{
			app.doShellScript(`cp "${PLUGIN_PATH}/${pi}" "${BACKUP_PATH}/plugins/${pi}"`)
		}
	})
}