From: Linus Arver <linusarver@gmail.com>
Subject: [PATCH 1/7] Documentation: git-init: typographical fixes
Date: Sat,  2 Aug 2014 11:06:51 -0700
Message-ID: <1407002817-29221-2-git-send-email-linusarver@gmail.com>
References: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Cc: Steven Drake <sdrake@xnet.co.nz>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Linus Arver <linusarver@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 20:07:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDdif-0007Yz-9K
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 20:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbaHBSHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 14:07:45 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:54132 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbaHBSHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 14:07:44 -0400
Received: by mail-yh0-f51.google.com with SMTP id f73so3307244yha.24
        for <git@vger.kernel.org>; Sat, 02 Aug 2014 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g98Bs9v6gV9pFxy6PmH9J7LvKtlIR/IpnFagfm7q/RY=;
        b=wZI0G14Aji5/fT3Fki9zshMCw32VjIodC241FzsKKuWcgjE+RH5dNKL6YjOfI5Z0kb
         P6GDFdH8rt9hyiT1l5MkfK8CiwKY+BM9m4cnKoboOlAdgGy+qhpEtvaVHbWBj/C0DcTt
         tXpKu513kXCU1icRO+vZ7W9liDY02cTeG77WpC0cPFqmFDgP1Z5onK3g5uVL1r9muatZ
         m3ZXBcXspqzHVrZL3mfc/YRSOe1pO72SAuQheB2YFyY09TEUUoTL0WuI9k1DC4Pp9EHy
         u/+ATaLLhuEzxKyJCKdTZwpL9TNZCAGrHcgjAqNmZi9P5wPcNh+vZ+cCJ2wDrZTOkRYP
         nv8Q==
X-Received: by 10.236.148.209 with SMTP id v57mr20447169yhj.140.1407002864234;
        Sat, 02 Aug 2014 11:07:44 -0700 (PDT)
Received: from k0.localdomain (107-223-14-32.lightspeed.sntcca.sbcglobal.net. [107.223.14.32])
        by mx.google.com with ESMTPSA id i24sm20618668yha.12.2014.08.02.11.07.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Aug 2014 11:07:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1407002817-29221-1-git-send-email-linusarver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254706>

Signed-off-by: Linus Arver <linusarver@gmail.com>
---
 Documentation/git-init.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index afd721e..5ed5859 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -43,7 +43,7 @@ OPTIONS
 -q::
 --quiet::
 
-Only print error and warning messages, all other output will be suppressed.
+Only print error and warning messages; all other output will be suppressed.
 
 --bare::
 
@@ -97,7 +97,7 @@ is given:
    create a repo that is readable and writable to the current user and group,
    but inaccessible to others.
 
-By default, the configuration flag receive.denyNonFastForwards is enabled
+By default, the configuration flag 'receive.denyNonFastForwards' is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
@@ -113,7 +113,7 @@ TEMPLATE DIRECTORY
 The template directory contains files and directories that will be copied to
 the `$GIT_DIR` after it is created.
 
-The template directory used will (in order):
+The template directory used will be (in order):
 
  - The argument given with the `--template` option.
 
-- 
2.0.3
