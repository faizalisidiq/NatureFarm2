<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('transaksi_hewans', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_customer')->constrained('customers', 'id')->onDelete('cascade');
            $table->foreignId('id_hewan')->constrained('hewans', 'id')->onDelete('cascade');
            $table->integer('harga');
            $table->string('status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaksi_hewans');
    }
};