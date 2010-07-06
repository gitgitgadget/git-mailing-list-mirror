From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: [PATCH 5/5] git-cvsserver: fix a typo in docs
Date: Tue, 6 Jul 2010 19:39:06 +0200
Message-ID: <AANLkTikltezqL3gSFI28DORCBoKhFnagSix94HFxqhCE@mail.gmail.com>
References: <4472911563417963946@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWC7J-0004MX-Nv
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab0GFRj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:39:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64644 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0GFRj2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:39:28 -0400
Received: by bwz1 with SMTP id 1so3687447bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=im2Qvw/kTtJKM6Ogj323VuaYR1GZ3P5YtexLga8bess=;
        b=jloLBrGNPpg37vlnzn5FF8jQlfmfj/TWs7pE5EpUYyR2L2yRqc687opo91FOXlIA4F
         kiPPALo+AZR3NzanMpY/wdZeckYu03Yg/maZluRKpL8QSzOT2TvD2I/4ew9cGERDjEzU
         /VUDNmmumuq4J0lOmw3J0/v8/61p9zHJ63h6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Qe1RjZvSJ+ezS0Z1pizH+HNx5RSpTGQJRkfZYu+wUq9MtD+KNz+hWnEyhRWfEQB7Zo
         eBF5XDJWukoauVjJQY8MtzqN+yyU4Hey3rmf5sgRVf8IfJaHxNWZO2BrBLH6y+BEoEo1
         pVjX7M+Js3ecFeM1vEY9+Tg/K9+g7HF4THXsc=
Received: by 10.204.84.20 with SMTP id h20mr4018128bkl.186.1278437966353; Tue, 
	06 Jul 2010 10:39:26 -0700 (PDT)
Received: by 10.204.79.19 with HTTP; Tue, 6 Jul 2010 10:39:06 -0700 (PDT)
In-Reply-To: <4472911563417963946@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150378>

---
=A0Documentation/git-cvsserver.txt | =A0 =A02 +-
=A01 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsser=
ver.txt
index 59c8e5d..5d5a3a9 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -99,7 +99,7 @@ looks like

=A0------

-Only anonymous access is provided by pserve by default. To commit you
+Only anonymous access is provided by pserver by default. To commit you
=A0will have to specify an authentication option in the config file.
=A0Currently there are two options are available for authentication thr=
ough
=A0pserver in git-cvsserver: one through an authenticator script and an=
 other
--
1.7.0.4
