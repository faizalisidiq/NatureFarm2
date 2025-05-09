<?php

namespace App\Filament\Resources\HewanResource\Pages;

use App\Filament\Resources\HewanResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditHewan extends EditRecord
{
    protected static string $resource = HewanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
