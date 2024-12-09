// src/Progress.jsx
import React, { useContext } from "react";
import { ProgressContext } from "./ProgressContext";

const Progress = () => {
  const { progressData, loading, error } = useContext(ProgressContext);

  return (
    <div className="p-4">
      <h2 className="text-2xl font-bold mb-4">Progress</h2>
      {loading && <p>Loading...</p>}
      {error && <p>Error: {error}</p>}
      {!loading && !error && (
        <div className="space-y-4">
          {progressData.map((course, index) => (
            <div
              key={index}
              className="border-t border-b border-gray-300 rounded-lg p-4 bg-gray-800 text-white"
            >
              <div className="flex justify-between items-center">
                <span>
                  {course.Course_Code} - {course.Course_Name}
                </span>
                <span>Attempted Quizzes: {course.AttemptedQuizzes}</span>
                <span>Overall Progress: {course.Progress_Percentage}%</span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default Progress;
