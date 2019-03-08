function errMsg(err)
switch err
    case -21
        fprintf('\nThere is a node with one child (function -> treeDoctor)\n');
	case -22
        fprintf('\nA leaf node with child (function -> treeDoctor)\n');
    case -23
        fprintf('\nH and/or V property as a leaf node (function -> treeDoctor)\n');
    case -24
        fprintf('\nA node(s) should appears more than once (function -> treeDoctor)\n');
    case -25
        fprintf('\nA node(s) should be absent (function -> treeDoctor)\n');
    case -26
        fprintf('\nBalloting property violated (function -> treeDoctor)\n');
end
end