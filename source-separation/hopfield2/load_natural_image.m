%load numpatterns size*size binary images from directory 'images'
function mypatterns = load_natural_image(numPatterns,size)

    %LOAD_NATURAL_IMAGE Summary of this function goes here
    %   Detailed explanation goes here
    file_path ='images/';
    file_name_list = dir(strcat(file_path,'*.jpg'));
    mypatterns = zeros(size*size,1,numPatterns);
    for i=1:numPatterns
        image_name = file_name_list(i).name;
        current_pattern= load_image_by_name(strcat(file_path,image_name),size);
        mypatterns(:,:,i)=current_pattern;
    end
end



