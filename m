From: =?UTF-8?B?VXNpZXZhxYJhZCDEjG9ybnk=?= <eratyk@tut.by>
Subject: =?UTF-8?B?UmU6IMWsxa0gbGV0dGVy?=
Date: Wed, 31 Oct 2012 18:27:42 +0300
Message-ID: <CAG+H+KSCuM0ZRhEvZJ1O9TFi9SBkDEi25tWn9r-DggWJnFRu1Q@mail.gmail.com>
References: <CAG+H+KTc9trmR9VBgGsdHfAUFW8VMwa218O3yM_nyNWtrySXyg@mail.gmail.com>
	<50913C58.2000200@drmicha.warpmail.net>
	<CAG+H+KT=TyJ2hwWRxYwfXut==1v+a0fpy_pZH1SCR4=VukPHbQ@mail.gmail.com>
	<5091407B.1080005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:28:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTaD2-0004FO-7K
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935704Ab2JaP1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 11:27:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35704 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935701Ab2JaP1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 11:27:42 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1524285obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GoMsDqfRJA3AXei9N2VLbn1esAX87MCdRZQh87qQ3kE=;
        b=WfwUGaNKfG0fpgvVopzPG2f6XtbbFWsqPgUnds266VRFEIC42+XzN/XuC+7cKFa73/
         3TAojiZpWbTkEzLqEXg20adDGN6IV6B+aitnG4S7PwsiSA6KG3auSBLfx1PasFZDTBxr
         Pzn1AwenhjYBJnMGDIw8wrYhS9U4qRrxWs1yayrm+P/Rhd/BUWR7VvED/xCc6KWTxGjb
         dgLpx7F+Mq6DxpIxttEHaGRpHvx5AwiFu4bBbtbSmmG8WpCbOa5+0Eyja7OMwsWNyQZz
         FOgUCJOfQejUxsPLIMkbu6YYFlE/lwcml0Yl0dIlNiZHVWAqtwe08bA0HLrelc8V3TWI
         wJ0g==
Received: by 10.182.0.1 with SMTP id 1mr30483242oba.18.1351697262226; Wed, 31
 Oct 2012 08:27:42 -0700 (PDT)
Received: by 10.182.62.137 with HTTP; Wed, 31 Oct 2012 08:27:42 -0700 (PDT)
In-Reply-To: <5091407B.1080005@drmicha.warpmail.net>
X-Google-Sender-Auth: GoRBjGpi-YvcQLP6OVJ02pgHGY4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208832>

No, commit is the same as input. Only when I press key combination for
=C5=AC=C5=AD (AltGr+Uu [like AltGr+Cc for =C4=86=C4=87, this works])=C2=
=A0=E2=80=94 simple Uu appears
in text form. Every other special letter (=C5=A0=C5=A1, =C4=8C=C4=8D, =C5=
=BD=C5=BE, =C5=9A=C5=9B, =C5=81=C5=82, =C5=B9=C5=BA, =C4=86=C4=87)
works.

On Wed, Oct 31, 2012 at 6:15 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 16:08:
>> Ok. I use Win7 sp1, syslang =E2=80=94 be_BY, git version 1.8.0.msysg=
it.0 (=E2=80=9Egit
>> version=E2=80=9C command).
>> Problem appears when I type this letter on keyboard; when I copy-pas=
te
>> it everyrhing is ok.
>
> That is interesting. It means git-gui can make the commit properly, b=
ut
> somehow the input method fails in the commit message form of the gui
> window. Do those letters show correctly in the form (but fail to comm=
it
> correctly), or do they appear incorrectly already at the time you try=
 to
> type them?
>
> That info could help windows folks find the cause.
>
> Michael
>
>> On Wed, Oct 31, 2012 at 5:57 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Usieva=C5=82ad =C4=8Corny venit, vidit, dixit 31.10.2012 15:39:
>>>> Hello!
>>>>
>>>> When I type comment message in Git Gui (1.8.0 and previous), I can=
't
>>>> use =C5=AC=C5=AD letter (U+016C, U+016D) =E2=80=94 it just transfo=
rms into simple Uu.
>>>> Please fix it.
>>>
>>> Can you tell us more about your environment (LANG setting, OS)? I j=
ust
>>> made two commits (1 with git-gui, one with git-commit on command li=
ne),
>>> and both come out fine (LANG=3Dde_DE.UTF-8, git version 1.8.0.226.g=
ba44ac5
>>> on Fedora 16):
>>>
>>> git log -2 -p
>>> commit 36de49231639eb9edccb1ebad595056d395141c7
>>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>>> Date:   Wed Oct 31 15:54:04 2012 +0100
>>>
>>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>
>>> diff --git a/a b/a
>>> index 1074042..677c385 100644
>>> --- a/a
>>> +++ b/a
>>> @@ -1 +1,2 @@
>>>  =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>
>>> commit cfcf8f021a53c1bf5ae018a723fbcfad8649a02b
>>> Author: Michael J Gruber <git@drmicha.warpmail.net>
>>> Date:   Wed Oct 31 15:52:52 2012 +0100
>>>
>>>     =C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>>
>>> diff --git a/a b/a
>>> new file mode 100644
>>> index 0000000..1074042
>>> --- /dev/null
>>> +++ b/a
>>> @@ -0,0 +1 @@
>>> +=C3=A4=C3=B6=C3=BC=C3=9F=C5=AC=C5=AD
>>
>>
>>



--=20
Z pavahaj, Usieva=C5=82ad =C4=8Corny
