let project = new Project('Perdita');

project.addLibrary("jasper");
project.addLibrary("cosmo");
project.addLibrary("wanda");
project.addSources('Sources');
project.addParameter('--connect 6000');
project.addParameter('-debug');
project.addAssets('Assets/**');

resolve(project);