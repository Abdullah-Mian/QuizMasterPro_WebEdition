// src/EnrollStudent.js
import React, { useState, useContext } from "react";
import { DegreeProgramsContext } from "./DegreeProgramsContext";
import { AuthContext } from "./AuthContext";

const EnrollStudent = () => {
  const { degreePrograms, courses } = useContext(DegreeProgramsContext);
  const { username, password } = useContext(AuthContext);
  const [studentName, setStudentName] = useState("");
  const [studentUsername, setStudentUsername] = useState("");
  const [studentPassword, setStudentPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [selectedDegProg, setSelectedDegProg] = useState("");
  const [selectedCourses, setSelectedCourses] = useState([]);
  const [message, setMessage] = useState("");

  const handleDegProgChange = (e) => {
    setSelectedDegProg(e.target.value);
    setSelectedCourses([]);
  };

  const handleCourseToggle = (courseId) => {
    setSelectedCourses((prevSelectedCourses) =>
      prevSelectedCourses.includes(courseId)
        ? prevSelectedCourses.filter((id) => id !== courseId)
        : [...prevSelectedCourses, courseId]
    );
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (studentPassword !== confirmPassword) {
      setMessage("Passwords do not match");
      return;
    }
    console.log("Enrolling student with data:", {
      studentName,
      studentUsername,
      studentPassword,
      selectedDegProg,
      selectedCourses,
    });
    try {
      const response = await fetch("http://localhost:3000/enrollstudent", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "x-username": username,
          "x-password": password,
        },
        body: JSON.stringify({
          studentName,
          studentUsername,
          studentPassword,
          degreeProgram: selectedDegProg,
          courses: selectedCourses,
        }),
      });
      const data = await response.json();
      if (response.ok) {
        setMessage("Student enrolled successfully");
      } else {
        setMessage(data.error || "Failed to enroll student");
      }
    } catch (error) {
      setMessage("Error connecting to server");
    }
  };

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Enroll Student</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-[#07ada0]">Student Name</label>
          <input
            type="text"
            value={studentName}
            onChange={(e) => setStudentName(e.target.value)}
            className="w-full p-2 border text-black border-gray-300 rounded"
            required
          />
        </div>
        <div>
          <label className="block text-[#07ada0]">Username</label>
          <input
            type="text"
            value={studentUsername}
            onChange={(e) => setStudentUsername(e.target.value)}
            className="w-full p-2 border text-black border-gray-300 rounded"
            required
          />
        </div>
        <div>
          <label className="block text-[#07ada0]">Password</label>
          <input
            type="password"
            value={studentPassword}
            onChange={(e) => setStudentPassword(e.target.value)}
            className="w-full p-2 border text-black border-gray-300 rounded"
            required
          />
        </div>
        <div>
          <label className="block text-[#07ada0]">Confirm Password</label>
          <input
            type="password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            className="w-full p-2 border text-black border-gray-300 rounded"
            required
          />
        </div>
        <div>
          <label className="block text-[#07ada0]">Degree Program</label>
          <select
            value={selectedDegProg}
            onChange={handleDegProgChange}
            className="w-full p-2 border text-black border-gray-300 rounded"
            required
          >
            <option value="" className="text-black">
              Select Degree Program
            </option>
            {degreePrograms.map((degProg) => (
              <option
                key={degProg.Deg_Prog}
                value={degProg.Deg_Prog}
                className="text-black"
              >
                {degProg.Deg_Prog_Name}
              </option>
            ))}
          </select>
        </div>
        {selectedDegProg && (
          <div>
            <label className="block text-[#07ada0]">Courses</label>
            <div className="space-y-2">
              {courses[selectedDegProg]?.map((course) => (
                <div key={course.Course_id} className="flex items-center">
                  <input
                    type="checkbox"
                    id={`course-${course.Course_id}`}
                    checked={selectedCourses.includes(course.Course_id)}
                    onChange={() => handleCourseToggle(course.Course_id)}
                    className="mr-2"
                  />
                  <label htmlFor={`course-${course.Course_id}`}>
                    {course.Course_Code} - {course.Course_Name}
                  </label>
                </div>
              ))}
            </div>
          </div>
        )}
        <button
          type="submit"
          className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
        >
          Enroll
        </button>
      </form>
      {message && <p className="mt-4">{message}</p>}
    </div>
  );
};

export default EnrollStudent;
