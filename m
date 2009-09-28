From: Frederik Schwarzer <schwarzerf@gmail.com>
Subject: [PATCH] typo in hook template
Date: Mon, 28 Sep 2009 10:30:19 +0200
Message-ID: <200909281030.19949.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 10:32:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsBeV-0002RE-8J
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 10:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbZI1IcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2009 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbZI1IcA
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 04:32:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45991 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbZI1Ib7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Sep 2009 04:31:59 -0400
Received: by fg-out-1718.google.com with SMTP id 22so677021fge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=NhGt97lqqM0rt7WLLpr8kWhj4Rpdp7kC0kc6jD0mGaA=;
        b=TX/aGVbaM3a9qt0oa5QBrPZUgtErNkPgeISmMRwEj7BWN3gn96gdN9kYWiFZ4PhLSY
         WrpY6s90FsiOYPAyuCBi+UPKNcYTSaES28I59BEChhqqyaoSiLW6wQvzVw5X1o47nkzN
         DMfYmo9rpkyPUIFCSsM89a4cLMHZdDkCk94WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id;
        b=xENSBN7fBQyfJXPunzJoYosDYwQYmnZY+mM3CKs4YNp2nm0/r2JRKpSoJmKxwRJ9WC
         oA+GdkZTx5SGCHH/6M87ZZNYUBKIuP3Bo1pM7jNPtbJhTMzxXqGBe1PEfJ9aYQF1UnpI
         vl9Y611OZWICRZ2kTVRoudmCnF9oBFwnlwyvE=
Received: by 10.86.242.15 with SMTP id p15mr3129439fgh.14.1254126722823;
        Mon, 28 Sep 2009 01:32:02 -0700 (PDT)
Received: from tamaki.localnet (f055015034.adsl.alicedsl.de [78.55.15.34])
        by mx.google.com with ESMTPS id d4sm5187381fga.2.2009.09.28.01.32.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 01:32:02 -0700 (PDT)
User-Agent: KMail/1.12.1 (Linux/2.6.30-fs; KDE/4.3.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129236>

=46rom b4bcd971e3d6358b3381280609e1c0859bee3db8 Mon Sep 17 00:00:00 200=
1
=46rom: Frederik Schwarzer <schwarzerf@gmail.com>
Date: Mon, 28 Sep 2009 10:25:55 +0200
Subject: [PATCH] typo in hook template

---
 templates/hooks--post-receive.sample |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--post-receive.sample b/templates/hooks--po=
st-
receive.sample
index 18d2e0f..7a83e17 100755
--- a/templates/hooks--post-receive.sample
+++ b/templates/hooks--post-receive.sample
@@ -9,7 +9,7 @@
 # For example:
 #  aa453216d1b3e49e7f6f98441fa56946ddcd6a20=20
68f7abf4e6f922807889f52bc043ecd31b79f814 refs/heads/master
 #
-# see contrib/hooks/ for an sample, or uncomment the next line and
+# see contrib/hooks/ for a sample, or uncomment the next line and
 # rename the file to "post-receive".
=C2=B7
 #. /usr/share/doc/git-core/contrib/hooks/post-receive-email
--=C2=B7
1.6.4.3
