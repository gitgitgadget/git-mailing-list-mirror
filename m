From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.6.0 round 1
Date: Sat, 5 Sep 2015 21:30:23 +0800
Message-ID: <CANYiYbHknxRnDXLBwwj9-kB4JvciP3C0aQiCptL=hqWC-_1CVA@mail.gmail.com>
References: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
	<2019620.IQg8023dli@cayenne>
	<CANYiYbF3p-yHBhzyfU1WQhjRZEqjXotsQS+x5K2EbatnAGuJrw@mail.gmail.com>
	<20150905132148.GC27660@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 15:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDYS-0007sA-5d
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbbIENac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2015 09:30:32 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35056 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbbIENaY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2015 09:30:24 -0400
Received: by wicge5 with SMTP id ge5so41555365wic.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DyQkIp2B3JrEcvpZeH94UwwOd+szUfrjrkrRQWqc/Yo=;
        b=RrC3z/5soAW+YslCG1QWmdoDtVE/iNGd0p43jdrmXCY+RsV5onP8WLP9UPQSQ8ta0F
         6TbgDRgzDVY1J/NeKyq1h9jEoK8YsJZMkA37Of4VT/bw7zPFyi2PH88ROKB1n50UU9Lw
         paMj9r/n6m/H8FmLztERJZ9x0m3ae7ZOQfVphBVeH9ScbvBBiMvi2RvEh1W3xEIQvcsY
         c6C5Ot3G+WML/i6zz7QL4Xw0R60mAle1BXiWjTFklk06zGox6LNYxgcbE86kk3Ft9XVV
         MpYI0u25BRg5IJQjGjhNHk+YYqwMxt7yMNnpixc0PRlCIEgJREdvPO+CCpCTN3IT3omh
         f8aw==
X-Received: by 10.180.100.74 with SMTP id ew10mr17718040wib.12.1441459823648;
 Sat, 05 Sep 2015 06:30:23 -0700 (PDT)
Received: by 10.194.76.230 with HTTP; Sat, 5 Sep 2015 06:30:23 -0700 (PDT)
In-Reply-To: <20150905132148.GC27660@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277377>

2015-09-05 21:21 GMT+08:00 John Keeping <john@keeping.me.uk>:
> On Sat, Sep 05, 2015 at 09:14:18PM +0800, Jiang Xin wrote:
>> 2015-09-05 18:02 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
>> > Le samedi 5 septembre 2015, 10:17:54 Jiang Xin a =C3=A9crit :
>> >> Hi,
>> >>
>> >> Git v2.6.0-rc0 has been released, and it's time to start new roun=
d of git
>> >> l10n. This time there are 123 updated messages need to be transla=
ted since
>> >> last update:
>> >>
>> >>     l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
>> >>
>> >>     Generate po/git.pot from v2.6.0-rc0-24-gec371ff for git v2.6.=
0 l10n
>> >>     round 1.
>> >>
>> >>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> >>
>> >> You can get it from the usual place:
>> >>
>> >>     https://github.com/git-l10n/git-po/
>> >>
>> >> As how to update your XX.po and help to translate Git, please see
>> >> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README"=
 file.
>> >>
>> >> --
>> >> Jiang Xin
>> >
>> >
>> > Some new strings are not consistent with the actual set.
>> >
>> > For instance, in the "Could not ..." strings were all with capital=
s, and some
>> > new ones are not. Last time, I remarked strings which were almost =
exactly the
>> > same (only difference was a final dot, if I remember). Some help s=
trings were
>> > mixing different styles.
>>
>> Before this update, "Could not" vs "could not" is 50:40, and now it'=
s 50:50.
>>
>>     $ grep 'Could not' po/git.pot  | wc -l
>>     50
>>
>>     $ grep 'could not' po/git.pot  | wc -l
>>     50
>
> Note that Documentation/CodingGuidelines has a section on error messa=
ges
> which says:
>
>  - Do not end error messages with a full stop.
>
>  - Do not capitalize ("unable to open %s", not "Unable to open %s")
>
>  - Say what the error is first ("cannot open %s", not "%s: cannot ope=
n")

Wow, we know how to fix.
