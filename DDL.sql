CREATE DATABASE mechanicalWorkshop;
USE mechanicalWorkshop;

CREATE TABLE person(
	idPerson INT AUTO_INCREMENT PRIMARY KEY,
    completeName VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    CPF CHAR(11),
    CNPJ CHAR(18),
    birthDate DATE,
    personalContact VARCHAR(20)
);

ALTER TABLE person AUTO_INCREMENT = 1;

CREATE TABLE mechanic(
	idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    idPerson_mechanic INT,
    companyID INT NOT NULL,
    speciality VARCHAR(50),
    CONSTRAINT unique_companyID_mechanic UNIQUE(companyID),
    CONSTRAINT fk_mechanic_person FOREIGN KEY(idPerson_mechanic) REFERENCES person(idPerson)
);

CREATE TABLE customer(
	idCustomer INT AUTO_INCREMENT PRIMARY KEY,
    idPerson_customer INT,
    email VARCHAR(50),
    CONSTRAINT unique_companyID_mechanic UNIQUE(companyID),
    CONSTRAINT fk_customer_person FOREIGN KEY(idPerson_customer) REFERENCES person(idPerson)
);

CREATE TABLE team(
	idTeam INT AUTO_INCREMENT PRIMARY KEY,
    teamName VARCHAR(45) NOT NULL,
    section VARCHAR(45) NOT NULL
);

CREATE TABLE team_has_mechanic(
	idTHM_mechanic INT,
    idTHM_team INT,
    teamLeader VARCHAR(50) NOT NULL,
    PRIMARY KEY(idTHM_mechanic, idTHM_team),
    CONSTRAINT fk_THM_mechanic FOREIGN KEY(idTHM_mechanic) REFERENCES mechanic(idMechanic),
    CONSTRAINT fk_THM_team FOREIGN KEY(idTHM_team) REFERENCES team(idTeam)
);

CREATE TABLE vehicle(
	idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idCustomer_vehicle INT,
    model VARCHAR(25) NOT NULL,
    licensePlate CHAR(7) NOT NULL,
    colors VARCHAR(50) NOT NULL,
    brand VARCHAR(25) NOT NULL,
    CONSTRAINT fk_vehicle_customer FOREIGN KEY(idCustomer_vehicle) REFERENCES customer(idCustomer)
);

CREATE TABLE serviceOrder(
	idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
    idSO_customer INT,
    idSO_vehicle INT,
    idSO_team INT,
    numberSO INT NOT NULL,
    statusSO ENUM('Processing', 'Reviewing', 'Troubleshooting ', 'Complete', 'Available') DEFAULT 'Processing',
    emissionDate DATE NOT NULL,
    completionDate DATE NOT NULL,
    valueSO FLOAT NOT NULL,
    servicesValue FLOAT NOT NULL,
    componentsValue FLOAT NOT NULL,
    CONSTRAINT fk_serviceOrder_customer FOREIGN KEY(idSO_customer) REFERENCES customer(idCustomer),
    CONSTRAINT fk_serviceOrder_vehicle FOREIGN KEY(idSO_vehicle) REFERENCES vehicle(idVehicle),
    CONSTRAINT fk_serviceOrder_team FOREIGN KEY(idSO_team) REFERENCES team(idTeam)
);

CREATE TABLE service(
	idService INT AUTO_INCREMENT PRIMARY KEY,
    serviceName VARCHAR(50) NOT NULL,
    averageTime INT NOT NULL
);

CREATE TABLE SO_has_service(
	idServiceOrder INT,
    idService INT,
    typeService ENUM('Revision', 'Maintenance') NOT NULL,
    totalAVGtime INT NOT NULL,
    PRIMARY KEY(idServiceOrder, idService),
    CONSTRAINT fk_soHservice_SO FOREIGN KEY(idServiceOrder) REFERENCES serviceOrder(idServiceOrder),
    CONSTRAINT fk_soHservice_service FOREIGN KEY(idService) REFERENCES service(idService)
);

CREATE TABLE valuesOfService(
	idvaluesOfService INT AUTO_INCREMENT PRIMARY KEY,
    idService INT,
    serviceValue FLOAT NOT NULL,
    CONSTRAINT fk_valuesOfService_service FOREIGN KEY(idService) REFERENCES service(idService)
);

CREATE TABLE SO_has_valuesService(
	idServiceOrder INT,
	idvaluesOfService INT,
    PRIMARY KEY (idServiceOrder, idvaluesOfService),
    CONSTRAINT fk_soHvaluesservice_serviceOrder FOREIGN KEY(idServiceOrder) REFERENCES serviceOrder(idServiceOrder),
    CONSTRAINT fk_soHvaluesservice_valuesOfService FOREIGN KEY(idvaluesOfService) REFERENCES valuesOfService(idvaluesOfService)
);

CREATE TABLE components(
	idComponent INT AUTO_INCREMENT PRIMARY KEY,
    componentName VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    cValue FLOAT NOT NULL
);

CREATE TABLE SO_has_component(
	idServiceOrder INT,
    idComponent INT,
    quantity INT NOT NULL,
    CONSTRAINT fk_soHcomponent_serviceOrder FOREIGN KEY(idServiceOrder) REFERENCES serviceOrder(idServiceOrder),
    CONSTRAINT fk_soHcomponent_components FOREIGN KEY(idComponent) REFERENCES components(idComponent)
);