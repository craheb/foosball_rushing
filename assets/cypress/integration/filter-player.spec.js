/// <reference types="cypress" />

context('Filter Actions', () => {
    beforeEach(() => {
      cy.visit('')
    })
  
    it('searching the name hill', () => {
      cy.get('[data-qa="filter_players"]')
      .type('hill')

      // If this was dynamic data, i would remove this assertion
      cy.get('table').find('tr').should('have.length', 8)

      cy.get('table').contains('td', 'hill').should('be.visible');
    })
  
  })
  