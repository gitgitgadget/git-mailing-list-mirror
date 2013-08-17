From: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
Subject: [PATCH v2] CEST is +0200 during April
Date: Sat, 17 Aug 2013 05:52:00 +0200
Message-ID: <1376711520-4685-1-git-send-email-maandree@operamail.com>
References: <877gfl1imp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 17 05:52:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAXYm-00044D-5n
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 05:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab3HQDwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 23:52:12 -0400
Received: from smtp-4.sys.kth.se ([130.237.48.193]:35109 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3HQDwL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 23:52:11 -0400
Received: from mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91])
	by smtp-4.sys.kth.se (Postfix) with ESMTP id 15101C10;
	Sat, 17 Aug 2013 05:52:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-4.sys.kth.se ([130.237.48.193])
	by mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91]) (amavisd-new, port 10024)
	with LMTP id h2uLkdgKFVBi; Sat, 17 Aug 2013 05:52:07 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-4.sys.kth.se (Postfix) with ESMTPSA id 73546488;
	Sat, 17 Aug 2013 05:52:05 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <877gfl1imp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232450>

Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
---
 Documentation/date-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-format=
s.txt
index c000f08..61a836e 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -11,7 +11,7 @@ Git internal format::
 	It is `<unix timestamp> <timezone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
 	`<timezone offset>` is a positive or negative offset from UTC.
-	For example CET (which is 2 hours ahead UTC) is `+0200`.
+	For example CEST (which is 2 hours ahead UTC) is `+0200`.
=20
 RFC 2822::
 	The standard email format as described by RFC 2822, for example
--=20
1.8.3.4
