<?php

namespace App\Controller;

use App\Entity\Invoice;
use App\Entity\InvoiceLines;
use App\Form\InvoiceFormType;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class NewInvoiceController extends AbstractController
{
    #[Route('/new/invoice', name: 'app_new_invoice')]
    public function index(Request $request, ManagerRegistry $docManage): Response
    {
        $manager = $docManage->getManager();
        $TVA = 18;
        $invoice = new Invoice();
        $line = new InvoiceLines();
        $invoice->getInvoicelines()->add($line);
        $form = $this->createForm(InvoiceFormType::class, $invoice);

        if ($request->isMethod('POST') && $form->handleRequest($request)->isValid()) {
            $lines = $invoice->getInvoicelines();

            $last_id =  $manager->getRepository(Invoice::class)->findOneBy([], ['id' => 'desc']);
            $invoice->setNumberInvoice($last_id ?  (int)$last_id->getId() + 1 : 1);
            $manager->persist($invoice);
            foreach($lines as $singleLine ){
                $amount_without_vat = $singleLine->getQuantity() * $singleLine->getAmount();
                $amount_vat = ($amount_without_vat * $TVA) / 100;
                $total = $amount_vat + $amount_without_vat;
                $singleLine->setTotal($total);
                $singleLine->setVatAmount($amount_vat);
                $singleLine->setInvoice($invoice);

                $manager->persist($singleLine);
            }

            $manager->flush();
            unset($form);
            unset($invoice);
            unset($line);
            $invoice = new Invoice();
            $line = new InvoiceLines();
            $invoice->getInvoiceLines()->add($line);
            $form = $this->createForm(InvoiceFormType::class, $invoice);
        }
        return $this->render('new_invoice/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
