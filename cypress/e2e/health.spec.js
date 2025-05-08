// NOTE: For local testing, using 'localhost' as the domain. Replace with your domain or public IP for production
describe('Health Endpoint', () => {
  it('should return status ok', () => {
    cy.request('http://localhost/health').then((resp) => {
      expect(resp.status).to.eq(200);
      expect(resp.body.status).to.eq('ok');
    });
  });
}); 