From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Wed, 22 May 2013 16:09:31 +0200
Message-ID: <CAN0XMOJuWTZLOYHafjZTBkazV2diuT_ZfD551kMZz-XQUBg66g@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<alpine.LNX.2.01.1305131542210.30808@nerf07.vanv.qr>
	<001d01ce500b$c7c08b70$5741a250$@scanmyfood.de>
	<alpine.LNX.2.01.1305132119220.2288@nerf07.vanv.qr>
	<CAN0XMOL3rkYDinSCN2GLaRj7dOvbF=SdMRxM4PHCZ5h7g5Nkkw@mail.gmail.com>
	<51936218.9020306@ira.uka.de>
	<519370D3.3000306@web.de>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<51949D65.7050001@ira.uka.de>
	<CAN0XMOJutVZ9ZX-0a=T38AnzH9SQN=X_pu-6+tTRifbL-zQigg@mail.gmail.com>
	<51999FFF.8090004@gspranz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Christian Stimming <stimming@tuhh.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 22 16:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf9ja-0002Fd-D4
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab3EVOJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 May 2013 10:09:38 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:38180 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3EVOJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 10:09:37 -0400
Received: by mail-wg0-f41.google.com with SMTP id c11so2618395wgh.2
        for <git@vger.kernel.org>; Wed, 22 May 2013 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5LB5RDBMP+JIQG7S0WougiMtaAowN9wQFmeyFBdYpOk=;
        b=PNH9peAL0JOU9Xc7LiFBlevhKneUH4owOjyrYRF5HGcO/YcefrKYzM6cZrTQQHhktt
         DvH3R7Eugl/lIxmfOuLTRMGJ8NMYrcQZ5jj8wdRaZzJlqE5wY6A4aDeTT1/Z0WoAmNAe
         34hXLlJMmJyxS+2it1zduq6TaWDJxjxq0eBMalJseaj80nGiO9acYTQM/A4bRzLtqcEJ
         cIT+GrYJV3VfXfzN8iCLu53SVPwWlwOWIoQ6HeQXnG3WKP9Ln8mX4moakIVXf2OUcQCJ
         y0nqAeyKMWlU3lfC3IpmmG0E+oeLZkg1fAMNNJTugZTGRzgg6r1jkrgIohfpZd+cdJPu
         aNXA==
X-Received: by 10.180.14.199 with SMTP id r7mr15283849wic.6.1369231772094;
 Wed, 22 May 2013 07:09:32 -0700 (PDT)
Received: by 10.194.71.44 with HTTP; Wed, 22 May 2013 07:09:31 -0700 (PDT)
In-Reply-To: <51999FFF.8090004@gspranz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225160>

2013/5/20 Holger Hellmuth <holger@gspranz.de>:
> Am 19.05.2013 18:56, schrieb Ralf Thielow:
>
>> 2013/5/16 Holger Hellmuth (IKS) <hellmuth@ira.uka.de>:
>>>
>>>
>> [...]
>>>>
>>>> +    reset =3D neu setzen (maybe "umsetzen"?)
>>>
>>>
>>>
>>> "zur=C3=BCcksetzen"
>>>
>>
>> "reset" can be used with every existing commit. "zur=C3=BCcksetzen"
>> would imply that it have to be a recent commit, no?
>
>
> It implies that it sets to something that already existed or came bef=
ore.
> So it even fits in a case where you reset to an older commit and rese=
t back
> to HEAD because the HEAD commit existed already.
>
> If you still don't like it, I would prefer "umsetzen" to "neu setzen"=
=2E
>

I'd still understand "zur=C3=BCcksetzen" as "set something *back* to" b=
ut this
"back" can also be something that was made after HEAD perhaps on
another branch and HEAD (or the current ref) was never at this point be=
fore,
so "zur=C3=BCcksetzen" is not true in this case.

I prefer "umsetzen" to "neu setzen", too. I'll change the glossary to t=
his.

Thanks

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
