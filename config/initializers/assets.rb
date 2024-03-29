# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += [ 'classie.js',
                                                'cbpAnimatedHeader.js',
                                                'jquery.easing.min.js',
                                                'raphael.min.js',
                                                'metisMenu.js',
                                                'jquery.dataTables.js',
                                                'dataTables.bootstrap.js',
                                                'bootstrap-magnify,js',
                                                'admin.js' ]
