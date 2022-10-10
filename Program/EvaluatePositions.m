function Position = EvaluatePositions(LabData)
    global NBody Body Jnt
    frame = 1;
    Position = zeros(NBody, NBody * 2);
        for i=1:NBody

            csi_temp = [LabData.Coordinates(frame,2*(Body(i).pj)-1) - ... %x_i
                        LabData.Coordinates(frame,2*(Body(i).pi)-1), ...  %x_j
                        LabData.Coordinates(frame,2*(Body(i).pj)) - ...  %y_i
                        LabData.Coordinates(frame,2*(Body(i).pi))];       %y_j

            csi_temp = csi_temp/norm(csi_temp);
            % eta
            eta_temp = [-csi_temp(2),csi_temp(1)];
            
            % theta
            theta = atan2(csi_temp(2), csi_temp(1));
            if theta < 0
                theta = 2*pi + theta;
            end
            A =[cos(theta), -sin(theta); sin(theta), cos(theta)];
            
            outra_coisa = [LabData.Coordinates(frame,2*(Body(i).pi)-1); LabData.Coordinates(frame,2*(Body(i).pi))] + ...
                A*[Body(i).Length*Body(i).PCoM; 0];
            Body(i).x = outra_coisa(1);
            Body(i).y = outra_coisa(2);
            Body(i).theta = theta*180/pi;
            Body(i).csi_x = csi_temp(1);
            Body(i).csi_y = csi_temp(2);
            Body(i).eta_x = eta_temp(1);
            Body(i).eta_y = eta_temp(2);
        end
end

