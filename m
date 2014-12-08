From: David Kastrup <dak@gnu.org>
Subject: Re: Antw: Re: Enhancement Request: "locale" git option
Date: Mon, 08 Dec 2014 10:48:04 +0100
Message-ID: <871toamq0b.fsf@fencepost.gnu.org>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
	<54801B50.4080500@web.de> <20141204095557.GE27455@peff.net>
	<CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
	<548087F8.1030103@drmicha.warpmail.net>
	<CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
	<20141204205527.GA19953@peff.net> <5481D30B.2020104@web.de>
	<CAN0XMO+hn0cYrd=gVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com>
	<5485664C020000A100018371@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <ralf.thielow@gmail.com>, <tboegi@web.de>,
	<git@drmicha.warpmail.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	<peff@peff.net>, <git@vger.kernel.org>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:44:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxwk0-0007eR-R3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbaLHLod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 06:44:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55462 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbaLHLoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 06:44:32 -0500
Received: from localhost ([127.0.0.1]:54501 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Xxwju-00016t-NO; Mon, 08 Dec 2014 06:44:30 -0500
Received: by lola (Postfix, from userid 1000)
	id 5FE35DF400; Mon,  8 Dec 2014 10:48:04 +0100 (CET)
In-Reply-To: <5485664C020000A100018371@gwsmtp1.uni-regensburg.de> (Ulrich
	Windl's message of "Mon, 08 Dec 2014 08:50:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261012>

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

>>>> Ralf Thielow <ralf.thielow@gmail.com> schrieb am 06.12.2014 um 20:=
28 in
> Nachricht
> <CAN0XMO+hn0cYrd=3DgVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com=
>:
>> 2014-12-05 16:45 GMT+01:00 Torsten B=F6gershausen <tboegi@web.de>:
>>>
>>> I do not know who was first, and who came later, but
>>>=20
>>
> <http://git-scm.com/book/de/v1/Git-Grundlagen-%C3%84nderungen-am-Repo=
sitory-na
>
>> chverfolgen>
>>>
>>> uses "versioniert" as "tracked"
>>>
>>>
>>> LANG=3Dde_DE.UTF-8 git status
>>> gives:
>>> nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien (b=
enutzen
>
>> Sie "git add" zum Beobachten)
>>>
>>>
>>> Does it make sense to replace "beobachten" with "versionieren" ?
>>>
>>=20
>> I think it makes sense. "versionieren" describes the concept of trac=
king
>> better than "beobachten", IMO. I'll send a patch for that.
>
> Isolated from usage, "versionieren" and "tracking" have no common tra=
nslation;
> what about "verfolgen" (~follow) for "tracking"?

What about "bekannt", "unbekannt" and "bekanntmachen"?  "unregistriert"=
,
"registriert", "anmelden"?  Or "ungemeldet", "angemeldet", "anmelden"?

--=20
David Kastrup
