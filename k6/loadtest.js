// NOTE: For local testing, using 'localhost' as the domain. Replace with your domain or public IP for production.
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  let res = http.get('http://localhost/health');
  check(res, { 'status was 200': (r) => r.status == 200 });
  sleep(1);
} 