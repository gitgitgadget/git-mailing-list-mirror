From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-check-ref-format.txt: typo, s/avoids/avoid/
Date: Fri,  4 Dec 2015 19:09:32 +0100
Message-ID: <1449252572-5771-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 19:10:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4uoV-0007NE-5e
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 19:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbbLDSKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2015 13:10:30 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34982 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbbLDSK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 13:10:29 -0500
Received: by wmuu63 with SMTP id u63so72217436wmu.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8zFj2x1QOG5Kr1KLt+n6p0LhtXSwd9Xqq/01meS+Nzs=;
        b=l2pqof5bs4uavf5qiQNzHDujYJEf5aXAjSoJZE8zWXjwLYruzeKQWOfAoQTdodQwp5
         xRugxYQpbUB1MRpS8xlUuBqEz0GVVxIC4RZpp01muX0BAY6w03NEpUEsShwOOJ3di8Ed
         W1522rOer2r7fuIj+Q4iktbjOo0qeTtEHFHci7HuJYuDxB+HK6ITAZS6hh+GAyfb/fxi
         4O3hci0j+2XDRVqN3wJyEfZ/gW02bdIKVXX6l5rHYSGoWnTu07oDVyo5BTDgzLy2dhcd
         ujfwAfQ9kAebx8+Ot8DehbiDgxU61OCztlYsRM/M+EeH3Eo85XgoldJXKqz+iS+PC7z/
         JVAQ==
X-Received: by 10.28.170.133 with SMTP id t127mr6240279wme.65.1449252628345;
        Fri, 04 Dec 2015 10:10:28 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id kj3sm13113065wjb.19.2015.12.04.10.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Dec 2015 10:10:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281993>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-check-ref-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git=
-check-ref-format.txt
index 9044dfa..91a3622 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -60,7 +60,7 @@ Git imposes the following rules on how references are=
 named:
=20
 These rules make it easy for shell script based tools to parse
 reference names, pathname expansion by the shell when a reference name=
 is used
-unquoted (by mistake), and also avoids ambiguities in certain
+unquoted (by mistake), and also avoid ambiguities in certain
 reference name expressions (see linkgit:gitrevisions[7]):
=20
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
--=20
2.2.0.513.g477eb31
