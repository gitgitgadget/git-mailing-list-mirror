From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Promoting Git developers
Date: Sun, 15 Mar 2015 10:12:00 +0100
Message-ID: <CAP8UFD2s4e7D1vRKtvB8JcqoDs=VdVW-HV0PfY6g37u_9zU6Dw@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
	<xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
	<20150311073129.GA5947@peff.net>
	<xmqq61a64xg8.fsf@gitster.dls.corp.google.com>
	<20150312223836.GB24492@peff.net>
	<xmqq7ful257z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Jason St. John" <jstjohn@purdue.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 10:12:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX4ad-0008JE-Tp
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 10:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbbCOJME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 05:12:04 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38387 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbCOJMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 05:12:01 -0400
Received: by igbue6 with SMTP id ue6so18095654igb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T0FGjhedBtB4buBmufJF098XQkdiwOiEM2QCbF2zVy0=;
        b=cngJerpD9zPm69RkvjwvoPxGgBWXAxokPJ9h36HX0+3dJYaMVWZWg4ZeefgkKbZmaQ
         FQM/taVMdpcglTtYAjiAkodeZ9ahwImznvmE03H8pe+0zU5dVn4IN0sMWOQ2qwuMVInO
         cXsClFcys97bqYDcUZSFeU27/rbrbC9BU6+FocTrhL46/Te+QPVLvq+Nor4v4Pmp/CpX
         Qrtqr7ik6BkdyUzLDI2yfW6dShYHpF6MdvRbRLBWwLU0zUWTugCaq1/hMmJ0MU6tO/GV
         Mwt/+zEYhvCkAuU6Fppwx4mMF77jItkFc9Zz3/Cm85/EKs1+OafIMcXSCQc34tM9CX9d
         rYZA==
X-Received: by 10.50.253.12 with SMTP id zw12mr123344833igc.24.1426410720751;
 Sun, 15 Mar 2015 02:12:00 -0700 (PDT)
Received: by 10.50.245.144 with HTTP; Sun, 15 Mar 2015 02:12:00 -0700 (PDT)
In-Reply-To: <xmqq7ful257z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265487>

On Thu, Mar 12, 2015 at 11:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Seeing my name in "shortlog" was nice, but not that exciting. I
>> submitted a patch, it was taken, and of course it ends up in any
>> automated lists of authors. What was much more rewarding was being
>> mentioned specifically in "A note from the maintainer" as a helpful
>> person. That had much more value because:
>>
>>   1. It was one of a handful of names.
>>
>>   2. It was picked by a human.
>>
>> So in that sense, it is quite the opposite of including shortlog output
>> in the release announcements (I still think the shortlog thing we have
>> been discussing is a good thing, but not at the same level).
>
> Yes, and that cuts both ways, unfortunately. There always will be "I
> am doing more reviews than X and my reviews are higher quality. Why
> was X singled out and got thanked but not me?", "X is really doing a
> good job reviewing in this cycle, but could other people who send
> reviews of lessor quality (to my mind) feel that it is unjustified
> if I thanked X and nobody else?", etc. A mechanically generated list
> avoids these issues, but the satisfaction you get from being on the
> list is not very high, exactly because it is not hand picked.

I think it is still much better to have some people positively hand
picked than nothing.
People who have not been hand picked despite having done something
they think is of the same or higher quality can always ask privately
about the reason they haven't been hand picked or they can try again
expecting that the outcome will be different next time.

Anyway if some people are positively hand picked you can always hope
that it will happen to you, while otherwise there is no hope at all.

>> I do not know that it is worth having a "Best of 2015" Git awards
>> ceremony, but it is sometimes nice to thank people personally when
>> you appreciate their efforts. I sometimes mail people off-list to
>> do so.
>
> Yeah, I do the same, but revealing that we do so would defeat what
> we tried to achieve by doing so off-list in the first place. Now
> those who haven't got such a piece of e-mail for a while can start
> to suspect that they have fallen out of favour or something ;-(.

I don't think it defeat anything. I think you could even do it more online.

Best,
Christian.
