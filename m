From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIGwxMG46IGRlLnBvOiB1c2UgImJsYSDigKYiIGluc3RlYWQgbw==?=
	=?UTF-8?B?ZiAiYmxhLi4uIg==?=
Date: Tue, 24 Mar 2015 18:51:06 +0100
Message-ID: <CAN0XMOKVAebs6xNuLLNvzi8gkARsmSgNC1k+TuS23BxqCffOig@mail.gmail.com>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
	<CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
	<551190F2.10808@drmicha.warpmail.net>
	<20150324171044.GA4414@ralf-ubuntu>
	<xmqqlhim713w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Phillip Sz <phillip.szelat@gmail.com>,
	git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:51:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSz1-0007OU-BT
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084AbbCXRvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 13:51:11 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:34194 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756857AbbCXRvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 13:51:08 -0400
Received: by wegp1 with SMTP id p1so343200weg.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5taNB9qiIy5C1nEq8jEKofS8nPQwrTl0rUKQJkanlL0=;
        b=h33T4QqF/R2yGhQTVkHxlgyCVXMpnb+NCx0l/aDOXcV0KrKsOCQU8yEH1ZxLiFbPf4
         orcaSGe83ngAkq74dib/6nIP0WXNXbxY6HCZirlgdpfDsiDYSR5q47Bw9COUz1CNZ1q6
         0VPLJDMzBP1T0oS7XANFpp7LWX+gc2PAYEIBm1YNpk5P1XFnZt5u6+Q1Oe3HszIp5Wr9
         9qr6la4osQIryYlAcmXNQc4/seyN3DlfS1vdZ0jMXQcdkFoCReDIDUG4Vy49mYGZcLzk
         t0sQXoCMwUELc909p5yqh5Kd+uKlVr9S+B3fP5lG+7bFR6eCTi5XQu0wkqYWG5f7KjF8
         R0+A==
X-Received: by 10.181.11.202 with SMTP id ek10mr29461350wid.37.1427219467003;
 Tue, 24 Mar 2015 10:51:07 -0700 (PDT)
Received: by 10.194.72.5 with HTTP; Tue, 24 Mar 2015 10:51:06 -0700 (PDT)
In-Reply-To: <xmqqlhim713w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266212>

2015-03-24 18:32 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> diff --git a/po/de.po b/po/de.po
>> index 11fbd0f..9fa3f4c 100644
>> --- a/po/de.po
>> +++ b/po/de.po
>> @@ -616,7 +616,7 @@ msgstr ""
>>  #: help.c:373
>>  #, c-format
>>  msgid "in %0.1f seconds automatically..."
>> -msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden..."
>> +msgstr "Automatische Ausf=C3=BChrung in %0.1f Sekunden ..."
>>
>>  #: help.c:380
>>  #, c-format
>> @@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=C3=BC=
r %s bekommen"
>>  #: sequencer.c:611
>>  #, c-format
>>  msgid "could not revert %s... %s"
>> -msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren... %s"
>> +msgstr "Konnte \"revert\" nicht auf %s ausf=C3=BChren ... %s"
>
> I do not read German, but aren't these two completely in different
> classes?  The first one is not abbreviating any part of a word, but
> the second one's first "..." is showing that %s is not giving the
> full word (it is fed the find-unique-abbrev result and adding ...
> to say it is not a full 40-hex).
>
> I do not read German, but I would not be surprised if the original
> were a mistranslation.  Is it saying
>
>         Could not revert THAT ONE ... THE SUBJECT OF THE COMMIT
>
> as if "..." is some punctuation in the sentence (i.e. it could have
> been a ';' or ':' or '.' that ends the first part of the sentence,
> but "..." is used to tell the reader to "wait a bit before
> continuing with the rest of the sentence"), not as part of "THAT
> ONE"?  The "..." in the original is a three-dot that means "we say
> THAT ONE but it is not fully spelled out, there are more letters
> here".
>
> Please ignore the above if the convention in German is to have SP
> before three-dots for both cases.  I do not read German.
>
> Still the placement of a word "perform" (ausf=C3=BChren) between "%s"=
 and
> "..." in the translation of the second one looks suspicious to me,
> though.
>
>> @@ -9865,7 +9865,7 @@ msgstr "fehlerhaftes Objekt bei '%s'"
>>  #: builtin/tag.c:301
>>  #, c-format
>>  msgid "tag name too long: %.*s..."
>> -msgstr "Tagname zu lang: %.*s..."
>> +msgstr "Tagname zu lang: %.*s ..."
>
> This is also "We are not spelling it fully and there are actually
> some more letters in the original" three-dots.

You're right. I just misinterpreted the dots. It seems I'm chatting
too much where "..." means nothing but space. ;-)
I'll fix it in this patch and will check other messages later.
Thanks
