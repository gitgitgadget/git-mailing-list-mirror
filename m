From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/6] .mailmap: Multiple mail addresses of Alex Riesen
Date: Thu,  4 Jul 2013 16:04:15 +0200
Message-ID: <1372946659-10332-3-git-send-email-stefanbeller@googlemail.com>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuk9F-00027H-6o
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab3GDOEc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 10:04:32 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:46599 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab3GDOEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:04:31 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so678821bkc.29
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s1Lh5AS1+O9Qsfu5voTI0fgcGBj+Loj7CTyoLSwHoZo=;
        b=0JcFawfKgcckDHxKu0M6iR1JLdczuKxRBgecBRZYgAKWrSxwW20PBhI1VPodGFVKe7
         EzoILONqnhwNgJVQK8RKSGXSCCSZg8yXnnK90IGVHSHJpFiGXs+JqLOJvtD7KqkFvZqR
         KgKChB5s39iNFXi2eywjA31P+/Vij+nZzFu0zYnsL1iQKQnPZvBhmGEPuFJMZIcGR0x6
         4OasZk4g35JAuSjttd61b46cECIFZcoM2uwWpGmQm01Q4tkR5i8Uy73aVe7Bdd2+Vg7o
         YSojwSpzurR88hZz30wcVgPv9zscUIB92bMwhp+Q57XeDy9kbWBky+bZF1oNJ6t9MbVa
         6kAQ==
X-Received: by 10.205.9.129 with SMTP id ow1mr1101942bkb.43.1372946670628;
        Thu, 04 Jul 2013 07:04:30 -0700 (PDT)
Received: from localhost (eduroam-74-151.uni-paderborn.de. [131.234.74.151])
        by mx.google.com with ESMTPSA id kz11sm1067485bkb.11.2013.07.04.07.04.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:04:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.636.g7943f03
In-Reply-To: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229584>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 3a4dd49..cd46d24 100644
--- a/.mailmap
+++ b/.mailmap
@@ -6,6 +6,9 @@
 #
=20
 Alejandro R. Sede=C3=B1o <asedeno@MIT.EDU> <asedeno@mit.edu>
+Alex Riesen <raa.lkml@gmail.com> <fork0@t-online.de>
+Alex Riesen <raa.lkml@gmail.com> <raa@limbo.localdomain>
+Alex Riesen <raa.lkml@gmail.com> <raa@steel.home>
 Alex Benn=C3=A9e <kernel-hacker@bennee.com>
 Alexander Gavrilov <angavrilov@gmail.com>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
--=20
1.8.3.2.636.g7943f03
