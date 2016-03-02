From: christophhoopmann@gmail.com
Subject: [PATCH] l10n: de.po: Fixed typo
Date: Wed,  2 Mar 2016 10:13:21 +0100
Message-ID: <1456910001-907-1-git-send-email-christophhoopmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christoph Hoopmann <christophhoopmann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 10:13:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2qb-00027R-Hv
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcCBJN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 04:13:27 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35507 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbcCBJNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:13:25 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so74814420wml.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6mokUVtI20AM+edFtXI8C5Mk9qnE8rLVYLL5wsBW/s=;
        b=ms1JPjpEgJxnj+VkuknDeJ5b8hQJNYwps6DvSOtKXUHnpj1sbyxtAadeOt0hE1eZsn
         Em3DyazEPgZgPYr7tIumB0k1rfIl4OMVxFeVcyLn18ka57YJaKaj4+Lp94wQPq25velD
         jiMg0KMgv/tHjK6EDZF4tiYehcUp6KhoU5ZKb8jWcgsmvkjC8UBrUBp/Arj+7e22wekG
         TSPvde+8dg71wMngpfKny2Q7zNA8xAK41LPQlMMTn1J8ZEiwwbjNdPd5zUHWTWz+iRHa
         uVXv9Vw1I5x+2AxgZPgXEAHg2/gPmPA/SVB/C5GXo1ulatNOF8CwusfglrzGw+fHykfP
         M0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6mokUVtI20AM+edFtXI8C5Mk9qnE8rLVYLL5wsBW/s=;
        b=RmU1uG424hPb7T4IY1DDxtmoblUtldIj45naSGfVJhUgEEthQycW23bKyiUpS7sz4d
         PxxCdTdSRBVwVJL7eIwHO4tde1QLSScwLTh2b08F5xxzw1dYQgJCl4J9gDVQkml4v5d5
         tUFK808titTpmiohxUE53QKp3FQkqwpvyOWqgMR401iQuc2vNw4xusCXOMqtR3JAa7Je
         0nX1TgE9VmbaXuQR3Z9Resm8oDjdkw656If0TFeY26sCwiV4b5Z2Qa11BBuzTYNDW8NN
         voD/tD/AqnAfBBTVbSpwltQU61/Ea7Vuj3XkCEEzfwbz0VhWKc/G/TR2vMf1oRF/zcHD
         18hQ==
X-Gm-Message-State: AD7BkJJgbObVryEVxVhUsOB9W0LbgtI/G/bsZtauK/ozQ40fQxNf/p979jhNNXzGuBgz7g==
X-Received: by 10.194.111.229 with SMTP id il5mr29447413wjb.82.1456910004146;
        Wed, 02 Mar 2016 01:13:24 -0800 (PST)
Received: from arch-w530.0pointer.org (ip-178-203-206-218.hsi10.unitymediagroup.de. [178.203.206.218])
        by smtp.gmail.com with ESMTPSA id ls5sm34706946wjb.33.2016.03.02.01.13.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 01:13:22 -0800 (PST)
X-Mailer: git-send-email 2.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288115>

=46rom: Christoph Hoopmann <christophhoopmann@gmail.com>

---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index 8c5f05d..a6b7bf3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -12079,7 +12079,7 @@ msgid ""
 "option."
 msgstr ""
 "oder Sie sich unsicher sind, was das bedeutet, w=C3=A4hlen Sie einen =
anderen "
-"Namenmit der Option '--name'."
+"Namen mit der Option '--name'."
=20
 #: git-submodule.sh:347
 #, sh-format
--=20
2.7.1
