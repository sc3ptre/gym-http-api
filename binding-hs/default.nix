{ mkDerivation, aeson, base, exceptions, http-client, servant
, servant-client, servant-lucid, stdenv, text, unordered-containers
}:
mkDerivation {
  pname = "gym-http-api";
  version = "0.1.0.2";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base servant servant-client servant-lucid text
    unordered-containers
  ];
  executableHaskellDepends = [
    base exceptions http-client servant-client
  ];
  homepage = "https://github.com/stites/gym-http-api#readme";
  description = "REST client to the gym-http-api project";
  license = stdenv.lib.licenses.mit;
}
