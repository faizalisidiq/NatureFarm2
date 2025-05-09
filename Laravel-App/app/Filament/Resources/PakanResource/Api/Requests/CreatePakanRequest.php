<?php

namespace App\Filament\Resources\PakanResource\Api\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CreatePakanRequest extends FormRequest
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
			'nama_pakan' => 'required',
			'deskripsi' => 'required',
			'stok' => 'required',
			'status' => 'required',
			'gambar' => 'required'
		];
    }
}
