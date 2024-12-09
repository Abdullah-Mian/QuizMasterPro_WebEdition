// src/DegreePrograms.js
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "./AuthContext";
import { DegreeProgramsContext } from "./DegreeProgramsContext";

const DegreePrograms = () => {
  const { username, password } = useContext(AuthContext);
  const { degreePrograms, setDegreePrograms, courses, setCourses } = useContext(
    DegreeProgramsContext
  );
  const [expanded, setExpanded] = useState(null);

  useEffect(() => {
    const fetchDegreePrograms = async () => {
      try {
        const response = await fetch("http://localhost:3000/degreeprograms", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "x-username": username,
            "x-password": password,
          },
        });
        const data = await response.json();
        if (response.ok) {
          setDegreePrograms(data);
        } else {
          console.error("Failed to fetch degree programs:", data.error);
        }
      } catch (error) {
        console.error("Error fetching degree programs:", error);
      }
    };

    if (degreePrograms.length === 0) {
      fetchDegreePrograms();
    }
  }, [username, password, degreePrograms, setDegreePrograms]);

  const handleToggle = (degProg) => {
    if (expanded === degProg) {
      setExpanded(null);
    } else {
      setExpanded(degProg);
      if (!courses[degProg]) {
        console.log("course not found");
      }
    }
  };

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Degree Programs</h1>
      <div className="space-y-4">
        {degreePrograms.map((degProg, index) => (
          <div
            key={index}
            className="border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white"
          >
            <div
              className="flex justify-between items-center cursor-pointer"
              onClick={() => handleToggle(degProg.Deg_Prog)}
            >
              <span>
                {index + 1}. {degProg.Deg_Prog_Name}
              </span>
              <span>{expanded === degProg.Deg_Prog ? "▲" : "▼"}</span>
            </div>
            {expanded === degProg.Deg_Prog && (
              <div className="mt-4 space-y-2">
                {courses[degProg.Deg_Prog] ? (
                  courses[degProg.Deg_Prog].map((course, courseIndex) => (
                    <div
                      key={courseIndex}
                      className="pl-4 border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white"
                    >
                      {course.Course_Code} - {course.Course_Name}
                    </div>
                  ))
                ) : (
                  <p>Loading courses...</p>
                )}
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default DegreePrograms;
