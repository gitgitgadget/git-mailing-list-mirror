From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v4] l10n: de.po: translate 28 new messages
Date: Sat, 08 Feb 2014 21:11:50 +0100
Message-ID: <87r47dbbzt.fsf@fencepost.gnu.org>
References: <1391581141-4609-1-git-send-email-ralf.thielow@gmail.com>
	<1391888440-4140-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	worldhello.net@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 21:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCEFs-0006gh-RN
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbaBHULz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 15:11:55 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50904 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbaBHULx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 15:11:53 -0500
Received: from localhost ([127.0.0.1]:49942 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WCEFi-0007HS-GT; Sat, 08 Feb 2014 15:11:50 -0500
Received: by lola (Postfix, from userid 1000)
	id 252C3E12E5; Sat,  8 Feb 2014 21:11:50 +0100 (CET)
In-Reply-To: <1391888440-4140-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Sat, 8 Feb 2014 20:40:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241852>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Translate 28 new messages came from git.pot update in
> df49095 (l10n: git.pot: v1.9 round 1 (27 new, 11 removed)
> and d57b24b (l10n: git.pot: v1.9 round 2 (1 new)).
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>
> v4 corrects some translations according to Thomas' review.
> Thanks for that.
> With this we also change the translation of "shallow" which
> was translated as "flach" as in "flacher Klon". Now we translate
> it as with "Klon/Repository mit unvollst=E4ndiger Historie".

I've already stated that I'd just use "oberfl=E4chlich" here.

@@ -1633,6 +1629,8 @@ msgid ""
 "Do not touch the line above.\n"
 "Everything below will be removed."
 msgstr ""
+"=C4ndern Sie nicht die Zeile oberhalb.\n"
+"Alles unterhalb wird entfernt."

That's not even grammatical.

"=C4ndern Sie nicht die obige Zeile.
Alles unterhalb von ihr wird entfernt."

--=20
David Kastrup
