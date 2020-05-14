require './config/environment'

use Rack::MethodOverride
run ApplicationController
use ShowsController
use UsersController
