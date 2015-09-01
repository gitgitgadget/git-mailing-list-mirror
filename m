From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] mailmap: update my entry with new email address
Date: Tue, 1 Sep 2015 10:07:23 -0700
Message-ID: <CAGZ79kbo6vq8yvs0aMcZUX54w_CF0-=_Qqeq4VTio55ie7U0Yg@mail.gmail.com>
References: <55E5C92E.7040105@ramsayjones.plus.com>
	<01dbb6005800a8816a5f6b9ae740dbc9@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 19:07:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWp1u-0004uG-FG
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 19:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbbIARHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 13:07:25 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35796 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbbIARHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 13:07:24 -0400
Received: by qkcj187 with SMTP id j187so50339701qkc.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZLESjg9Wq1Tftg6obPc9kTiqWo2xmVgqWu02FQKN1ng=;
        b=j37/nS80daEjjbJzwqEBzX1a/M1UuIbJBTwlPrLXtndCGvr24UWGcAhzm9G3z836cn
         ebJ7DrveUet3JAIPz/R3qJ7T11+1j8YPVj9NzofF48SZ4DkEjF//Zpf20X6zOKRW3HV4
         RgLN+UhpR9nzCxuwUVtXoJ6+ryvGbY1DbsJIh1iOLYeSskxKeuvs5N7CyVukDVumaR96
         n1SuApc7NEM6JcXOUgORovzIB64ZUzm7MuL91y+ovlk5BqSgNcVBeBfejhHI6BnlAzwU
         k6BJ9ir8D4ptkF9cyKlUeMzbWC664XJIeXhsA7+8Hob8anObt+rGN5xUEH2YNbODxap8
         ujoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZLESjg9Wq1Tftg6obPc9kTiqWo2xmVgqWu02FQKN1ng=;
        b=UGOZTCFz2OfY5JNwydpHcjTWwHU+TJgr5hHppKEYa2QQiABXyF8TyNb6zms7IaQ/Yn
         y4LRIci3dRN2xDLP6n+iR3nditE1gFZpjtdsDlEzmw6lOlEG+fZ/42Io/ilAcv9cEZdu
         EeShw3ONxlumvivSczNMZ+8i21ZF/Ndnxr0evVhK8vbQjqmRs4phLOrx7frxGnWEcCC5
         hbeYHfyG+VhOJeX7U6w8xtezmcuJdLuBgCaHOxU38gIbGEy1mGZshp+VhYO84mN0plSH
         1hlcyadxPaUvfA3AjSOzb1RSy8TI+szECqd2cGut+12wyLOaqnEt5+pBUAVL0O+k0iAy
         u/qw==
X-Gm-Message-State: ALoCoQmOpz4IP8ylKPF+A4c7UtqXn0DLjWe9WPBj3XD5QFHdTTahJ2FiWEiW3AYqpToCve7C9GPw
X-Received: by 10.129.16.212 with SMTP id 203mr29651055ywq.142.1441127243304;
 Tue, 01 Sep 2015 10:07:23 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Tue, 1 Sep 2015 10:07:23 -0700 (PDT)
In-Reply-To: <01dbb6005800a8816a5f6b9ae740dbc9@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276993>

On Tue, Sep 1, 2015 at 9:11 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Ramsay,
>
> On 2015-09-01 17:50, Ramsay Jones wrote:
>
>> diff --git a/.mailmap b/.mailmap
>> index ece2951..e5b4126 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -186,7 +186,7 @@ Philip J=C3=A4genstedt <philip@foolip.org>
>> <philip.jagenstedt@gmail.com>
>>  Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
>>  Philippe Bruhat <book@cpan.org>
>>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>> -Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
>> +Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co=
=2Euk>
>>  Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
>>  Robert Fitzsimons <robfitz@273k.net>
>>  Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
>
> The idea of the .mailmap file is to fix inconsistent names in the his=
tory. For example, if you look e.g. at commit 6ebdee5af47df0c64354e4524=
19015a694c25f5f, you will see that your middle name was recorded, but i=
f you look e.g. at f84df81f654aeb0ac4582e0b3be162cba6ea5232 you will se=
e that it was not always recorded with your changes.

I would argue a mailmap file serves a dual purpose.
The first purpose as you said is to correct inconsistent or erroneous
names (who is sb@local.host anyway ?)

The second purpose is just as Ramsay used it to map different
identities to one person/email address.
As Ramsay lost his access to the email, you would want to use his new
email, say when looking for the right reviewer using git blame.
Then even old commits (with the old email recorded) should rather
display the new email, such that you get it right the first time.

>
> Therefore I would recommend leaving the old line in place, and just *=
adding* another one.

I would recommending taking this patch specifically for the second purp=
ose.

>
> Besides, for consistency I would leave the middle name in there. Othe=
rwise, people might be wondering why their shortlog calls bring up some=
 other name. In other words, if you add a new line, you really want to =
use the same clear name as before.

You can use the long form
  Name1 <email2> Name2 <email2>
in the .mailmap file to always show the Name1 and email1.

>
> You actually do not even need to add a new line if you plan on submit=
ting patches with your middle name. Remember: the main purpose of .mail=
map is to support shortlog, i.e. appropriate grouping of patches by per=
son (such as the two commits I mentioned above).
>
> Ciao,
> Johannes
>
> P.S.: That's a major bummer on your three forced-offline weeks. I fee=
l with ya!

Sometimes I'd love to be offline for 3 weeks. But being forced to? No t=
hanks!

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
