From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: quilt/0.46-1 misbehaviour...
Date: Tue, 20 Nov 2007 07:51:49 +0200
Message-ID: <20071120055149.GQ6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1V9iWxIRAYJ05+DL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 06:53:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuM1s-0006ON-9M
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 06:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbXKTFvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 00:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753593AbXKTFvy
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 00:51:54 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:52978 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbXKTFvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 00:51:53 -0500
Received: (mea@mea-ext) by mail.zmailer.org id S3540296AbXKTFvt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 07:51:49 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65527>


--1V9iWxIRAYJ05+DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

.. or perhaps Exim, but odd result in arriving and thus outgoing headers anyway.


--1V9iWxIRAYJ05+DL
Content-Type: message/rfc822
Content-Disposition: inline

Received: from vger.kernel.org ([209.132.176.167]:60059 "EHLO vger.kernel.org"
	smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER-CN1: <none>
	rhost-flags-OK-OK-OK-OK) by mail.zmailer.org with ESMTP
	id S3540289AbXKTBXK (ORCPT <rfc822;postoffice>);
	Tue, 20 Nov 2007 03:23:10 +0200
Received: (@vger.kernel.org) by vger.kernel.org id S1758876AbXKTBXG (ORCPT
	<rfc822;postoffice>); Mon, 19 Nov 2007 20:23:06 -0500
To:	linux-kernel-owner@vger.kernel.org
From:	The Post Office <postmaster@vger.kernel.org>
Sender:	mailer-daemon@vger.kernel.org
Subject: Delivery reports about your email [FAILED(1)]
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="S1758876AbXKTBXG=_/vger.kernel.org"
Message-Id: <S1758876AbXKTBXG/20071120012306Z+1569@vger.kernel.org>
Date:	Mon, 19 Nov 2007 20:23:06 -0500
Return-Path: <>
X-Envelope-To: <mea+vger.redhat.com> (uid 0)
X-Orcpt: rfc822;postoffice
Original-Recipient: rfc822;postoffice

This is MULTIPART/REPORT structured message as defined at RFC 1894.

Ask your email client software vendor, when will they support this
report format by showing its formal part in your preferred language.

--S1758876AbXKTBXG=_/vger.kernel.org
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
Arrival-Date: Mon, 19 Nov 2007 20:16:57 -0500
Local-Spool-ID: S1757551AbXKTBQ5


FAILED:
  Original Recipient:
      rfc822;afds@cs.tu-berlin.de
  Final Recipient:
      RFC822;afds@cs.tu-berlin.de
  Status:
      5.6.0
  Remote MTA:
      dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|39031)
  Last Attempt Date:
      Mon, 19 Nov 2007 20:17:31 -0500
  X-ZTAID:
      smtp[14954]
  Diagnostic Code:
      smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")
  Control data:
      smtp cs.tu-berlin.de afds@cs.tu-berlin.de 99
  Diagnostic texts:
      <<- MAIL From:<linux-kernel-owner+afds=40cs.tu-berlin.de-S1757551AbXKTBQ5@vger.kernel.org> BODY=8BITMIME SIZE=5352
     ->> 250 2.1.0 Ok
     <<- RCPT To:<afds@cs.tu-berlin.de>
     ->> 250 2.1.5 Ok
     <<- DATA
     ->> 354 End data with <CR><LF>.<CR><LF>
     <<- .
     ->> 554 5.6.0 Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From"

Following is a copy of MESSAGE/DELIVERY-STATUS format section below.
It is copied here in case your email client is unable to show it to you.
The information here below is in  Internet Standard  format designed to
assist automatic, and accurate presentation and usage of said information.
In case you need human assistance from the Postmaster(s) of the system which
sent you this report, please include this information in your question!

    Virtually Yours,
        Automatic Email Delivery Software

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Mon, 19 Nov 2007 20:16:57 -0500
Local-Spool-ID: S1757551AbXKTBQ5

Original-Recipient: rfc822;afds@cs.tu-berlin.de
Final-Recipient: RFC822;afds@cs.tu-berlin.de
Action: failed
Status: 5.6.0
Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|39031)
Last-Attempt-Date: Mon, 19 Nov 2007 20:17:31 -0500
Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")


Following is copy of the message headers. Original message content may
be in subsequent parts of this MESSAGE/DELIVERY-STATUS structure.

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbXKTBQ5; Mon, 19 Nov 2007 20:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbXKTBNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Nov 2007 20:13:45 -0500
Received: from relay1.sgi.com ([192.48.171.29]:49836 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753655AbXKTBNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Nov 2007 20:13:34 -0500
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 2556E8F80AF;
	Mon, 19 Nov 2007 17:13:34 -0800 (PST)
Received: from clameter by schroedinger.engr.sgi.com with local (Exim 3.36 #1 (Debian))
	id 1IuHgE-0004iU-00; Mon, 19 Nov 2007 17:13:34 -0800
Message-Id: <20071120011333.850453474@sgi.com>
References: <20071120011132.143632442@sgi.com>
User-Agent: quilt/0.46-1
Date:	Mon, 19 Nov 2007 17:11:41 -0800
From:	clameter@sgi.com
From:	Christoph Lameter <clameter@sgi.com>
To:	ak@suse.de
Cc:	akpm@linux-foundation.org
Cc:	travis@sgi.com
Cc:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc:	linux-kernel@vger.kernel.org
Subject: [rfc 09/45] cpu alloc: IA64 support
Content-Disposition: inline; filename=cpu_alloc_ia64_support
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org


--S1758876AbXKTBXG=_/vger.kernel.org
Content-Type: message/delivery-status

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Mon, 19 Nov 2007 20:16:57 -0500
Local-Spool-ID: S1757551AbXKTBQ5

Original-Recipient: rfc822;afds@cs.tu-berlin.de
Final-Recipient: RFC822;afds@cs.tu-berlin.de
Action: failed
Status: 5.6.0
Remote-MTA: dns; cartero.cs.tu-berlin.de (130.149.17.20|25|209.132.176.167|39031)
Last-Attempt-Date: Mon, 19 Nov 2007 20:17:31 -0500
Diagnostic-Code: smtp; 554 (Reject, id=10432-16 - BAD_HEADER: Duplicate header field: "From")

--S1758876AbXKTBXG=_/vger.kernel.org
Content-Type: message/rfc822

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbXKTBQ5; Mon, 19 Nov 2007 20:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbXKTBNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Nov 2007 20:13:45 -0500
Received: from relay1.sgi.com ([192.48.171.29]:49836 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753655AbXKTBNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Nov 2007 20:13:34 -0500
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by relay1.corp.sgi.com (Postfix) with ESMTP id 2556E8F80AF;
	Mon, 19 Nov 2007 17:13:34 -0800 (PST)
Received: from clameter by schroedinger.engr.sgi.com with local (Exim 3.36 #1 (Debian))
	id 1IuHgE-0004iU-00; Mon, 19 Nov 2007 17:13:34 -0800
Message-Id: <20071120011333.850453474@sgi.com>
References: <20071120011132.143632442@sgi.com>
User-Agent: quilt/0.46-1
Date:	Mon, 19 Nov 2007 17:11:41 -0800
From:	clameter@sgi.com
From:	Christoph Lameter <clameter@sgi.com>
To:	ak@suse.de
Cc:	akpm@linux-foundation.org
Cc:	travis@sgi.com
Cc:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc:	linux-kernel@vger.kernel.org
Subject: [rfc 09/45] cpu alloc: IA64 support
Content-Disposition: inline; filename=cpu_alloc_ia64_support
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Typical use of per cpu memory for a small system of 8G 8p 4node is less than
64k per cpu memory. This is increasing rapidly for larger systems where we can
get up to 512k or 1M of memory used for cpu storage.

The maximum size allowed of the cpu area is 128MB of memory.

The cpu area is placed in region 5 with the kernel, vmemmap and vmalloc areas.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
---
 arch/ia64/Kconfig              |   13 +++++++++++++
 arch/ia64/kernel/vmlinux.lds.S |    2 ++
 include/asm-ia64/pgtable.h     |   32 ++++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig	2007-11-18 14:38:24.661283318 -0800
+++ linux-2.6/arch/ia64/Kconfig	2007-11-18 21:13:23.281093698 -0800
@@ -99,6 +99,19 @@ config AUDIT_ARCH
 	bool
 	default y
 
+config CPU_AREA_VIRTUAL
+	bool
+	default y
+
+# Maximum of 128 MB cpu_alloc space per cpu
+config CPU_AREA_ORDER
+	int
+	default "13"
+
+config CPU_AREA_ALLOC_ORDER
+	int
+	default "0"
+
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6/include/asm-ia64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/pgtable.h	2007-11-18 14:38:24.669283083 -0800
+++ linux-2.6/include/asm-ia64/pgtable.h	2007-11-18 21:13:23.296343624 -0800
@@ -224,21 +224,41 @@ ia64_phys_addr_valid (unsigned long addr
  */
 
 
+/*
+ * Layout of RGN_GATE
+ *
+ * 47 bits wide (16kb pages)
+ *
+ * 0xa000000000000000-0xa00000200000000	8G	Kernel data area
+ * 0xa000002000000000-0xa00040000000000	64T	vmalloc
+ * 0xa000400000000000-0xa00060000000000 32T	vmemmmap
+ * 0xa000600000000000-0xa00080000000000	32T	cpu area
+ *
+ * 55 bits wide (64kb pages)
+ *
+ * 0xa000000000000000-0xa00000200000000	8G	Kernel data area
+ * 0xa000002000000000-0xa04000000000000	16P	vmalloc
+ * 0xa040000000000000-0xa06000000000000 8P	vmemmmap
+ * 0xa060000000000000-0xa08000000000000	8P	cpu area
+ */
+
 #define VMALLOC_START		(RGN_BASE(RGN_GATE) + 0x200000000UL)
+#define VMALLOC_END_INIT	(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 10)))
+
 #ifdef CONFIG_VIRTUAL_MEM_MAP
-# define VMALLOC_END_INIT	(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
 # define VMALLOC_END		vmalloc_end
   extern unsigned long vmalloc_end;
 #else
+# define VMALLOC_END VMALLOC_END_INIT
+#endif
+
 #if defined(CONFIG_SPARSEMEM) && defined(CONFIG_SPARSEMEM_VMEMMAP)
 /* SPARSEMEM_VMEMMAP uses half of vmalloc... */
-# define VMALLOC_END		(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 10)))
-# define vmemmap		((struct page *)VMALLOC_END)
-#else
-# define VMALLOC_END		(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
-#endif
+# define vmemmap		((struct page *)VMALLOC_END_INIT)
 #endif
 
+#define CPU_AREA_BASE		(RGN_BASE(RGN_GATE) + (3UL << (4*PAGE_SHIFT - 11)))
+
 /* fs/proc/kcore.c */
 #define	kc_vaddr_to_offset(v) ((v) - RGN_BASE(RGN_GATE))
 #define	kc_offset_to_vaddr(o) ((o) + RGN_BASE(RGN_GATE))
Index: linux-2.6/arch/ia64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/vmlinux.lds.S	2007-11-18 21:13:46.505344120 -0800
+++ linux-2.6/arch/ia64/kernel/vmlinux.lds.S	2007-11-18 21:14:03.996593749 -0800
@@ -16,6 +16,8 @@ OUTPUT_FORMAT("elf64-ia64-little")
 OUTPUT_ARCH(ia64)
 ENTRY(phys_start)
 jiffies = jiffies_64;
+cpu_area = CPU_AREA_BASE;
+
 PHDRS {
   code   PT_LOAD;
   percpu PT_LOAD;

-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--S1758876AbXKTBXG=_/vger.kernel.org--

--1V9iWxIRAYJ05+DL--
