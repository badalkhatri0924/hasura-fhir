SET check_function_bodies = false;
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.patient (
    id text NOT NULL,
    txid bigint NOT NULL,
    ts timestamp with time zone NOT NULL,
    resource_type text NOT NULL,
    status text NOT NULL,
    resource jsonb NOT NULL
);
CREATE VIEW public.patient_telecom AS
 SELECT p.id AS patient_id,
    (jsonb_array_elements((p.resource -> 'telecom'::text)) ->> 'use'::text) AS use,
    (jsonb_array_elements((p.resource -> 'telecom'::text)) ->> 'value'::text) AS value,
    (jsonb_array_elements((p.resource -> 'telecom'::text)) ->> 'system'::text) AS system
   FROM public.patient p;
ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);
