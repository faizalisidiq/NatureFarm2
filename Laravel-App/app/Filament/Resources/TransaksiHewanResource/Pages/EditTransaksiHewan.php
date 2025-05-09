<?php

namespace App\Filament\Resources\TransaksiHewanResource\Pages;

use App\Filament\Resources\TransaksiHewanResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditTransaksiHewan extends EditRecord
{
    protected static string $resource = TransaksiHewanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
