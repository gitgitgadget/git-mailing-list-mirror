From: =?UTF-8?Q?Ren=c3=a9_Nyffenegger?= <mail@renenyffenegger.ch>
Subject: [PATCH] fix typo 'In such these cases'
Date: Mon, 2 May 2016 09:38:20 +0200
Message-ID: <572703EC.20405@renenyffenegger.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mail@renenyffenegger.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 09:46:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax8Z5-00036H-PV
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbcEBHqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 03:46:39 -0400
Received: from belinda3.kreativmedia.ch ([80.74.158.27]:50111 "EHLO
	belinda3.kreativmedia.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbcEBHqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:46:38 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 May 2016 03:46:38 EDT
Received: from [192.168.1.122] (214.181.202.62.dynamic.cgnat.res.cust.swisscom.ch [62.202.181.214])
	by belinda3.kreativmedia.ch (Postfix) with ESMTPSA id EAC6BBDD8052;
	Mon,  2 May 2016 09:38:20 +0200 (CEST)
DomainKey-Signature: a=rsa-sha1;  q=dns; c=nofws;
  s=default; d=renenyffenegger.ch;
  b=V3rANEUml4/4icJWRNuZYa65Ho8yaucAs0DUaj/JjNXoAokUge3bHwOgQ3lTCWHdnVi1JBV5jSeTwmm8Ts27DVY51g2cfXN8LUJ/NvqxxWww1NNziXWF9Ias7HIbd/xOF7QeWA9WMYvlp6IcULJjl1r1zTIZ6YaIgpZ3ihJtwCE=;
  h=Subject:To:Cc:From:Message-ID:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293228>

=46rom 5e2b47833c8d434784fa1a797cfd6a087df10dc8 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Ren=3DC3=3DA9=3D20Nyffenegger?=3D <rene.nyffenegger=
@adp-gmbh.ch>
Date: Mon, 2 May 2016 09:19:46 +0200
Subject: [PATCH] Documentation: Fix typo 'In such these cases'

=46ix "In such these cases, ..." to "In such cases, ..."
in Documentation/glossary-content.txt

Signed-off-by: Ren=C3=A9 Nyffenegger <mail@renenyffenegger.ch>
---
 Documentation/glossary-content.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index cafc284..9ceca05 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -145,7 +145,7 @@ current branch integrates with) obviously do not wo=
rk, as there is no
 	A fast-forward is a special type of <<def_merge,merge>> where you hav=
e a
 	<<def_revision,revision>> and you are "merging" another
 	<<def_branch,branch>>'s changes that happen to be a descendant of wha=
t
-	you have. In such these cases, you do not make a new <<def_merge,merg=
e>>
+	you have. In these cases, you do not make a new <<def_merge,merge>>
 	<<def_commit,commit>> but instead just update to his
 	revision. This will happen frequently on a
 	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
--=20
2.5.0
