#Select the best solution out of 10 solutions found by the 2-approx heuristic and 1000 random solutions
function bestHeuristicMix(instance::PCInstance)
    nb1 = 500;
    nb2 = 500;
    nb = nb1 + nb2;

    solution = Array(UInt8,instance.n,nb)
    obj = zeros(UInt16,nb)

    for i = 1:nb1
        solution[:,i] = twoapprox_heuristic(instance);
        obj[i] = obj_value(solution[:,i], instance);
    end;


    for i = nb1+1:nb
        solution[:,i] = random_heuristic(instance);
        obj[i] = obj_value(solution[:,i], instance);
    end;
    
    bestZ = minimum(obj);
    bestSol = zeros(UInt8,instance.n)
    for i = 1:nb 
        if obj[i] == bestZ 
            bestSol = solution[:,i]
            break;
        end;
    end;
    
    return bestSol
end
