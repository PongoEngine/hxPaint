let project = new Project('Finger Trap');

project.addLibrary("Pongo");
project.addSources('Sources');
project.addParameter('--connect 6000');
project.addParameter('-debug');
project.addAssets('Assets/**');

resolve(project);