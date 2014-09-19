From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/7] part1: l10n: de.po: use imperative form for command options
Date: Fri, 19 Sep 2014 22:43:37 +0200
Message-ID: <CAN0XMO+BR4Tp1EOCPe-ajNyuHpkN1B36T3rzRdw1Z_tzsZH6Dg@mail.gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
	<1411146770-8508-2-git-send-email-ralf.thielow@gmail.com>
	<541C7FF7.1020105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:43:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV51r-0006kj-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 22:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbaISUnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2014 16:43:39 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42641 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261AbaISUni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2014 16:43:38 -0400
Received: by mail-wi0-f174.google.com with SMTP id fb4so194191wid.13
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HNc7zIV+QnDZlJHlHD541z5JuT/6nKpwXSHMwT9aXQk=;
        b=A9xZsiLwSCaa+wleiYb7Aeo8u3esy5eAFkwOsSu41XsZ+6md2iDDl5RrmwFxAvVRH1
         wMWqNGtTH0t7UnI34HNpvbA60BqiJZOVtKmkeLX92VBfqUBMyANIVz0T/3DUxHNNN7gh
         /yFSZ9aBZ9IgActJpwRfriOtaf/003fokALEBgm+eZkNHAI5z/WpvokItA1PtrkHskn4
         W+MHm+80SePfp+6B6XL51HHVk8LkbDjyTLViaqd5gxYoQo6ZrxS2RuXDvqnP4IolaZsR
         puxkp89ZPISSvCo1RpY5anZqIlw5+sBEvByY6UbvHwlqGo0xV39ZWb24HVFee8QR31WM
         gd8Q==
X-Received: by 10.180.221.107 with SMTP id qd11mr517739wic.61.1411159417575;
 Fri, 19 Sep 2014 13:43:37 -0700 (PDT)
Received: by 10.194.173.167 with HTTP; Fri, 19 Sep 2014 13:43:37 -0700 (PDT)
In-Reply-To: <541C7FF7.1020105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257307>

Hi Phillip,

2014-09-19 21:11 GMT+02:00 Phillip Sz <phillip.szelat@gmail.com>:
> Hi,
>
>>  #: archive.c:351 builtin/archive.c:91
>>  msgid "retrieve the archive from remote repository <repo>"
>> -msgstr "ruft das Archiv von Remote-Repository <Repository> ab"
>> +msgstr "Archiv von Remote-Repository <Repository> abrufen"
>>
>
> "Archiv vom Remote-Repository <Repository> abrufen" sounds better to =
me.
>

Thanks.

>>  #: builtin/add.c:256
>>  msgid "record only the fact that the path will be added later"
>> -msgstr "speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt w=
erden soll"
>> +msgstr "nur speichern, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt w=
erden soll"
>>
>
> "nur speichern, so dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werden =
soll" maybe
> use a full sentence?
>

With the additional "so" the message doesn't sound correct to me.

>>  #: builtin/apply.c:4378
>>  msgid "instead of applying the patch, see if the patch is applicabl=
e"
>> @@ -2472,27 +2472,27 @@ msgstr ""
>>  #: builtin/apply.c:4380
>>  msgid "make sure the patch is applicable to the current index"
>>  msgstr ""
>> -"stellt sicher, dass der Patch in der aktuellen Staging-Area angewe=
ndet "
>> +"sicher stellen, dass der Patch in der aktuellen Staging-Area angew=
endet "

I think we should write it "sicherstellen".

>>  "werden kann"
>>
>
> "stellen Sie sicher, dass der Patch in der aktuellen Staging-Area
> angewendet "
> "werden kann" Someone is addressed dirctly.
>

Addressing the user this way makes the user think that she has to do
something, but using an option tells Git to do something.

Thanks,
Ralf

> Phillip
