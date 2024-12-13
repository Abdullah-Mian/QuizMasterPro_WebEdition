import React, { createContext, useState, useContext } from "react";

const QuestionsContext = createContext();

export const QuestionsProvider = ({ children }) => {
  const [questions, setQuestions] = useState([]);
  const [newFetched, setNewFetched] = useState(false);

  return (
    <QuestionsContext.Provider
      value={{ questions, setQuestions, newFetched, setNewFetched }}
    >
      {children}
    </QuestionsContext.Provider>
  );
};

export const useQuestions = () => useContext(QuestionsContext);
