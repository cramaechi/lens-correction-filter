
function k = parameter_estimation(edgeLinkedImage)
    image = edgeLinkedImage;
    f = @(k) cost_function(k, image);
    error = 1e100;
    % Specify the steps to be (max - min)/100
    step = (1e-5 - 1e-7)/100;
    
    % Choose the minimum error for each value of k
    for k1 = 1e-7:step:1e-5
        nextError = cost_function(k1, image);
        if isnan(nextError) || nextError >= error
            continue;
        end
        k = k1;
        error = nextError;
    end
end