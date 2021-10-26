/// <reference types="cypress" />

context('Sort Actions', () => {
    beforeEach(() => {
      cy.visit('')
    })
  
    it('sorting by yards', () => {
      cy.get('[data-qa="yds_sort_desc"]')
      .click()

      cy.get('tr').eq(2).get('td').eq(5).should('have.text', '1631')
    })

    it.skip('sorting by longest yards', () => {
      // more of the same tests
    })

    it.skip('sorting by most TDS', () => {
      // more of the same tests
    })
  
  })
  