From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-format.txt: add a missing closing quote
Date: Mon,  8 Dec 2014 20:42:15 +0700
Message-ID: <1418046135-16377-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:32:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxyPv-0007Yo-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbaLHNbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:31:55 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39675 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaLHNbz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:31:55 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so5206639pad.41
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=fO2Tcxn06aZ6c8ASBiqbNWpRcoFSDxhbEecDVWHbnLs=;
        b=Z5JPSYIbdXnPtfrJzmJl249QK9Z7L6O0rU4HOvfKn8bHAa1rWgr71DbjcMaC6T5FGd
         HRTxDajuaDlpzTAFN+/2Jen72lInSgOrl/2Gm67dz2Cn+d3sUreWnUaKcFUKKoupeVBl
         zauVABnKmMkHmkFRek5qziK9g081TP7jtr/u6OUQ6sMQk8nSjqnxhd1T63a8R8lzi8Wa
         iTwg+pRdnr455otFEfWqv59hMPmLqqKW6ovlO01tEL03sN2LfO07EGd18k9R9gw9dqSe
         m+hTo+7RW5t1SLr5t2hXDft5tCQ+hHEoRUk+QDq1bQQAivbdgw919vdyH5mKIATV4O/U
         YLkg==
X-Received: by 10.70.109.174 with SMTP id ht14mr21234784pdb.74.1418045514608;
        Mon, 08 Dec 2014 05:31:54 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id j5sm36614237pdp.9.2014.12.08.05.31.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:31:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 20:42:30 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261015>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 1250b5c..35112e4 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -207,7 +207,7 @@ Git index format
   in a separate file. This extension records the changes to be made on
   top of that to produce the final index.
=20
-  The signature for this extension is { 'l', 'i, 'n', 'k' }.
+  The signature for this extension is { 'l', 'i', 'n', 'k' }.
=20
   The extension consists of:
=20
--=20
2.2.0.60.gb7b3c64
