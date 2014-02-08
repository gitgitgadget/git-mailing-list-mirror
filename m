From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 08 Feb 2014 20:07:54 +0100
Message-ID: <87fvntl8xh.fsf@thomasrast.ch>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
	<877g95motv.fsf@thomasrast.ch> <874n49ctsz.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org, worldhello.net@gmail.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 08 20:08:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCDGA-0004ty-F9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 20:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbaBHTIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 14:08:09 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34213 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbaBHTII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 14:08:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2C2F54D656A;
	Sat,  8 Feb 2014 20:08:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id L-ZrB52f0sNz; Sat,  8 Feb 2014 20:07:56 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EEBC44D64BD;
	Sat,  8 Feb 2014 20:07:55 +0100 (CET)
In-Reply-To: <874n49ctsz.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sat, 08 Feb 2014 20:01:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241846>

David Kastrup <dak@gnu.org> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> I don't really like 'gesondert eingeh=C3=A4ngt', how about 'transpla=
ntiert'
>> instead?
>
> I suggest using the actual translation here as it is perfectly fittin=
g
> for both literal and figurative meaning: "aufgepfropft".

I didn't pick that one from the dictionary's suggestions because I
cannot remember ever using its original meaning.  Perhaps I am moving i=
n
the wrong circles? ;-)

However Ralf pointed out on IRC that we actually have this already:

#: builtin/pack-objects.c:2508
msgid "do not hide commits by grafts"
msgstr "verbirgt keine Commits mit k=C3=BCnstlichen Vorg=C3=A4ngern (\"=
grafts\")"

So it makes more sense to stick to that translation.

--=20
Thomas Rast
tr@thomasrast.ch
