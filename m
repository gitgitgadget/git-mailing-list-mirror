From: 0xAX <kuleshovmail@gmail.com>
Subject: [PATCH 1/1] gitk: po/ru.po russian translation typo fixed
Date: Fri, 14 Nov 2014 17:05:28 +0600
Message-ID: <1415963128-14221-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	0xAX <kuleshovmail@gmail.com>
To: Paul Mackerras <paulus@samba.org>, Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 12:05:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpEhM-0006wz-Aa
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbaKNLFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2014 06:05:48 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58236 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964781AbaKNLFr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 06:05:47 -0500
Received: by mail-lb0-f180.google.com with SMTP id z11so5770302lbi.39
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yf7fYxBYvx0TLu3Eqk1Q/OszXMKjcYA0XgLlrOhklEM=;
        b=y8OdNPp2wlXESxQYXKrqleAPOJzQ6eU9fFsWxHIZadxY1moense8yikzmOWzQPEdui
         ppXW/y057DaQm9qD6L5HsRmKSAMPlUoXPMWnaScz28Cf8VCfM5itp4PTLtD8XfY7Vvuf
         LganiRs8K/PTvjhICTW+VMU7K9vnS5IbD6aKUPReafP27Zdpp08kGx5JpP1qTK6Okx2M
         v5iUfWAVzKD7OmU+z83h7YbOR2yusEOUJs6PkzIK6AB0xPQ9gOOqTyCGsmYD0jOuT3oL
         cpUAdzotk3h5LyxrV4pImJQbbh/PW1pqZ5GffEESK8FIDGWxmQqAjcT2v4DywLVKSuQz
         TAHw==
X-Received: by 10.152.2.41 with SMTP id 9mr7445966lar.47.1415963145921;
        Fri, 14 Nov 2014 03:05:45 -0800 (PST)
Received: from localhost.localdomain ([95.59.92.217])
        by mx.google.com with ESMTPSA id x8sm8111211lae.24.2014.11.14.03.05.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Nov 2014 03:05:45 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 po/ru.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/ru.po b/po/ru.po
index 5987303..0a0754d 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -863,7 +863,7 @@ msgid ""
 "(discard ALL local changes)"
 msgstr ""
 "=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B9: =D0=BF=D0=B5=D1=80=D0=B5=D0=
=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =
=D0=B8 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3\n"
-"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=B8 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=
=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
+"(=D0=B2=D1=81=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8F =D0=B2 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D0=BA=D0=B0=D1=82=
=D0=B0=D0=BB=D0=BE=D0=B3=D0=B5 =D0=B1=D1=83=D0=B4=D1=83=D1=82 =D0=BF=D0=
=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B)"
=20
 #: gitk:8492
 msgid "Resetting"
--=20
2.1.3
