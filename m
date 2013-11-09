From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] l10n: de.po: improve error message when pushing to unknown upstream
Date: Sat, 09 Nov 2013 15:24:33 +0100
Message-ID: <87hablps9q.fsf@linux-k42r.v.cablecom.net>
References: <1383939891-9458-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 15:24:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf9T6-0006Dg-S2
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 15:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab3KIOYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 09:24:46 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:52404 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab3KIOYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 09:24:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id DFD334D6414;
	Sat,  9 Nov 2013 15:24:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mqurfz4zWGEi; Sat,  9 Nov 2013 15:24:34 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (84-73-190-173.dclient.hispeed.ch [84.73.190.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 02B144D6576;
	Sat,  9 Nov 2013 15:24:33 +0100 (CET)
In-Reply-To: <1383939891-9458-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 8 Nov 2013 20:44:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237578>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/de.po b/po/de.po
> index a005dcc..8b824cc 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -7923,7 +7923,7 @@ msgid ""
>  "to update which remote branch."
>  msgstr ""
>  "Sie versenden nach '%s', welches kein Upstream-Repository Ihres aktuellen\n"
> -"Branches '%s' ist, ohne mir mitzuteilen, was ich versenden soll, um welchen\n"
> +"Branches '%s' ist, ohne anzugeben, was versendet werden soll, um welchen\n"
>  "Remote-Branch zu aktualisieren."
>  
>  #: builtin/push.c:167

Acked-by: Thomas Rast <tr@thomasrast.ch>

-- 
Thomas Rast
tr@thomasrast.ch
