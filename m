From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/8] t/README: Typo: paralell -> parallel
Date: Thu,  1 Jul 2010 15:09:59 +0000
Message-ID: <1277997004-29504-4-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULVi-0001Ra-GW
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab0GAPRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:17:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43731 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab0GAPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:16:59 -0400
Received: by ewy23 with SMTP id 23so813960ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WsbhwNGI1FHGkc+F3OSYUYnyQ0qbOaPP9POCM/LEANQ=;
        b=ZZ/ErSHHsSur+nU2RIK4dD4XeVJn22mhLA64Qhhk9UaVsYvQ4R2tSIPfIivUOIOoFp
         kFjOkF8ktu258g2mdtoVm6l9HJlqgzQ1UEmJQ+1Aq2eKJqDHRFnjpYudib1stTFgqyd4
         Q/5oOWKggBZrutrzsYo5k7xjfMqWIUhGzS6w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gqtWdrGN5mvO4C1ObrjcxQprJD2Qeb0b1nIHBgbzS3OYOufMqYzISpoJf/m4H96+yQ
         AtKzK70rXfseDdOFpuhn0+jahi2QHmd+FgVBVbULEse7zi/PWvrhTDmOAocLn5dtubw6
         ZVYzClSPPyJqBFz0iJ4DnzdGquvdMDbyX7wCo=
Received: by 10.213.11.12 with SMTP id r12mr5553638ebr.55.1277997046426;
        Thu, 01 Jul 2010 08:10:46 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150044>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/README b/t/README
index fd61ec7..0998bfb 100644
--- a/t/README
+++ b/t/README
@@ -33,7 +33,7 @@ the tests.
     ok 3 - plain bare
=20
 Since the tests all output TAP (see http://testanything.org) they can
-be run with any TAP harness. Here's an example of paralell testing
+be run with any TAP harness. Here's an example of parallel testing
 powered by a recent version of prove(1):
=20
     $ prove --timer --jobs 15 ./t[0-9]*.sh
--=20
1.7.1.251.g92a7
