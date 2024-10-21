import request from 'supertest';
import app from '../backend/app'; // Adjust the path to your Express app as needed
import User from '../backend/models/user.js';
import { hashPassword, comparePassword } from '../backend/helpers/auth.js';

describe('Auth Controller', () => {
  beforeAll(async () => {
    // Setup database connection or mock database here
    // If using a real database, you might want to clear the User collection
    await User.deleteMany({});
  });

  afterAll(async () => {
    // Cleanup database connection here
    await User.deleteMany({});
  });

  describe('User Registration', () => {
    it('should register a user successfully', async () => {
      const response = await request(app)
        .post('/api/register') // Ensure the route matches your actual API endpoint
        .send({
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          gender: 'male',
          dob: '1990-01-01',
          status: 'active',
          password: 'password123'
        });
      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Registration successful');
    });

    it('should return error for missing fields', async () => {
      const response = await request(app)
        .post('/api/register') // Ensure the route matches your actual API endpoint
        .send({ email: 'john@example.com' }); // Missing other fields
      expect(response.status).toBe(400);
      expect(response.body.error).toBe('All fields are required');
    });
  });

  describe('User Login', () => {
    it('should log in a user successfully', async () => {
      // First, register the user
      await request(app)
        .post('/api/register')
        .send({
          firstName: 'Jane',
          lastName: 'Doe',
          email: 'jane@example.com',
          gender: 'female',
          dob: '1990-01-01',
          status: 'active',
          password: 'password123'
        });

      const response = await request(app)
        .post('/api/login') // Ensure the route matches your actual API endpoint
        .send({
          email: 'jane@example.com',
          password: 'password123'
        });
      expect(response.status).toBe(200);
      expect(response.body.token).toBeDefined();
    });

    it('should return error for incorrect password', async () => {
      const response = await request(app)
        .post('/api/login') // Ensure the route matches your actual API endpoint
        .send({
          email: 'jane@example.com',
          password: 'wrongpassword'
        });
      expect(response.status).toBe(400);
      expect(response.body.error).toBe('Incorrect password');
    });
  });

  describe('JWT Middleware', () => {
    it('should deny access with invalid token', async () => {
      const response = await request(app)
        .get('/api/secret') // Ensure the route matches your actual API endpoint
        .set('Authorization', 'Bearer invalidtoken');
      expect(response.status).toBe(401);
      expect(response.body.error).toBe('Invalid token');
    });
  });
});
