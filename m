From: larsxschneider@gmail.com
Subject: [PATCH v3 2/2] Documentation: use ASCII quotation marks in git-p4
Date: Wed, 23 Mar 2016 11:59:02 +0100
Message-ID: <1458730742-88607-3-git-send-email-larsxschneider@gmail.com>
References: <1458730742-88607-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigVU-0000Qg-1d
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbcCWK7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 06:59:14 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33621 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbcCWK7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:59:09 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so228294928wml.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtlRdGyC6LDJo7abvobyzMX/OBuG/U4t0BgUmEo1vIk=;
        b=AgxvaXDtyd2S36vxhk1auRcayPt/kJzpdxQZsjOl75Kxdq2EULadyac4odDlT3YouU
         g1B1o+KEH4ziD4PYiOyDfoclIcNY4iloTb7bPnBoLLYCs/Jn9fIMYO9x87WGXWZYtvsM
         g3bmXvX1hfCQFKdAWmiEzG3n1nkRnTOL1X/LLf2JlxT2Bo95Q9ev4RHnBRoHrtIHZ2ju
         I33F95rpg3TCaw6tvxqrx5Ba3PLwEaUYEfQLNVA/T5uuIKFrYzFds41Dpdqb/1ckulgF
         l6UrsAx6K3tLUJ+22x+DwKocasG96VLaG14ndFYjKu9ceBDPEqI5FkY/kqRY5QrqHCQx
         /iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtlRdGyC6LDJo7abvobyzMX/OBuG/U4t0BgUmEo1vIk=;
        b=HIqd2BuvzjNmmKM+s++MTZepkzBo5zH0tuNNBkQtRSRlqvSlWEPYY+5wSo7o9wFxuV
         X7b8j284XApbJoKoW/QDG6/nMe4tKVpOcF1ccPM7JYmBrJ0FOqddRtTDELY7KsRaOBkG
         ChVvtqEgHckVpD+G83rnHcpBDLAluzAzBIXkUggDPe0uh+X5xuBVQMgjYR1MRCbN7Rxr
         kkTf+iVKKjrQ3hTF2NqU0keGZQS2dOUcDOfAtSNaRZylYrsek+2C4NsgHj3j0SnzcvzM
         mSdyJ8aFYZOldSafwU/AjO8+hxuaFc2rBk/RHOiPDXoyAMmtmglJy25EI1iiCSVY1HeU
         ILqQ==
X-Gm-Message-State: AD7BkJJ33ooLfIHoUHcO2kRv6eX3Mce7naapTML3QMuK4vC80jLnZ0D/MYGGge/sWpqzcg==
X-Received: by 10.28.21.75 with SMTP id 72mr24496101wmv.64.1458730747944;
        Wed, 23 Mar 2016 03:59:07 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA3D3.dip0.t-ipconnect.de. [80.139.163.211])
        by smtp.gmail.com with ESMTPSA id j18sm21764781wmd.2.2016.03.23.03.59.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:59:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1458730742-88607-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289647>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 6efe830..35e3170 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -515,7 +515,7 @@ git-p4.pathEncoding::
 	Git expects paths encoded as UTF-8. Use this config to tell git-p4
 	what encoding Perforce had used for the paths. This encoding is used
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
-	often uses =E2=80=9Ccp1252=E2=80=9D to encode path names.
+	often uses "cp1252" to encode path names.
=20
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
--=20
2.5.1
