From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Mon, 2 Aug 2010 21:25:13 +0000
Message-ID: <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2Vh-0005ia-Dt
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab0HBVZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 17:25:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60626 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0HBVZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 17:25:14 -0400
Received: by iwn7 with SMTP id 7so4425420iwn.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1A+Mj/OjepYXWfBEHRyilc6GIOx0MtYefDQqNVOZQbk=;
        b=a7/VKs1Z+gkfSIvTCO9d6Foqh5kBvs/sp2KFMbzV8ibUUPFijP8Kr9qDVD9alWak/S
         nSXy6Qu2S2olRqbA1YSUpXd1EsG357hsuXtr//sk/ycHG35uhx3zIoWbsxlCjFHzdN5o
         M4cVh+kawULWyzrYODto/PZd9c2GTlmIwtnrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uMvD3uN5X3ydYh3TLAASFecBlKiTiRhSFWSSnv0gz19N5k6JQBOO+Iznj8bS7IsEKK
         28d6jg75DZCCve9iovIlj6KdXryMmIhiSckUwuUYQBZyhENpfLFkzEm4+PER0MC3c9MB
         l+J/O7qq/n+tTLZVMKFW4leJ0MH5WudWYP/D4=
Received: by 10.231.38.9 with SMTP id z9mr1881587ibd.17.1280784313506; Mon, 02 
	Aug 2010 14:25:13 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 14:25:13 -0700 (PDT)
In-Reply-To: <i372v0$3np$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152462>

On Mon, Aug 2, 2010 at 18:32, Joel C. Salomon <joelcsalomon@gmail.com> =
wrote:
> I'd figured to play with Git in an unusual way: to create a repositor=
y
> for the U.S. Constitution where amendments are presented as patches.
> E.g., instead of the First Amendment being placed at the end (as is
> usual) I'm putting it in Article 1, Section 9 (Limitations of Congres=
s).
> =C2=A0Proposed amendments get branches, which get merged in later.
>
> But I'm trying to get the dates right, and I'm missing something. =C2=
=A0For
> example, I made the initial commit with the line

As noted by Shawn time_t doesn't like ancient commits. But as an aside
I'd like to ask where this project is being hosted. I've wanted to
play with importing law into Git, and it would be interesting to
follow this project.

There's some Icelandic law currently enacted that hasn't been changed
since the 1200s. Getting that into Git would be interesting.
