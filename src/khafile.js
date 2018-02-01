let project = new Project('Perdita');

project.addLibrary("jasper");
project.addSources('Sources');
project.addParameter('--connect 6000');
project.addParameter('-dce full');
project.addParameter('-debug');
project.addAssets('Assets/**');

resolve(project);