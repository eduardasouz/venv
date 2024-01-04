-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema maluly
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema maluly
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `maluly` DEFAULT CHARACTER SET utf8 ;
USE `maluly` ;

-- -----------------------------------------------------
-- Table `maluly`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Cliente` (
  `ClienteID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Telefone` VARCHAR(15) NOT NULL,
  `Senha` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ClienteID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `Senha_UNIQUE` (`Senha` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Fornecedor` (
  `FornecedorID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `CNPJ` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`FornecedorID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Endereco` (
  `EnderecoID` INT NOT NULL AUTO_INCREMENT,
  `Rua` VARCHAR(45) NOT NULL,
  `Numero` VARCHAR(45) NULL,
  `Cidade` VARCHAR(255) NOT NULL,
  `Estado` VARCHAR(255) NOT NULL,
  `CEP` VARCHAR(45) NOT NULL,
  `Bairro` VARCHAR(45) NOT NULL,
  `Complemento` VARCHAR(45) NULL,
  `ClienteID` INT NULL,
  `Fornecedor` INT NULL,
  PRIMARY KEY (`EnderecoID`),
  INDEX `ClienteID_idx` (`ClienteID` ASC) VISIBLE,
  INDEX `FornecedorID_idx` (`Fornecedor` ASC) VISIBLE,
  CONSTRAINT `ClienteID`
    FOREIGN KEY (`ClienteID`)
    REFERENCES `maluly`.`Cliente` (`ClienteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FornecedorID`
    FOREIGN KEY (`Fornecedor`)
    REFERENCES `maluly`.`Fornecedor` (`FornecedorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Carrinho` (
  `CarrinhoID` INT NOT NULL AUTO_INCREMENT,
  `ClienteID` INT NOT NULL,
  PRIMARY KEY (`CarrinhoID`),
  INDEX `Cliente1_idx` (`ClienteID` ASC) VISIBLE,
  CONSTRAINT `Cliente1`
    FOREIGN KEY (`ClienteID`)
    REFERENCES `maluly`.`Cliente` (`ClienteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Compra` (
  `IDCompra` INT NOT NULL AUTO_INCREMENT,
  `Total` FLOAT NOT NULL,
  `Carrinho_CarrinhoID` INT NOT NULL,
  `DataCompra` DATE NOT NULL,
  PRIMARY KEY (`IDCompra`, `Carrinho_CarrinhoID`),
  INDEX `fk_Compra_Carrinho1_idx` (`Carrinho_CarrinhoID` ASC) VISIBLE,
  CONSTRAINT `fk_Compra_Carrinho1`
    FOREIGN KEY (`Carrinho_CarrinhoID`)
    REFERENCES `maluly`.`Carrinho` (`CarrinhoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Marca` (
  `MarcaID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MarcaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Categoria` (
  `CategoriaID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CategoriaID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Poduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Poduto` (
  `PodutoID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NOT NULL,
  `preco` VARCHAR(45) NOT NULL,
  `Marca` INT NOT NULL,
  `Categoria` INT NOT NULL,
  PRIMARY KEY (`PodutoID`),
  INDEX `Marca_idx` (`Marca` ASC) VISIBLE,
  INDEX `Categoria_idx` (`Categoria` ASC) VISIBLE,
  CONSTRAINT `Marca`
    FOREIGN KEY (`Marca`)
    REFERENCES `maluly`.`Marca` (`MarcaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Categoria`
    FOREIGN KEY (`Categoria`)
    REFERENCES `maluly`.`Categoria` (`CategoriaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Estoque` (
  `EstoqueID` INT NOT NULL AUTO_INCREMENT,
  `Quantidade` FLOAT NOT NULL,
  `FornecedorID` INT NOT NULL,
  `ProdutoID` INT NOT NULL,
  PRIMARY KEY (`EstoqueID`),
  INDEX `Fornecedor1_idx` (`FornecedorID` ASC) VISIBLE,
  INDEX `Produto_idx` (`ProdutoID` ASC) VISIBLE,
  CONSTRAINT `Fornecedor1`
    FOREIGN KEY (`FornecedorID`)
    REFERENCES `maluly`.`Fornecedor` (`FornecedorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Produto`
    FOREIGN KEY (`ProdutoID`)
    REFERENCES `maluly`.`Poduto` (`PodutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Poduto_has_Carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Poduto_has_Carrinho` (
  `Poduto_PodutoID` INT NOT NULL,
  `Carrinho_CarrinhoID` INT NOT NULL,
  PRIMARY KEY (`Poduto_PodutoID`, `Carrinho_CarrinhoID`),
  INDEX `fk_Poduto_has_Carrinho_Carrinho1_idx` (`Carrinho_CarrinhoID` ASC) VISIBLE,
  INDEX `fk_Poduto_has_Carrinho_Poduto1_idx` (`Poduto_PodutoID` ASC) VISIBLE,
  CONSTRAINT `fk_Poduto_has_Carrinho_Poduto1`
    FOREIGN KEY (`Poduto_PodutoID`)
    REFERENCES `maluly`.`Poduto` (`PodutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Poduto_has_Carrinho_Carrinho1`
    FOREIGN KEY (`Carrinho_CarrinhoID`)
    REFERENCES `maluly`.`Carrinho` (`CarrinhoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Carrinho_has_Poduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Carrinho_has_Poduto` (
  `Carrinho_CarrinhoID` INT NOT NULL,
  `Poduto_PodutoID` INT NOT NULL,
  `Quantidade` INT NOT NULL,
  `Total` FLOAT NOT NULL,
  PRIMARY KEY (`Carrinho_CarrinhoID`, `Poduto_PodutoID`),
  INDEX `fk_Carrinho_has_Poduto_Poduto1_idx` (`Poduto_PodutoID` ASC) VISIBLE,
  INDEX `fk_Carrinho_has_Poduto_Carrinho1_idx` (`Carrinho_CarrinhoID` ASC) VISIBLE,
  CONSTRAINT `fk_Carrinho_has_Poduto_Carrinho1`
    FOREIGN KEY (`Carrinho_CarrinhoID`)
    REFERENCES `maluly`.`Carrinho` (`CarrinhoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Carrinho_has_Poduto_Poduto1`
    FOREIGN KEY (`Poduto_PodutoID`)
    REFERENCES `maluly`.`Poduto` (`PodutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maluly`.`Imagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maluly`.`Imagem` (
  `ImagemID` INT NOT NULL AUTO_INCREMENT,
  `URL` VARCHAR(255) NOT NULL,
  `Poduto_PodutoID` INT NOT NULL,
  PRIMARY KEY (`ImagemID`),
  INDEX `fk_Imagem_Poduto1_idx` (`Poduto_PodutoID` ASC) VISIBLE,
  CONSTRAINT `fk_Imagem_Poduto1`
    FOREIGN KEY (`Poduto_PodutoID`)
    REFERENCES `maluly`.`Poduto` (`PodutoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
