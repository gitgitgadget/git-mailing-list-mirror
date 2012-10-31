From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: =?UTF-8?B?xazFrSBsZXR0ZXI=?=
Date: Wed, 31 Oct 2012 16:39:44 +0100
Message-ID: <50914640.1060509@drmicha.warpmail.net>
References: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com> <50913C58.2000200@drmicha.warpmail.net> <CAG+H+KT=TyJ2hwWRxYwfXut==1v+a0fpy_pZH1SCR4=VukPHbQ@mail.gmail.com> <5091407B.1080005@drmicha.warpmail.net> <CAG+H+KSCuM0ZRhEvZJ1O9TFi9SBkDEi25tWn9r-DggWJnFRu1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VXNpZXZhxYJhZCDEjG9ybnk=?= <eratyk@tut.by>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:40:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTaOe-0003Wa-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640Ab2JaPjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 11:39:46 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60457 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932574Ab2JaPjq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 11:39:46 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6257A20B65;
	Wed, 31 Oct 2012 11:39:45 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 31 Oct 2012 11:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=9lCIol2G/9aClrA9xEbPZg
	pfJe4=; b=E7CbmBCmxoIkR5kR51veRsqVJbgvLVZBXP/c5ysUAmSMHnLv7nCeHE
	cO3ao4CHZ+2g9soLhbB1YcjGSBvbXXdm/jWgAKHpPxnEcnfJON3kuDROqmSOC+II
	CIVjS0SNazWKYRp6pIWhH8Vpkzb4ezERgMQ48G00AmRi77FRWwMDU=
X-Sasl-enc: r1lzn23FUOcvtJExJ8MB78XoeVxwBpAZt3OCfRdHbNSB 1351697985
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E8E714825CF;
	Wed, 31 Oct 2012 11:39:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAG+H+KSCuM0ZRhEvZJ1O9TFi9SBkDEi25tWn9r-DggWJnFRu1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208833>

Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 16:27:
> No, commit is the same as input. Only when I press key combination fo=
r
> =C5=AC=C5=AD (AltGr+Uu [like AltGr+Cc for =C4=86=C4=87, this works]) =
=E2=80=94 simple Uu appears
> in text form. Every other special letter (=C5=A0=C5=A1, =C4=8C=C4=8D,=
 =C5=BD=C5=BE, =C5=9A=C5=9B, =C5=81=C5=82, =C5=B9=C5=BA, =C4=86=C4=87)
> works.

So it's really the input. Is AltGr+u maybe a menu shortcut in git gui
which overrides the special character? I think Ctril+u and such are
command shortcuts, and AltGr+u and such activate menus.

> On Wed, Oct 31, 2012 at 6:15 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 16:08:
>>> Ok. I use Win7 sp1, syslang =E2=80=94 be_BY, git version 1.8.0.msys=
git.0 (=E2=80=9Egit
>>> version=E2=80=9C command).
>>> Problem appears when I type this letter on keyboard; when I copy-pa=
ste
>>> it everyrhing is ok.
>>
>> That is interesting. It means git-gui can make the commit properly, =
but
>> somehow the input method fails in the commit message form of the gui
>> window. Do those letters show correctly in the form (but fail to com=
mit
>> correctly), or do they appear incorrectly already at the time you tr=
y to
>> type them?
>>
>> That info could help windows folks find the cause.
>>
>> Michael
>>
>>> On Wed, Oct 31, 2012 at 5:57 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:
>>>> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 15:39:
>>>>> Hello!
>>>>>
>>>>> When I type comment message in Git Gui (1.8.0 and previous), I ca=
n't
>>>>> use =C5=AC=C5=AD letter (U+016C, U+016D) =E2=80=94 it just transf=
orms into simple Uu.
>>>>> Please fix it.
>>>>
>>>> Can you tell us more about your environment (LANG setting, OS)? I =
just
>>>> made two commits (1 with git-gui, one with git-commit on command l=
ine),
>>>> and both come out fine (LANG=3Dde_DE.UTF-8, git version 1.8.0.226.=
gba44ac5
>>>> on Fedora 16):
>>>>
>>>> git log -2 -p
>>>> commit 36de49231639eb9edccb1ebad595056d395141c7
>>>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>>>> Date:   Wed Oct 31 15:54:04 2012 +0100
>>>>
>>>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>>
>>>> diff --git a/a b/a
>>>> index 1074042..677c385 100644
>>>> --- a/a
>>>> +++ b/a
>>>> @@ -1 +1,2 @@
>>>>  =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>>
>>>> commit cfcf8f021a53c1bf5ae018a723fbcfad8649a02b
>>>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>>>> Date:   Wed Oct 31 15:52:52 2012 +0100
>>>>
>>>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>>
>>>> diff --git a/a b/a
>>>> new file mode 100644
>>>> index 0000000..1074042
>>>> --- /dev/null
>>>> +++ b/a
>>>> @@ -0,0 +1 @@
>>>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>
>>>
>>>
>=20
>=20
>=20
