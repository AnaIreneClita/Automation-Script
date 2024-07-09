STUDENTS =
{
    {name='Johnson', grade=10},
    {name='Kalvin', grade=9},
    {name='David', grade='a'},
    {name='Kaylee', grade=8},
    {name='Luiz', grade=7}
}


-- Searches the students list for a student with the targetStudentName, and prints their grade

function FindStudentGrade(targetStudentName)
    for i, student in ipairs(STUDENTS) do
        if student.name == targetStudentName then
            return student.grade
        end
    end
end

local studentGrade = FindStudentGrade('David')
print("The student's grade is " .. studentGrade)


-- Add functionality for finding the name of the student with the lowest grade

function ConvertGradesToNumbers()
    for i, student in ipairs(STUDENTS) do
        if type(student.grade) == "string" then
            student.grade = tonumber(student.grade)
        end
    end
end


function FindStudentWithLowestGrade()
    ConvertGradesToNumbers()
    local lowestGradeStudent = STUDENTS[1]
    for i, student in ipairs(STUDENTS) do
        if student.grade < lowestGradeStudent.grade then
            lowestGradeStudent = student
        end
    end
    return lowestGradeStudent.name, lowestGradeStudent.grade
end

local lowestGradeStudentName, lowestGrade = FindStudentWithLowestGrade()
        if lowestGradeStudentName then
           print("The student with the lowest grade is " .. lowestGradeStudentName .. " with a grade of " .. lowestGrade)
        end


-- Add functionality for finding the average grade of the students

function CalculateAverageGrade()
    ConvertGradesToNumbers()
    local totalGrades = 0
    local numStudents = #STUDENTS

    for i, student in ipairs(STUDENTS) do
        if student.grade ~= nil then 
        totalGrades = totalGrades + student.grade
         end
    end
    local averageGrade = totalGrades / numStudents

    return averageGrade
end

print(CalculateAverageGrade())


-- Add functionality for exporting the students list to a json file

function ExportStudentsToJson(filename)
    local file, err = io.open(filename, "w")
    if not file then
        print("Error: Unable to open file for writing: " .. err)
        return
    end

    file:write("[\n")
    for i, student in ipairs(STUDENTS) do
        file:write('    {"name":"' .. student.name .. '","grade":' .. student.grade .. '}')
        if i < #STUDENTS then
            file:write(",\n")
        else
            file:write("\n")
        end
    end
    file:write("]\n")

    file:close()
    print("Students list exported to " .. filename)
end


-- Add a way to choose which of the above functionalities to execute with commandline arguments, 
    --like ".\lua.exe .\ScriptTest.lua -average -export" only printing the average and exporting the student list to a json file

function main(...)
    local args = {...}
    if #args == 0 then
        print("Usage: lua script.lua -average -export")
        return
    end

    local executeAverage = false
    local executeExport = false

    for _, arg in ipairs(args) do
        if arg == "-average" then
            executeAverage = true
        elseif arg == "-export" then
            executeExport = true
        else
            print("Unknown argument: " .. tostring(arg))
            return
        end
    end

    if executeAverage then
        local average = CalculateAverageGrade()
        print("The average grade of all students is " .. average)
    end

    if executeExport then
        ExportStudentsToJson("students.json")
    end
end

main("-average", "-export")


-- Add any other functionality you think is cool!

function CoolFunctionality()
    for i, student in ipairs(STUDENTS) do
        if student.grade < 5 then 
            print(student.name .. " has a grade of " .. student.grade .. " and did not pass the exam. Better luck next time.")
        else
            print(student.name .. " has a grade of " .. student.grade .. " and passed the exam. Good job!")
        end
    end
end

CoolFunctionality()