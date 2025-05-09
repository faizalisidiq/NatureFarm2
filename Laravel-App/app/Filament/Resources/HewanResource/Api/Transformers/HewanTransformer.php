<?php
namespace App\Filament\Resources\HewanResource\Api\Transformers;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Hewan;

/**
 * @property Hewan $resource
 */
class HewanTransformer extends JsonResource
{

    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        // return $this->resource->toArray();
        return [
            'id' => $this->resource->id,
            'nama_hewan' => $this->resource->nama_hewan,
            'jenis_kelamin' => $this->resource->jenis_kelamin,
        ];
    }
}
