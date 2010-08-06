From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 6 Aug 2010 16:50:29 +0000
Message-ID: <AANLkTi=twbd=nHrDOnPjcBUdHEa=xkGGC6uqGdjSid+B@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
	<4C5B2F2E.4050709@gmail.com>
	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
	<AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
	<AANLkTinXtjn7=9jRNmv4zhhPiy3NVOca0gY9dkYCUhY7@mail.gmail.com>
	<H6efS0hBcmgNGLKlyPGmiuLIrxCvE4xIoIvXe6hvCJ0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 06 18:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhQ7w-0002Kw-7H
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761200Ab0HFQuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 12:50:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33296 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018Ab0HFQua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 12:50:30 -0400
Received: by gyg10 with SMTP id 10so2917372gyg.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+DKAwjShWalDQ0b/3ggW4bzTV9LnXmOxH9+jbJ/I7CQ=;
        b=m2c9J2pLfXqJpltMDKe3athLPMLjySAxHBEJuKaB5t1DLc283DSj/1R/1nItDindZG
         RIznZJnJURjAzoxHN2xCpGekeOCiE8Ia0CvZYLgmwCrQ6uAfFKSd39+ob1StAZQoIl8s
         btLDrOs3hdPX8w3+McZwfMs01qe55fnVnMWSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hGYqnfb6iF3RsQSeMubPbaKT9y3zkVaf+04buRy6XL5v1Qp8X/zYYl26bo3Lko7VJN
         LiY+E6y955h7s1gRE5OhbWM8JdrbftgRBf/8zd3I2q/PoIYCKWff8hmNb6ILB5Yb0jMY
         xPqY/1QBIVO+K7Yt33XJ8/y4+O75ZNx4fSU0o=
Received: by 10.150.47.37 with SMTP id u37mr14099583ybu.47.1281113429771; Fri, 
	06 Aug 2010 09:50:29 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 09:50:29 -0700 (PDT)
In-Reply-To: <H6efS0hBcmgNGLKlyPGmiuLIrxCvE4xIoIvXe6hvCJ0@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152795>

On Fri, Aug 6, 2010 at 16:00, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Aug 6, 2010 at 15:18, Joel C. Salomon <joelcsalomon@gmail.co=
m> wrote:
>>> On Thu, Aug 5, 2010 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>>> <avarab@gmail.com> wrote:
>>>> On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.=
com> wrote:
>>>>> It's up, at <http://github.com/jcsalomon/constitution>, with one =
commit.
>>>>>
>>>>> I'm curious to find out if folks with 64-bit time_t get the corre=
ct
>>>>> author and commit times.
>>>> On 32bit:
>>>>
>>>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>>>> Author: The Philadelphia Convention <>
>>>> Date: =C2=A0 Wed Dec 31 19:59:59 1969 -0400
>>>>
>>>> On 64bit:
>>>>
>>>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>>>> Author: The Philadelphia Convention <>
>>>> Date: =C2=A0 Mon Sep 17 13:00:00 1787 -0400
>>> Cool, it works! =C2=A0(The 13:00 should have been 12:00, but there'=
s some
>>> DST weirdness at work.)
>>>
>>> Can you check what git-fsck has to say about the repos, on 32- &
>>> 64-bit machines?
>>
>> 32bit says:
>>
>> =C2=A0 =C2=A0 error in commit 826a4f7721fe1c3963a733ecbc5422f05925af=
5d: invalid
>> author/committer line
>>
>> 64 bit doesn't give any warning at all.
>
> I don't think you're using the latest git.

Guilty as charged. It's a Debian 1.7.1 git.

> I get this on 64 bit:
>
> =C2=A0 error in commit 826a4f7721fe1c3963a733ecbc5422f05925af5d: inva=
lid author/committer line - bad date
>
> This is triggered by the negative sign '-' in front of the time
> field which is not one of 0123456789. =C2=A0See fsck.c line 244.
>
> -brandon
>
