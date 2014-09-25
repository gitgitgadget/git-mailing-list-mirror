From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 3/7] part3: l10n: de.po: use imperative form for command options
Date: Thu, 25 Sep 2014 20:04:51 +0200
Message-ID: <CAN0XMO+z-PbcLWO-OS04LeALzDvS5kXsnEB=hZTRGAWhTBVC0g@mail.gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com>
	<1411146770-8508-4-git-send-email-ralf.thielow@gmail.com>
	<54214A4D.8080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 20:05:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXDPX-0003WD-6A
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 20:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbaIYSEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 14:04:54 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35346 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbaIYSEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 14:04:53 -0400
Received: by mail-wi0-f173.google.com with SMTP id r20so9471056wiv.6
        for <git@vger.kernel.org>; Thu, 25 Sep 2014 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VoIoGSEInpS83tlK7DLi930Vjais0S5W1vR3dBkbg+s=;
        b=B2bw1xxoz9wMMnlSdyq9Pkmb7+9+NYnWCe4jDp2EF8QOn1+hjlX+FgntUGlAAPMmZy
         2uDmFftLbExtSBYzVdeMjusURNotAaGDsJfTvqmN9/4Qfm38BjamTfIRi7IDDLcXwvYa
         ppFotuzSbT8Xdl0qJXaWHxoVnIxgQvS1+vEDnZuncEytzDzzUx92BRxn2Pw7rzh/zsJJ
         7dMNwWU07sMPVwE3eMURmg1utM8eRo1E6pSnf97MPmwiaXtB0xJ+zNqlyleKz9w96fBn
         v2E/9cuRi8CE9WVFE87wsJy05hDCgQug5je8PHX4sGelrOQHXPMx4BI6XXxEPYHC3F70
         9BvQ==
X-Received: by 10.180.188.49 with SMTP id fx17mr40337967wic.17.1411668291914;
 Thu, 25 Sep 2014 11:04:51 -0700 (PDT)
Received: by 10.194.173.167 with HTTP; Thu, 25 Sep 2014 11:04:51 -0700 (PDT)
In-Reply-To: <54214A4D.8080904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257488>

Hi,

2014-09-23 12:24 GMT+02:00 Phillip Sz <phillip.szelat@gmail.com>:
> Hi,
>
>>  #: builtin/describe.c:395
>>  msgid "find the tag that comes after the commit"
>> -msgstr "findet das Tag, das nach Commit kommt"
>> +msgstr "das Tag finden, das nach Commit kommt"
>>
>
> "das Tag finden, das nach dem Commit kommt"
>
>>  #: builtin/fast-export.c:718
>>  msgid "Use the done feature to terminate the stream"
>> -msgstr "Benutzt die \"done\"-Funktion um den Strom abzuschlie=C3=9F=
en"
>> +msgstr "die \"done\"-Funktion benutzen um den Strom abzuschlie=C3=9F=
en"
>>
>
> "die \"done\"-Funktion benutzen, um den Strom abzuschlie=C3=9Fen"

You send a patch for the comma before "um" (thanks for that). I'll reba=
se
these patches on top of that before applying, so the comma will be adde=
d
then.

>
> Maybe its better to use =C2=BBStream=C2=BB instead of =C2=BBStrom=C2=AB=
 in general?
>

What about "Datenstrom"?

> Phillip
>
>
