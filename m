From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 13:32:07 -0700
Message-ID: <72F9E3A0-BD79-48CF-9AA6-8473C38C0A98@gmail.com>
References: <1280326285-10203-1-git-send-email-avarab@gmail.com> <7vzkxb4j1v.fsf@alter.siamese.dyndns.org> <AANLkTimieHJaw1UmKtQvS4=2i8TrmR5A5zFO13NaNBo=@mail.gmail.com> <7861092D-582B-4918-AF3D-BF595B195673@gmail.com> <AANLkTimu35sWvQhCVDEQvT5Qswbgqxcnji_D0uR=heVm@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 22:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeDIZ-0002py-G9
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 22:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab0G1UcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 16:32:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60102 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249Ab0G1UcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 16:32:10 -0400
Received: by pwi5 with SMTP id 5so1060903pwi.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=TMliZVxSPvQPEcpAQBz/KRQBmLAUbHrBbDYAnm0doPk=;
        b=g+lHw44sriEq79R8dkwF1kWf9ExN0cBWTA5DAuKYJPeP4C0uoflAn9jIXJisCpi4hP
         vlv55vQB4ZCM/8ooJaejjoCmryyYFKW+OyLqTjHXm3Q1pIQolO2za8r9pygrjNe6nSrA
         7ydhHGyNMmiQiaR3fbQI+/NoIDBrGKKlSPCZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=Ica+/j3/WTyNjEHh/TInu5+5WGvFEYOcTjiQEk/n/SK1USG/M+SkJbPM3u/71430em
         kFzbkHsZn6hOmidYIoHKrYVa2Td1IsPvKRytR7kkvs44+UtDgCtrEbE2JJEYHAytgFkP
         dIx9ncAAsX5OBDhKxizmrXzpQtHhcKLLD3uWE=
Received: by 10.142.171.7 with SMTP id t7mr12368240wfe.48.1280349129836;
        Wed, 28 Jul 2010 13:32:09 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 33sm7559019wfg.9.2010.07.28.13.32.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 13:32:09 -0700 (PDT)
In-Reply-To: <AANLkTimu35sWvQhCVDEQvT5Qswbgqxcnji_D0uR=heVm@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152118>

On Jul 28, 2010, at 1:15 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Wed, Jul 28, 2010 at 19:49, Joshua Juran <jjuran@gmail.com> wrote:
>> On Jul 28, 2010, at 12:25 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>
>>> On Wed, Jul 28, 2010 at 17:23, Junio C Hamano <gitster@pobox.com> =20
>>> wrote:
>>>
>>>> Hmph, we probably would want to do s/50 character/&s/ in the two =20
>>>> manual
>>>> pages.
>>>
>>> I'm not sure if "with a single short (less than 50 character) =20
>>> line" is
>>> is grammatically correct with "characters", since "characters line"
>>> wouldn't make sense.
>>>
>>> On the other hand that sentence violates the rule that when you put
>>> something in parens your sentence should still make sense with
>>> s/[()]//g, "a single short less than 50 character line" is pushing =
=20
>>> it.
>>
>> If the number of characters is less than 50, then there are fewer =20
>> than 50
>> characters.

This demonstrates the distinction between "less" and "fewer".  =20
Intensities (like raw numbers) and mass quantities are less; discrete =20
objects are fewer.

>> This is a short line of fewer than 50 characters.

This demonstrates a grammatically correct way of phrasing a constraint =
=20
on line length.  I could have put the latter half in parentheses, but =20
then it wouldn't be true.  :-)

> I don't understand the context of that remark or what you're replying
> to.
>
> I meant that I found the "single short (less than 50 character) line"
> bit in git-commit.txt, gittutorial.txt and user-manual.txt odd to
> read.

Agreed.

> What did you mean?

See above.  You could also use "50-character" as an adjective, but =20
"single short line (of fewer than 50 characters)" may be more easily =20
parsed.  Another option is "single short line (shorter than 50 =20
characters)".  I find it less stilted without "of fewer", but the =20
repetition of "short" is a little clumsy.

Josh
