
classdef person<handle
    properties 
        age=0
        sex
        race
        birthday=datetime('today')
        age2
    end
    methods
        function obj=happy_birthday(obj)
            obj.age=obj.age+1;  
        end
        function get_age(obj)
            fprintf('%f',obj.age)
        end
        function set.age(obj)
        end
    end
end