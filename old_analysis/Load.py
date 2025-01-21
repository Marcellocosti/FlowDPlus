from ROOT import TFile, TDirectoryFile, TList, TTree

def Load(container, path):
    '''
    Function to extract an object inside a root file.
    Supports nested containers with the following Data Types:
     - TDirectoryFile (TFile)
     - TList

    Parameters
    -----------
    container: TFile of the input file
    path: path of the object inside the root file

    Returns:
    -----------
    obj: target root object
    '''

    # Check that the input file is OK
    path = os.path.normpath(path)
    if container == None:  # pylint: disable=singleton-comparison
        fempy.logger.critical('The container %s is NULL', container.GetName())

    # Start to extract
    for name in path.split(os.sep):
        fempy.logger.debug('Trying to load %s:%s. Available keys:', container.GetName(), name)

        for key in GetKeyNames(container):
            fempy.logger.debug('    %s', key)

        if isinstance(container, TDirectoryFile):
            obj = container.Get(name)
        elif isinstance(container, TList):
            obj = container.FindObject(name)
        else:
            fempy.logger.critical('The container %s of type %s is not valid', container.GetName(), type(container))

        if obj == None:  # pylint: disable=singleton-comparison
            fempy.logger.error('The container %s does not contain an object named %s', container.GetName(), name)
            raise NameError()
        container = obj

    fempy.logger.debug('The object %s:%s was succesfully loaded', container.GetName(), path)
    return obj