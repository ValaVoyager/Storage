executable(
	meson.project_name(),

	'TmpMain.vala',
	
	# DOMAIN
	'Domain/Entity/Cookie.vala',

	'Domain/Enum/SitePolicyEnum.vala',

	# APPLICATION
	'Application/PersistentStorageInterface.vala',
	'Application/VolatileStorageInterface.vala',
	'Application/CookieStorageInterface.vala',
	'Application/LocalStorageInterface.vala',
	'Application/SessionStorageInterface.vala',

	# INFRASTRUCTURE

	dependencies: [
		dependency('gtk+-3.0'),
		dependency('json-glib-1.0')
	],
	install: true
)
