From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t9010-svn-fe.sh: add an +x bit to this test
Date: Thu, 19 Aug 2010 15:53:50 +0000
Message-ID: <1282233230-17323-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 17:54:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7RQ-0008LT-Qr
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 17:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab0HSPyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 11:54:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37914 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0HSPx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 11:53:59 -0400
Received: by wyb32 with SMTP id 32so2352717wyb.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=cjHRZ3hjrnxxu+GTUYI6eU3wWWtOPY1x1EOE0/McPhc=;
        b=DruVAFnwUej/vOxl6ofvMKo4aFqLznOVbaWM7H2ys3oB/MTkB+R/82O44MzOeJOJDV
         C1iwWV3FbaY5z/pcEfnreBuYa/XUA0msmcvQf/fnf32dHpkpBancUI7rkL+yHlO/C+Wa
         amIo9/B4GYwz9OAnprYwn/hkGplQE4hiUmcOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tzKBynzUWNo0l5xiAQjSYOO2Ib2fc08zmxCuMkg0fmGKTJ94jFiwoolDqE94yV1wSK
         5zMgUIdCG3UuWdfPug7aCmphvuvvDZvTD8xjFXteYnt+OpIu/sz96B5xvBhdpVGSsajH
         MWVG2fBjRs3Rk4WzkOImqqhYkcPiyiwjFUzg8=
Received: by 10.227.128.8 with SMTP id i8mr23537wbs.91.1282233237773;
        Thu, 19 Aug 2010 08:53:57 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm1472881wbe.11.2010.08.19.08.53.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 08:53:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153929>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 t/t9010-svn-fe.sh

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
old mode 100644
new mode 100755
--=20
1.7.2.1.446.g168052
