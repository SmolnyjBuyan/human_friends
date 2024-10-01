package org.example;

import org.example.animals.*;
import org.example.utils.AnimalFactory;
import org.example.utils.AnimalType;
import org.example.utils.Gender;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class DataBaseManager {
    private static final String PETS_TABLE_QUERY = "SELECT * FROM pets";
    private static final int ID_COLUMN_INDEX = 1;
    private static final int NAME_COLUMN_INDEX = 2;
    private static final int BIRTH_DATE_COLUMN_INDEX = 3;
    private static final int GENDER_COLUMN_INDEX = 4;
    private static final int TYPE_COLUMN_INDEX = 5;

    public ArrayList<Animal> getPets() throws SQLException {
        ArrayList<Animal> animals = new ArrayList<>();

        try (Connection connection = DataBaseConnect.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(PETS_TABLE_QUERY)) {
            while (resultSet.next()) {
                int id = resultSet.getInt(ID_COLUMN_INDEX);
                String name = resultSet.getString(NAME_COLUMN_INDEX);
                LocalDate birthDate = resultSet.getDate(BIRTH_DATE_COLUMN_INDEX).toLocalDate();
                String gender = resultSet.getString(GENDER_COLUMN_INDEX);
                int TypeId = resultSet.getInt(TYPE_COLUMN_INDEX);
                Animal animal = AnimalFactory.create(name, birthDate, Gender.get(gender), AnimalType.get(TypeId));
                animal.setId(id);
                animals.add(animal);
            }
        }
        return animals;
    }

    private PreparedStatement getInsertIntoPetsStatement(Pet pet) throws SQLException {
        String query = "INSERT INTO pets(name, birth_date, gender, pet_type_id) VALUES(?, ?, ?, ?)";
        PreparedStatement statement = DataBaseConnect.getConnection().prepareStatement(query);
        statement.setString(1, pet.getName());
        statement.setObject(2, pet.getBirthDate());
        statement.setString(3, pet.getGender().getTitle());
        statement.setInt(4, pet.getPetType().getId());
        return statement;
    }

    public void insertIntoCats(Cat cat) throws SQLException {
        try (PreparedStatement statement = getInsertIntoPetsStatement(cat)) {
            statement.addBatch();
            statement.addBatch("INSERT INTO cats(id) VALUES (LAST_INSERT_ID())");
            statement.executeBatch();
        }
    }

    public void insertIntoDogs(Dog dog) throws SQLException {
        try (PreparedStatement statement = getInsertIntoPetsStatement(dog)) {
            statement.addBatch();
            statement.addBatch("INSERT INTO dogs(id) VALUES (LAST_INSERT_ID())");
            statement.executeBatch();
        }
    }
    public void insertIntoHamsters(Hamster hamster) throws SQLException {
        try (PreparedStatement statement = getInsertIntoPetsStatement(hamster)) {
            statement.addBatch();
            statement.addBatch("INSERT INTO hamster(id) VALUES (LAST_INSERT_ID())");
            statement.executeBatch();
        }
    }
}
