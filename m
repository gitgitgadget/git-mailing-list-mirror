From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Enhancement Request: "locale" git option
Date: Mon, 08 Dec 2014 08:50:20 +0100
Message-ID: <5485664C020000A100018371@gwsmtp1.uni-regensburg.de>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de> <20141204095557.GE27455@peff.net>
 <CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
 <548087F8.1030103@drmicha.warpmail.net>
 <CACBZZX6iOtO-Wv_T1Sgtmjqdi8kEziBCHwp1X319x0o1QMOnGA@mail.gmail.com>
 <20141204205527.GA19953@peff.net> <5481D30B.2020104@web.de>
 <CAN0XMO+hn0cYrd=gVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@drmicha.warpmail.net>,
	"=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>,
	<peff@peff.net>, <git@vger.kernel.org>
To: <ralf.thielow@gmail.com>, <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 08:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxt5U-0003yA-RK
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 08:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbaLHHu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 02:50:29 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:40965 "EHLO
	rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071AbaLHHu2 (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:4:1>);
	Mon, 8 Dec 2014 02:50:28 -0500
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id A628C529EA
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 08:50:26 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id EAD7653083
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 08:50:20 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Mon, 08 Dec 2014 08:50:20 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
In-Reply-To: <CAN0XMO+hn0cYrd=gVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261002>

>>> Ralf Thielow <ralf.thielow@gmail.com> schrieb am 06.12.2014 um 20:2=
8 in
Nachricht
<CAN0XMO+hn0cYrd=3DgVpUad_mQCvkNwdFzFLn0Vo7045-M_0Gsvw@mail.gmail.com>:
> 2014-12-05 16:45 GMT+01:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
>>
>> I do not know who was first, and who came later, but
>>=20
>
<http://git-scm.com/book/de/v1/Git-Grundlagen-%C3%84nderungen-am-Reposi=
tory-na

> chverfolgen>
>>
>> uses "versioniert" as "tracked"
>>
>>
>> LANG=3Dde_DE.UTF-8 git status
>> gives:
>> nichts zum Commit vorgemerkt, aber es gibt unbeobachtete Dateien (be=
nutzen

> Sie "git add" zum Beobachten)
>>
>>
>> Does it make sense to replace "beobachten" with "versionieren" ?
>>
>=20
> I think it makes sense. "versionieren" describes the concept of track=
ing
> better than "beobachten", IMO. I'll send a patch for that.

Isolated from usage, "versionieren" and "tracking" have no common trans=
lation;
what about "verfolgen" (~follow) for "tracking"?

>=20
> Thanks
