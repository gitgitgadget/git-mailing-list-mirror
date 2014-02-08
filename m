From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 08 Feb 2014 20:22:25 +0100
Message-ID: <87zjm1bea6.fsf@fencepost.gnu.org>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
	<877g95motv.fsf@thomasrast.ch> <874n49ctsz.fsf@fencepost.gnu.org>
	<87fvntl8xh.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, jk@jk.gs, stimming@tuhh.de,
	git@vger.kernel.org, worldhello.net@gmail.com
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Feb 08 20:22:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCDUG-0008Vm-B7
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 20:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaBHTW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 14:22:29 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50190 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaBHTW3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 14:22:29 -0500
Received: from localhost ([127.0.0.1]:49229 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WCDTu-0008S9-4j; Sat, 08 Feb 2014 14:22:26 -0500
Received: by lola (Postfix, from userid 1000)
	id B8319E12E5; Sat,  8 Feb 2014 20:22:25 +0100 (CET)
In-Reply-To: <87fvntl8xh.fsf@thomasrast.ch> (Thomas Rast's message of "Sat, 08
	Feb 2014 20:07:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241847>

Thomas Rast <tr@thomasrast.ch> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Thomas Rast <tr@thomasrast.ch> writes:
>>
>>> I don't really like 'gesondert eingeh=E4ngt', how about 'transplant=
iert'
>>> instead?
>>
>> I suggest using the actual translation here as it is perfectly fitti=
ng
>> for both literal and figurative meaning: "aufgepfropft".
>
> I didn't pick that one from the dictionary's suggestions because I
> cannot remember ever using its original meaning.  Perhaps I am moving=
 in
> the wrong circles? ;-)
>
> However Ralf pointed out on IRC that we actually have this already:
>
> #: builtin/pack-objects.c:2508
> msgid "do not hide commits by grafts"
> msgstr "verbirgt keine Commits mit k=FCnstlichen Vorg=E4ngern (\"graf=
ts\")"
>
> So it makes more sense to stick to that translation.

"verberge keine aufgepfropften Commits" seems much more in the spirit o=
f
the original terminology.  "verbirgt keine Commits mit k=FCnstlichen
Vorg=E4ngern" is plainly wrong anyway since it is not the commits _with=
_
grafts which are hidden but rather the commits _provided_ by grafts.

--=20
David Kastrup
