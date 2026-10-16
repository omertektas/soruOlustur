"use client";

import { useState } from "react";
import { NEW_CATALOG_ENTRY, QUESTION_LIMITS } from "@/lib/validation";

interface CatalogSelectProps {
  /** Form field holding the selected id, or NEW_CATALOG_ENTRY. */
  selectName: string;
  /** Form field holding the suggested name when NEW_CATALOG_ENTRY is selected. */
  newName: string;
  label: string;
  newOptionLabel: string;
  newPlaceholder: string;
  options: { id: number; name: string }[];
  defaultValue?: string;
  defaultNewName?: string;
  error?: string;
}

/** Select an existing profession/topic, or type the name of a new one to suggest. */
export function CatalogSelect({
  selectName,
  newName,
  label,
  newOptionLabel,
  newPlaceholder,
  options,
  defaultValue = "",
  defaultNewName,
  error,
}: CatalogSelectProps) {
  const [value, setValue] = useState(defaultValue);
  const isNew = value === NEW_CATALOG_ENTRY;
  const { min, max } = QUESTION_LIMITS.catalogName;

  return (
    <div className="field">
      <label htmlFor={selectName}>{label}</label>
      <select
        id={selectName}
        name={selectName}
        className="input"
        value={value}
        onChange={(e) => setValue(e.target.value)}
        required
      >
        <option value="" disabled>
          Seçin
        </option>
        {options.map((o) => (
          <option key={o.id} value={o.id}>
            {o.name}
          </option>
        ))}
        <option value={NEW_CATALOG_ENTRY}>{newOptionLabel}</option>
      </select>
      {isNew && (
        <>
          <input
            id={newName}
            name={newName}
            className="input"
            defaultValue={defaultNewName}
            placeholder={newPlaceholder}
            aria-label={newPlaceholder}
            minLength={min}
            maxLength={max}
            required
            autoFocus
          />
          <small className="muted">Önerin, sorunla birlikte editör onayına gider.</small>
        </>
      )}
      {error && <small className="field-error">{error}</small>}
    </div>
  );
}
