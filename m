From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Fwd: [postmaster@vger.kernel.org: Delivery reports about your
	email [FAILED(1)]]
Date: Fri, 16 Nov 2007 20:35:30 +0200
Message-ID: <20071116183530.GI6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bYKqqI0BR1o6DFsM"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 16 19:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It62p-0008Rm-Sg
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 19:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760325AbXKPSfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbXKPSfh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 13:35:37 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:54535 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765696AbXKPSff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 13:35:35 -0500
Received: (mea@mea-ext) by mail.zmailer.org id S3540435AbXKPSfb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 20:35:31 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65239>


--bYKqqI0BR1o6DFsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a sample message that NEEDS proper charset mime tags.


--bYKqqI0BR1o6DFsM
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Received: from vger.kernel.org ([209.132.176.167]:50320 "EHLO vger.kernel.org"
	smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER-CN1: <none>
	rhost-flags-OK-OK-OK-OK) by mail.zmailer.org with ESMTP
	id S3540435AbXKPSSJ (ORCPT <rfc822;postoffice>);
	Fri, 16 Nov 2007 20:18:09 +0200
Received: (@vger.kernel.org) by vger.kernel.org id S1752741AbXKPSSH (ORCPT
	<rfc822;postoffice>); Fri, 16 Nov 2007 13:18:07 -0500
To:	stable-commits-owner@vger.kernel.org
From:	The Post Office <postmaster@vger.kernel.org>
Sender:	mailer-daemon@vger.kernel.org
Subject: Delivery reports about your email [FAILED(1)]
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="S1752741AbXKPSSH=_/vger.kernel.org"
Message-Id: <S1752741AbXKPSSH/20071116181807Z+29@vger.kernel.org>
Date:	Fri, 16 Nov 2007 13:18:07 -0500
Return-Path: <>
X-Envelope-To: <mea+vger.redhat.com> (uid 0)
X-Orcpt: rfc822;postoffice
Original-Recipient: rfc822;postoffice

This is MULTIPART/REPORT structured message as defined at RFC 1894.

Ask your email client software vendor, when will they support this
report format by showing its formal part in your preferred language.

--S1752741AbXKPSSH=_/vger.kernel.org
Content-Type: text/plain

This is a collection of reports about email delivery
process concerning a message you originated.

Some explanations/translations for these reports
can be found at:
      http://www.zmailer.org/delivery-report-decoding.html

Generic VGER note:  Joining/leaving VGER's lists thru server:
			majordomo@vger.kernel.org

Reporting-MTA: dns; vger.kernel.org
Return-Path: <stable-commits-owner@vger.kernel.org>
Arrival-Date: Fri, 16 Nov 2007 13:09:40 -0500
Local-Spool-ID: S1751399AbXKPSJk


FAILED:
  Original Recipient:
      rfc822;jfunk@funktronics.ca
  Final Recipient:
      RFC822;jfunk@funktronics.ca
  Status:
      5.1.1 (bad destination mailbox)
  Remote MTA:
      dns; elseed.funktronics.ca (65.61.206.36|25|209.132.176.167|48741)
  Last Attempt Date:
      Fri, 16 Nov 2007 13:10:02 -0500
  X-ZTAID:
      smtp[6139]
  Diagnostic Code:
      smtp; 550 (Error: improper use of 8-bit data in message body)
  Control data:
      smtp funktronics.ca jfunk@funktronics.ca 99
  Diagnostic texts:
      <<- MAIL From:<stable-commits-owner@vger.kernel.org> BODY=8BITMIME SIZE=3712
     ->> 250 Ok
     <<- RCPT To:<jfunk@funktronics.ca>
     ->> 250 Ok
     <<- DATA
     ->> 354 End data with <CR><LF>.<CR><LF>
     <<- .
     ->> 550 Error: improper use of 8-bit data in message body

Following is a copy of MESSAGE/DELIVERY-STATUS format section below.
It is copied here in case your email client is unable to show it to you.
The information here below is in  Internet Standard  format designed to
assist automatic, and accurate presentation and usage of said information.
In case you need human assistance from the Postmaster(s) of the system which
sent you this report, please include this information in your question!

    Virtually Yours,
        Automatic Email Delivery Software

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Fri, 16 Nov 2007 13:09:40 -0500
Local-Spool-ID: S1751399AbXKPSJk

Original-Recipient: rfc822;jfunk@funktronics.ca
Final-Recipient: RFC822;jfunk@funktronics.ca
Action: failed
Status: 5.1.1 (bad destination mailbox)
Remote-MTA: dns; elseed.funktronics.ca (65.61.206.36|25|209.132.176.167|48741)
Last-Attempt-Date: Fri, 16 Nov 2007 13:10:02 -0500
Diagnostic-Code: smtp; 550 (Error: improper use of 8-bit data in message body)


Following is copy of the message headers. Original message content may
be in subsequent parts of this MESSAGE/DELIVERY-STATUS structure.

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXKPSJk; Fri, 16 Nov 2007 13:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXKPSJk
	(ORCPT <rfc822;stable-commits-outgoing>);
	Fri, 16 Nov 2007 13:09:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:33829 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXKPSJj (ORCPT <rfc822;stable-commits@vger.kernel.org>);
	Fri, 16 Nov 2007 13:09:39 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 142E02BDB9;
	Fri, 16 Nov 2007 19:09:38 +0100 (CET)
Subject: patch tcp-make-sure-write_queue_from-does-not-begin-with-null-ptr.patch queued to -stable tree
To:	ilpo.jarvinen@helsinki.fi, davem@davemloft.net
Cc:	<stable@kernel.org>, <stable-commits@vger.kernel.org>
From:	<gregkh@suse.de>
Date:	Fri, 16 Nov 2007 10:08:58 -0800
Message-Id: <20071116180937.250A0144AB0C@imap.suse.de>
Sender:	stable-commits-owner@vger.kernel.org
Precedence: bulk
Reply-To: linux-kernel@vger.kernel.org
X-Mailing-List:	stable-commits@vger.kernel.org


--S1752741AbXKPSSH=_/vger.kernel.org
Content-Type: message/delivery-status

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Fri, 16 Nov 2007 13:09:40 -0500
Local-Spool-ID: S1751399AbXKPSJk

Original-Recipient: rfc822;jfunk@funktronics.ca
Final-Recipient: RFC822;jfunk@funktronics.ca
Action: failed
Status: 5.1.1 (bad destination mailbox)
Remote-MTA: dns; elseed.funktronics.ca (65.61.206.36|25|209.132.176.167|48741)
Last-Attempt-Date: Fri, 16 Nov 2007 13:10:02 -0500
Diagnostic-Code: smtp; 550 (Error: improper use of 8-bit data in message body)

--S1752741AbXKPSSH=_/vger.kernel.org
Content-Type: message/rfc822

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXKPSJk; Fri, 16 Nov 2007 13:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXKPSJk
	(ORCPT <rfc822;stable-commits-outgoing>);
	Fri, 16 Nov 2007 13:09:40 -0500
Received: from ns2.suse.de ([195.135.220.15]:33829 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbXKPSJj (ORCPT <rfc822;stable-commits@vger.kernel.org>);
	Fri, 16 Nov 2007 13:09:39 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 142E02BDB9;
	Fri, 16 Nov 2007 19:09:38 +0100 (CET)
Subject: patch tcp-make-sure-write_queue_from-does-not-begin-with-null-ptr.patch queued to -stable tree
To:	ilpo.jarvinen@helsinki.fi, davem@davemloft.net
Cc:	<stable@kernel.org>, <stable-commits@vger.kernel.org>
From:	<gregkh@suse.de>
Date:	Fri, 16 Nov 2007 10:08:58 -0800
Message-Id: <20071116180937.250A0144AB0C@imap.suse.de>
Sender:	stable-commits-owner@vger.kernel.org
Precedence: bulk
Reply-To: linux-kernel@vger.kernel.org
X-Mailing-List:	stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: TCP: Make sure write_queue_from does not begin with NULL ptr (CVE-2007-5501)

to the 2.6.23-stable tree.  Its filename is

     tcp-make-sure-write_queue_from-does-not-begin-with-null-ptr.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From 96a2d41a3e495734b63bff4e5dd0112741b93b38 Mon Sep 17 00:00:00 2001
From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
Date: Wed, 14 Nov 2007 15:47:18 -0800
Subject: TCP: Make sure write_queue_from does not begin with NULL ptr (CVE-2007-5501)

From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
patch 96a2d41a3e495734b63bff4e5dd0112741b93b38 in mainline.

NULL ptr can be returned from tcp_write_queue_head to cached_skb
and then assigned to skb if packets_out was zero. Without this,
system is vulnerable to a carefully crafted ACKs which obviously
is remotely triggerable.

Besides, there's very little that needs to be done in sacktag
if there weren't any packets outstanding, just skipping the rest
doesn't hurt.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
Signed-off-by: David S. Miller <davem@davemloft.net>

---
 net/ipv4/tcp_input.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1012,6 +1012,9 @@ tcp_sacktag_write_queue(struct sock *sk,
 	if (before(TCP_SKB_CB(ack_skb)->ack_seq, prior_snd_una - tp->max_window))
 		return 0;
 
+	if (!tp->packets_out)
+		goto out;
+
 	/* SACK fastpath:
 	 * if the only SACK change is the increase of the end_seq of
 	 * the first block then only apply that SACK block
@@ -1280,6 +1283,8 @@ tcp_sacktag_write_queue(struct sock *sk,
 	    (!tp->frto_highmark || after(tp->snd_una, tp->frto_highmark)))
 		tcp_update_reordering(sk, ((tp->fackets_out + 1) - reord), 0);
 
+out:
+
 #if FASTRETRANS_DEBUG > 0
 	BUG_TRAP((int)tp->sacked_out >= 0);
 	BUG_TRAP((int)tp->lost_out >= 0);


Patches currently in stable-queue which might be from ilpo.jarvinen@helsinki.fi are

queue-2.6.23/tcp-make-sure-write_queue_from-does-not-begin-with-null-ptr.patch
-
To unsubscribe from this list: send the line "unsubscribe stable-commits" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--S1752741AbXKPSSH=_/vger.kernel.org--

--bYKqqI0BR1o6DFsM--
