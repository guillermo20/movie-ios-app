
Pod::Spec.new do |spec|

  spec.name         = "MovieDBRepository"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of MovieDBRepository."
  spec.homepage     = "http://EXAMPLE/MovieDBRepository"

  spec.author       = { "Guillermo Gutierrez" => "guillermo20@gmail.com" }
  spec.source       = { :path => '.' }

  spec.platform     = :ios
  spec.ios.deployment_target = "12.2"
  spec.requires_arc = true
  spec.swift_version = "4.2"

  spec.source_files = "MovieDBRepository/**/*.{swift}"
  spec.dependency 'MovieWebService'
  spec.dependency 'MovieDataBase'

end
