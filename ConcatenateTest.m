function ConcatenateTest()

TestMatrix = [];
AddedMatrix = [1 2; 3 4];

for i = 1:10
    TestMatrix = cat(3, TestMatrix, AddedMatrix);
end

TestMatrix
