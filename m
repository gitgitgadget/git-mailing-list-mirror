From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] relnotes: fix spelling error in 1.8.4.txt
Date: Mon,  3 Jun 2013 15:38:24 +0530
Message-ID: <1370254104-16358-1-git-send-email-artagnon@gmail.com>
References: <CAHtLG6SGF=D-_gz47qAfhvkZHPU3-Ucj-cM_aF8BhTsE1mo2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?=E4=B9=99=E9=85=B8=E9=8B=B0?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 12:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjRf0-0007o1-0A
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 12:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab3FCKGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 06:06:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58570 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195Ab3FCKGh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 06:06:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5471793pbb.19
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xvhwx4vigHBDsUUkwEtbL3rr0GM+kNn6iagoEKV3UbU=;
        b=eWKDsN8Ol6KUXptU4uxcar1YIfl92sLba3OFM9Jqcmyn66ruXFWW5Nr7ydvVNSYE98
         S13GXg4RS7Oe8Bg6oAed6htBflSd7yyOBP+ZPxJ6M0wS3MX7Vh8N68rj7/3Q4BshItPt
         t/l4XQhGMvPnCSphyfVy/e5NH7QPHOEi1WFvVouEAMp1fGCjnVFn/JBHJp4P6V1QOvU3
         IYGsvBGWFjngwgZFkbp5/Pt8oqdpbeTY0gWhw+W7YAw8ywkpsanYzekQMn7TqPJOP9ZM
         dtfbO31GHoa9pIY/N4PQxN1OfJtoBGNbRS/M0qsr8ljFP38a4zsxEVtmK7d/D68VHpPS
         Yz8g==
X-Received: by 10.68.0.131 with SMTP id 3mr3888565pbe.124.1370253996752;
        Mon, 03 Jun 2013 03:06:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm58473382pbc.12.2013.06.03.03.06.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Jun 2013 03:06:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.114.gcd03571
In-Reply-To: <CAHtLG6SGF=D-_gz47qAfhvkZHPU3-Ucj-cM_aF8BhTsE1mo2sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226211>

=46rom: =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 =E4=B9=99=E9=85=B8=E9=8B=B0: please read Documentation/SubmittingPatch=
es and submit a
 patch yourself next time.  I've done it for you this time as an
 example.

 Junio: please (add-hook 'text-mode-hook 'flyspell-mode) to your
 .emacs to catch this early.

 Documentation/RelNotes/1.8.4.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/=
1.8.4.txt
index 14835d1..0e08bf4 100644
--- a/Documentation/RelNotes/1.8.4.txt
+++ b/Documentation/RelNotes/1.8.4.txt
@@ -36,7 +36,7 @@ UI, Workflows & Features
    did not update "refs/remotes/origin/master"; this was an early
    design decision to keep the update of remote tracking branches
    predictable, but in practice it turns out that people find it more
-   convenient to opportunisticly update them whenever we have a
+   convenient to opportunistically update them whenever we have a
    chance, and we have been updating them when we run "git push" which
    already breaks the original "predictability" anyway.
=20
--=20
1.8.3.114.gcd03571
