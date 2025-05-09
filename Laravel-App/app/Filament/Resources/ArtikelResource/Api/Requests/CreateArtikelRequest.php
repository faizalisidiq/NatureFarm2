<?php

namespace App\Filament\Resources\ArtikelResource\Api\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreateArtikelRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
			'judul_artikel' => 'required',
			'isi_artikel' => 'required|string',
			'gambar' => 'required'
		];
    }
}
