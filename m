From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 3/6] .mailmap: Multiple mail addresses of Paul Mackerras
Date: Thu,  4 Jul 2013 16:04:16 +0200
Message-ID: <1372946659-10332-4-git-send-email-stefanbeller@googlemail.com>
References: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 16:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuk9L-0002Dt-6r
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 16:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3GDOEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 10:04:35 -0400
Received: from mail-bk0-f50.google.com ([209.85.214.50]:41434 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab3GDOEe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 10:04:34 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik8so676850bkc.9
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HGn2Y8ip1UQw1bb2jcIPNQGfglBnvfmMGkq2aycOGEE=;
        b=mwS6+2YOjlPhyEetdMxTEvsEudUgpEHJiQv7bj7rElYPADXCXE/KX7D4iBB/3q6bg8
         ykmOF7Tx+9LELjDM1cpV2yaCoGl6yYD7NoMTaaySH8rCVncQ3bhiZSOW8321eqdLtrTX
         ij9TcHEsjV1jQezV9jIcqfsNeEP0/KitDbYXs0iRIXdrWHegeq9Ph9fBaQudj+/8OO3T
         uPCEb+J82GouH1T1lJ6PzcKqgA1tX295JJmOjm0UEBwodn0EtvcUnC0fQX3KSgwghl62
         KfPNygbcWXcoy/uvioIZHZTXJ9QZH4hDuwb1j4loSgKmrqG9jG1Fos4qONknULEiEJrt
         83Iw==
X-Received: by 10.204.174.200 with SMTP id u8mr1098957bkz.175.1372946673421;
        Thu, 04 Jul 2013 07:04:33 -0700 (PDT)
Received: from localhost (eduroam-74-151.uni-paderborn.de. [131.234.74.151])
        by mx.google.com with ESMTPSA id if11sm1069736bkc.15.2013.07.04.07.04.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 07:04:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.636.g7943f03
In-Reply-To: <1372946659-10332-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229585>

This is an obvious one, as the .(none) addresses are not valid mail
addresses.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index cd46d24..6d75678 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,6 +76,8 @@ Nanako Shiraishi <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
 <nico@fluxnic.net> <nico@cam.org>
+Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
+Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolv=
es.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
--=20
1.8.3.2.636.g7943f03
