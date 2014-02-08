From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 08 Feb 2014 20:59:46 +0100
Message-ID: <87vbwpbcjx.fsf@fencepost.gnu.org>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
	<877g95motv.fsf@thomasrast.ch> <874n49ctsz.fsf@fencepost.gnu.org>
	<87fvntl8xh.fsf@thomasrast.ch> <87zjm1bea6.fsf@fencepost.gnu.org>
	<CAN0XMOL29EgA4KHHP1qqGo4vd7ezKMzPnxGzc0gcY_fbNe6bsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	git <git@vger.kernel.org>, Xin Jiang <worldhello.net@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 21:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCE4t-0005ZO-9L
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbaBHUAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 15:00:04 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50733 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaBHUAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 15:00:02 -0500
Received: from localhost ([127.0.0.1]:49773 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WCE4F-0000U6-84; Sat, 08 Feb 2014 14:59:59 -0500
Received: by lola (Postfix, from userid 1000)
	id 9C411E12E5; Sat,  8 Feb 2014 20:59:46 +0100 (CET)
In-Reply-To: <CAN0XMOL29EgA4KHHP1qqGo4vd7ezKMzPnxGzc0gcY_fbNe6bsQ@mail.gmail.com>
	(Ralf Thielow's message of "Sat, 8 Feb 2014 20:46:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241851>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> 2014-02-08 20:22 GMT+01:00 David Kastrup <dak@gnu.org>:
>> "verberge keine aufgepfropften Commits" seems much more in the spiri=
t of
>> the original terminology.  "verbirgt keine Commits mit k=FCnstlichen
>> Vorg=E4ngern" is plainly wrong anyway since it is not the commits _w=
ith_
>> grafts which are hidden but rather the commits _provided_ by grafts.
>>
>
> Maybe "verbirgt keine Commits auf Basis k=FCnstlicher Vorg=E4nger"?

No.  If at all "Verbirgt keine k=FCnstlichen Vorg=E4nger" or "keine
k=FCnstlichen Vorg=E4ngercommits" since the "k=FCnstlicher Vorg=E4nger"=
 _is_ the
commit that is hidden: the graft, if we are being totally meticulous, i=
s
the list of artificial parents for a given commit.  The option, when
activated, hides those artificial parents.

And "Do not" is not "Does not", so "Verbirgt" seems also wrong as it
likely should be "Verberge" (imperative).  But then it would depend on
the overall style in which this imperative is usually translated.

--=20
David Kastrup
