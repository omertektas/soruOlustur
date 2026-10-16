"use client";

import Link from "next/link";
import { useActionState, useState } from "react";
import { Markdown } from "@/lib/markdown";
import { routes } from "@/lib/site";
import { DIFFICULTIES, DIFFICULTY_LABELS, type Profession, type Topic } from "@/lib/types";
import { QUESTION_LIMITS } from "@/lib/validation";
import { submitQuestion, type SubmitState } from "./actions";
import { CatalogSelect } from "./CatalogSelect";

export function QuestionForm({ professions, topics }: { professions: Profession[]; topics: Topic[] }) {
  const [state, action, pending] = useActionState<SubmitState, FormData>(submitQuestion, {
    status: "idle",
    attempt: 0,
  });
  const [answer, setAnswer] = useState("");
  const [preview, setPreview] = useState(false);

  if (state.status === "success") {
    return (
      <div className="notice notice-success form-done" role="status">
        <h2>Teşekkürler, sorun alındı!</h2>
        <p>Editörlerimiz inceledikten sonra yayına alınacak. Durumunu hesabından takip edebilirsin.</p>
        <div className="row">
          <Link href={routes.account} className="btn">
            Sorularımı gör
          </Link>
          <a href={routes.submit} className="btn btn-ghost">
            Yeni soru ekle
          </a>
        </div>
      </div>
    );
  }

  const v = state.values ?? {};
  const err = state.errors ?? {};

  return (
    // Re-mount after each attempt so the fields are refilled with the submitted values
    <form action={action} className="form" key={state.attempt}>
      <input type="text" name="website" tabIndex={-1} autoComplete="off" className="hp" aria-hidden="true" />

      <div className="grid-2">
        <CatalogSelect
          selectName="professionId"
          newName="newProfession"
          label="Meslek"
          newOptionLabel="+ Listede yok, yeni meslek öner"
          newPlaceholder="Örn: Veri Bilimci"
          options={professions}
          defaultValue={v.professionId}
          defaultNewName={v.newProfession}
          error={err.profession}
        />
        <CatalogSelect
          selectName="topicId"
          newName="newTopic"
          label="Konu"
          newOptionLabel="+ Listede yok, yeni konu öner"
          newPlaceholder="Örn: Makine Öğrenmesi"
          options={topics}
          defaultValue={v.topicId}
          defaultNewName={v.newTopic}
          error={err.topic}
        />
      </div>

      <fieldset className="field">
        <legend>Zorluk</legend>
        <div className="chips">
          {DIFFICULTIES.map((d) => (
            <label key={d} className="chip chip-radio">
              <input type="radio" name="difficulty" value={d} defaultChecked={v.difficulty === d} required />
              {DIFFICULTY_LABELS[d]}
            </label>
          ))}
        </div>
        {err.difficulty && <small className="field-error">{err.difficulty}</small>}
      </fieldset>

      <div className="field">
        <label htmlFor="title">Soru</label>
        <input
          id="title"
          name="title"
          className="input"
          defaultValue={v.title}
          required
          minLength={QUESTION_LIMITS.title.min}
          maxLength={QUESTION_LIMITS.title.max}
          placeholder="Örn: TCP ile UDP arasındaki fark nedir?"
        />
        {err.title && <small className="field-error">{err.title}</small>}
      </div>

      <div className="field">
        <div className="field-head">
          <label htmlFor="answer">Cevap</label>
          <button type="button" className="linkish" onClick={() => setPreview((p) => !p)}>
            {preview ? "Düzenle" : "Önizle"}
          </button>
        </div>
        <textarea
          id="answer"
          name="answer"
          className="input textarea"
          defaultValue={v.answer}
          onChange={(e) => setAnswer(e.target.value)}
          required
          minLength={QUESTION_LIMITS.answer.min}
          maxLength={QUESTION_LIMITS.answer.max}
          rows={12}
          hidden={preview}
        />
        {preview && (
          <div className="preview">
            {answer.trim() ? <Markdown source={answer} /> : <p className="muted">Önizlenecek bir şey yok.</p>}
          </div>
        )}
        <small className="muted">
          Biçimlendirme: boş satırla paragraf, <code>- madde</code> ile liste, <code>`kod`</code>, <code>**kalın**</code>, kod
          blokları için <code>```</code>.
        </small>
        {err.answer && <small className="field-error">{err.answer}</small>}
      </div>

      <div className="field">
        <label htmlFor="tip">
          Mülakat ipucu <span className="muted">(isteğe bağlı)</span>
        </label>
        <input
          id="tip"
          name="tip"
          className="input"
          defaultValue={v.tip}
          maxLength={QUESTION_LIMITS.tip.max}
          placeholder="Mülakatçının duymak istediği ek bir detay"
        />
        {err.tip && <small className="field-error">{err.tip}</small>}
      </div>

      {state.status === "error" && state.message && (
        <p className="notice notice-error" role="alert">
          {state.message}
        </p>
      )}

      <button type="submit" className="btn btn-lg" disabled={pending}>
        {pending ? "Gönderiliyor…" : "Onaya gönder"}
      </button>
    </form>
  );
}
