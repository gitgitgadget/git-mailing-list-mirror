From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: quilt upsets some recipient sites..
Date: Tue, 6 Nov 2007 22:12:10 +0200
Message-ID: <20071106201210.GN6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ndbNBr9ZfQRJt18g"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUmi-0000Bv-Bw
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbXKFUMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbXKFUMM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:12:12 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:47992 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754224AbXKFUML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:12:11 -0500
Received: (mea@mea-ext) by mail.zmailer.org id S3540034AbXKFUMK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 22:12:10 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63711>


--ndbNBr9ZfQRJt18g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In my opinnion "Cc:" isn't a field where multiple occurrances are
in itself a sign of spam, but there are a lot of such sites..


--ndbNBr9ZfQRJt18g
Content-Type: message/rfc822
Content-Disposition: inline

Received: from vger.kernel.org ([209.132.176.167]:57954 "EHLO vger.kernel.org"
	smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER-CN1: <none>
	rhost-flags-OK-OK-OK-OK) by mail.zmailer.org with ESMTP
	id S3540033AbXKFUII (ORCPT <rfc822;postoffice>);
	Tue, 6 Nov 2007 22:08:08 +0200
Received: (@vger.kernel.org) by vger.kernel.org id S1754534AbXKFUIG (ORCPT
	<rfc822;postoffice>); Tue, 6 Nov 2007 15:08:06 -0500
To:	linux-kernel-owner@vger.kernel.org
From:	The Post Office <postmaster@vger.kernel.org>
Sender:	mailer-daemon@vger.kernel.org
Subject: Delivery reports about your email [FAILED(1)]
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="S1754534AbXKFUIG=_/vger.kernel.org"
Message-Id: <S1754534AbXKFUIG/20071106200806Z+207@vger.kernel.org>
Date:	Tue, 6 Nov 2007 15:08:06 -0500
Return-Path: <>
X-Envelope-To: <mea+vger.redhat.com> (uid 0)
X-Orcpt: rfc822;postoffice
Original-Recipient: rfc822;postoffice

This is MULTIPART/REPORT structured message as defined at RFC 1894.

Ask your email client software vendor, when will they support this
report format by showing its formal part in your preferred language.

--S1754534AbXKFUIG=_/vger.kernel.org
Content-Type: text/plain

This is a collection of reports about email delivery
process concerning a message you originated.

Some explanations/translations for these reports
can be found at:
      http://www.zmailer.org/delivery-report-decoding.html

Generic VGER note:  Joining/leaving VGER's lists thru server:
			majordomo@vger.kernel.org

Reporting-MTA: dns; vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
Arrival-Date: Tue, 6 Nov 2007 14:58:34 -0500
Local-Spool-ID: S1755552AbXKFT6e


FAILED:
  Original Recipient:
      rfc822;afds@cs.tu-berlin.de
  Final Recipient:
      RFC822;afds@cs.tu-berlin.de
  Status:
      5.6.0
  Remote MTA:
      dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|33024)
  Last Attempt Date:
      Tue, 6 Nov 2007 14:59:06 -0500
  X-ZTAID:
      smtp[31080]
  Diagnostic Code:
      smtp; 554 (Reject, id=18169-17 - BAD_HEADER: Header field occurs more than once: "Cc" occurs 5 times)
  Control data:
      smtp cs.tu-berlin.de afds@cs.tu-berlin.de 99
  Diagnostic texts:
      <<- MAIL From:<linux-kernel-owner+afds=40cs.tu-berlin.de-S1755552AbXKFT6e@vger.kernel.org> BODY=8BITMIME SIZE=4115
     ->> 250 2.1.0 Ok
     <<- RCPT To:<afds@cs.tu-berlin.de>
     ->> 250 2.1.5 Ok
     <<- DATA
     ->> 354 End data with <CR><LF>.<CR><LF>
     <<- .
     ->> 554 5.6.0 Reject, id=18169-17 - BAD_HEADER: Header field occurs more than once: "Cc" occurs 5 times

Following is a copy of MESSAGE/DELIVERY-STATUS format section below.
It is copied here in case your email client is unable to show it to you.
The information here below is in  Internet Standard  format designed to
assist automatic, and accurate presentation and usage of said information.
In case you need human assistance from the Postmaster(s) of the system which
sent you this report, please include this information in your question!

    Virtually Yours,
        Automatic Email Delivery Software

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Tue, 6 Nov 2007 14:58:34 -0500
Local-Spool-ID: S1755552AbXKFT6e

Original-Recipient: rfc822;afds@cs.tu-berlin.de
Final-Recipient: RFC822;afds@cs.tu-berlin.de
Action: failed
Status: 5.6.0
Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|33024)
Last-Attempt-Date: Tue, 6 Nov 2007 14:59:06 -0500
Diagnostic-Code: smtp; 554 (Reject, id=18169-17 - BAD_HEADER: Header field occurs more than once: "Cc" occurs 5 times)


Following is copy of the message headers. Original message content may
be in subsequent parts of this MESSAGE/DELIVERY-STATUS structure.

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXKFT6e; Tue, 6 Nov 2007 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbXKFTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Nov 2007 14:52:30 -0500
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:45386 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754321AbXKFTwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Nov 2007 14:52:04 -0500
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 20E6D908B3;
	Tue,  6 Nov 2007 11:52:04 -0800 (PST)
Received: from clameter by schroedinger.engr.sgi.com with local (Exim 3.36 #1 (Debian))
	id 1IpUSx-0008Jf-00; Tue, 06 Nov 2007 11:52:04 -0800
Message-Id: <20071106195203.825244760@sgi.com>
References: <20071106195144.983665861@sgi.com>
User-Agent: quilt/0.46-1
Date:	Tue, 06 Nov 2007 11:52:11 -0800
From:	Christoph Lameter <clameter@sgi.com>
To:	akpm@linux-foundation.org
Cc:	linux-mm@vger.kernel.org
Cc:	linux-kernel@vger.kernel.org
Cc:	David Miller <davem@davemloft.net>
Cc:	Eric Dumazet <dada1@cosmosbay.com>
Cc:	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/28] cpu alloc: Use in the crypto subsystem.
Content-Disposition: inline; filename=cpu_alloc_crypto
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org


--S1754534AbXKFUIG=_/vger.kernel.org
Content-Type: message/delivery-status

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Tue, 6 Nov 2007 14:58:34 -0500
Local-Spool-ID: S1755552AbXKFT6e

Original-Recipient: rfc822;afds@cs.tu-berlin.de
Final-Recipient: RFC822;afds@cs.tu-berlin.de
Action: failed
Status: 5.6.0
Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|33024)
Last-Attempt-Date: Tue, 6 Nov 2007 14:59:06 -0500
Diagnostic-Code: smtp; 554 (Reject, id=18169-17 - BAD_HEADER: Header field occurs more than once: "Cc" occurs 5 times)

--S1754534AbXKFUIG=_/vger.kernel.org
Content-Type: message/rfc822

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552AbXKFT6e; Tue, 6 Nov 2007 14:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757493AbXKFTwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Nov 2007 14:52:30 -0500
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:45386 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754321AbXKFTwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Nov 2007 14:52:04 -0500
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 20E6D908B3;
	Tue,  6 Nov 2007 11:52:04 -0800 (PST)
Received: from clameter by schroedinger.engr.sgi.com with local (Exim 3.36 #1 (Debian))
	id 1IpUSx-0008Jf-00; Tue, 06 Nov 2007 11:52:04 -0800
Message-Id: <20071106195203.825244760@sgi.com>
References: <20071106195144.983665861@sgi.com>
User-Agent: quilt/0.46-1
Date:	Tue, 06 Nov 2007 11:52:11 -0800
From:	Christoph Lameter <clameter@sgi.com>
To:	akpm@linux-foundation.org
Cc:	linux-mm@vger.kernel.org
Cc:	linux-kernel@vger.kernel.org
Cc:	David Miller <davem@davemloft.net>
Cc:	Eric Dumazet <dada1@cosmosbay.com>
Cc:	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/28] cpu alloc: Use in the crypto subsystem.
Content-Disposition: inline; filename=cpu_alloc_crypto
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 crypto/async_tx/async_tx.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6/crypto/async_tx/async_tx.c
===================================================================
--- linux-2.6.orig/crypto/async_tx/async_tx.c	2007-11-05 09:46:04.000000000 -0800
+++ linux-2.6/crypto/async_tx/async_tx.c	2007-11-05 09:49:56.000000000 -0800
@@ -207,10 +207,10 @@ static void async_tx_rebalance(void)
 	for_each_dma_cap_mask(cap, dma_cap_mask_all)
 		for_each_possible_cpu(cpu) {
 			struct dma_chan_ref *ref =
-				per_cpu_ptr(channel_table[cap], cpu)->ref;
+				CPU_PTR(channel_table[cap], cpu)->ref;
 			if (ref) {
 				atomic_set(&ref->count, 0);
-				per_cpu_ptr(channel_table[cap], cpu)->ref =
+				CPU_PTR(channel_table[cap], cpu)->ref =
 									NULL;
 			}
 		}
@@ -223,7 +223,7 @@ static void async_tx_rebalance(void)
 			else
 				new = get_chan_ref_by_cap(cap, -1);
 
-			per_cpu_ptr(channel_table[cap], cpu)->ref = new;
+			CPU_PTR(channel_table[cap], cpu)->ref = new;
 		}
 
 	spin_unlock_irqrestore(&async_tx_lock, flags);
@@ -327,7 +327,8 @@ async_tx_init(void)
 	clear_bit(DMA_INTERRUPT, dma_cap_mask_all.bits);
 
 	for_each_dma_cap_mask(cap, dma_cap_mask_all) {
-		channel_table[cap] = alloc_percpu(struct chan_ref_percpu);
+		channel_table[cap] = CPU_ALLOC(struct chan_ref_percpu,
+						GFP_KERNEL | __GFP_ZERO);
 		if (!channel_table[cap])
 			goto err;
 	}
@@ -343,7 +344,7 @@ err:
 	printk(KERN_ERR "async_tx: initialization failure\n");
 
 	while (--cap >= 0)
-		free_percpu(channel_table[cap]);
+		CPU_FRE(channel_table[cap]);
 
 	return 1;
 }
@@ -356,7 +357,7 @@ static void __exit async_tx_exit(void)
 
 	for_each_dma_cap_mask(cap, dma_cap_mask_all)
 		if (channel_table[cap])
-			free_percpu(channel_table[cap]);
+			CPU_FREE(channel_table[cap]);
 
 	dma_async_client_unregister(&async_tx_dma);
 }
@@ -378,7 +379,7 @@ async_tx_find_channel(struct dma_async_t
 	else if (likely(channel_table_initialized)) {
 		struct dma_chan_ref *ref;
 		int cpu = get_cpu();
-		ref = per_cpu_ptr(channel_table[tx_type], cpu)->ref;
+		ref = CPU_PTR(channel_table[tx_type], cpu)->ref;
 		put_cpu();
 		return ref ? ref->chan : NULL;
 	} else

-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--S1754534AbXKFUIG=_/vger.kernel.org--

--ndbNBr9ZfQRJt18g--
