<?php

namespace App\Filament\Resources\TransaksiHewanResource\Api\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTransaksiHewanRequest extends FormRequest
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
			'id_customer' => 'required',
			'id_hewan' => 'required',
			'harga' => 'required',
			'status' => 'required'
		];
    }
}
