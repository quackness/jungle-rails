/// <reference types="cypress" />
describe('Jungle rails app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("should click the Add to Cart on the home page and in doing so their cart increases by one.", () => {
    cy.get(".btn").first().click({force:true});
    cy.get(".nav-link").contains(1)

  })

});