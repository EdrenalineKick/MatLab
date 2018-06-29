% Specify the folder where the files live.
myFolder = 'C:\Users\EdRenaline\Documents\MATLAB\Segmented';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.tif'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
  row1 =[]
  row2 =[]
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  imageArray = imread(fullFileName);
  imshow(imageArray);  % Display image.
  if k>=1 && k<=5
      row1=cat(2,row1,imageArray);
  end
  if k>=6 && k<=10
      row2=cat(2,row2,imageArray);
  end
end
  wholeimage=cat(1,row1,row2);
  imshow(wholeimage)