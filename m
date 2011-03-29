From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 02/10] Docs: git tag: peoples back -> people's backs
Date: Mon, 28 Mar 2011 21:02:56 -0500
Message-ID: <AANLkTinNb+GxEFDs_+KQvRyt4N=WrDmncUnbaCqAnAqM@mail.gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
 <1301327622-8595-3-git-send-email-mfwitten@gmail.com> <4D90CD1B.4030906@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 04:03:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4OHM-0004Gb-LW
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 04:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1C2CD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 22:03:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49516 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1C2CD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 22:03:26 -0400
Received: by iyb14 with SMTP id 14so3758075iyb.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 19:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=oFvqGMAupm0kHU8jyLyX1mSo1Flm997YIPyPGY93Aqg=;
        b=NKcKY9SUFqjnAtyKjQ9mv1FKGMZ8MWNEU/eN5uW01apN8WTqvbxHxSFcEMWazdhz7e
         MyBPYupTIdSDlpjWzbJA+PzczcE6bScUmO89NA6Jw+cAnpeGMFTeYuoEGUhYT9r+St0H
         tXeFalchUnfMwSM53hqF/i3yQjX/fTy854UV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BpF/+Bn6j/ip7U3p/cBz6qybMPTONR/VS3D4WUO9w+LklxW2cb9fBy8vo6+0yMbcd8
         BlUk1au4GOtWaohy2eI1/RtI19OKnT7jhU9mz+SSmn07tA1hl9gNUeDKHTL4uJClwsEa
         UmWWe09OyZirh66MEAzLDelDw5DsHPZnSruJk=
Received: by 10.43.52.69 with SMTP id vl5mr806516icb.346.1301364206048; Mon,
 28 Mar 2011 19:03:26 -0700 (PDT)
Received: by 10.42.166.200 with HTTP; Mon, 28 Mar 2011 19:02:56 -0700 (PDT)
In-Reply-To: <4D90CD1B.4030906@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170215>

On Mon, Mar 28, 2011 at 13:02, Eric Raible <raible@nextest.com> wrote:
> On 11:59 AM, Michael Witten wrote:
>> Signed-off-by: Michael Witten <mfwitten@gmail.com>
>> ---
>> =C2=A0Documentation/git-tag.txt | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 7844ff1..e276393 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -169,7 +169,7 @@ Sorry for the inconvenience.
>> =C2=A0------------
>>
>> =C2=A0Does this seem a bit complicated? =C2=A0It *should* be. There =
is no
>> -way that it would be correct to just "fix" it behind peoples
>> +way that it would be correct to just "fix" it behind people's
>> =C2=A0backs. People need to know that their tags might have been
>> =C2=A0changed.
>
> s/people's/peoples'/

Actually, "people" is already plural, and thus "people's" is the
correct possessive form (as with "women" and "women's"); "peoples", on
the other hand, means diffent groups of people. For instance:

  There are many people in China.

  Each of the various peoples in China has
  its own language; Hokkien is the language
  of my particular people.

At least that's how I know the usage.

How about changing it to "behind a person's back"? Perhaps the whole
informal tone is what needs to be changed.

> Or probably even better:
>
> /behind people's backs/automatically/

I don't feel that the word "automatically" sufficiently conveys the
unexpected nature of such an event.
