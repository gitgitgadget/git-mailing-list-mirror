From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 21:41:46 -0500
Message-ID: <CAMP44s2bNQ2GCXGcZBQBcTa3BPXCt6vTUsG36b_4L1WzfN=aEQ@mail.gmail.com>
References: <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
	<CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
	<CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
	<CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
	<CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
	<CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
	<20130608171513.GA28029@sigill.intra.peff.net>
	<CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
	<20130609001025.GB29964@sigill.intra.peff.net>
	<CAMP44s21hyKLw0=hwOzuNzSuQx4qeca2VLnz9Reh5rD7j4oSrw@mail.gmail.com>
	<20130609022351.GA30393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVZt-0003Gy-QK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab3FIClt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 22:41:49 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36912 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3FICls (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:41:48 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so1165910lbi.20
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 19:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EQouwVB2y5Yl+GnzOmpna9eJga+Ix8uofsxSxd1qURw=;
        b=n129lVp4RJROd3vjSyuRoAt2tqRZj0jIRV8mvp+HLN3OV6p1TdgzoEp4DcCylPpd9Z
         RpHnKU4w4bqoKNxKzEyrcS6Br27vsJNgIIygHUIUbvZIfRkCzwnVOqsb3IU3/W4TeT1S
         Rj8slJECLYy3ibMkBnDjt1U1KZb1qtK3f7Ar0XQxkJDn4LV4c06L48vE8ObmDi1Mol5L
         luEMS4WtGV7JO6qgLp4n+3BbEPRXVHJ2fCnPuVwzS6Gtii5b96LSWNYhZQxUWgEYyc43
         L66HEO8PUF+TJ1sn0wre3Bvy+rgipU3wCtZUM8MmxTKrTADgtQueYZAqIbWCfNBbsy7i
         1Glw==
X-Received: by 10.152.27.170 with SMTP id u10mr2267521lag.45.1370745706798;
 Sat, 08 Jun 2013 19:41:46 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 19:41:46 -0700 (PDT)
In-Reply-To: <20130609022351.GA30393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226872>

On Sat, Jun 8, 2013 at 9:23 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 08:17:08PM -0500, Felipe Contreras wrote:
>
>> > No, I didn't say that at all.
>>
>> Then you truly think libgit2 will ever reach the point where it can
>> replace libgit.a?
>
> I don't know. It may. Or something like it may. It is certainly not
> ready to do so yet, but perhaps one day it will be.

Perhaps one day we would end poverty and hunger, and perhaps one day
we will live in peace, but I wouldn't hold on my breath. I fact, I'll
do the opposite, I bet it won't happen anytime soon.

>> It won't.
>
> Oh, I see, you were not actually interested in my answer and were just
> being rhetorical.
>
>> But decreeing that both projects should remain isolated, and
>> that libgit.a should never be a library, you are effectively
>> condemning the effort to fail, knowingly or not.
>
> Huh? When did I decree anything?

When you said in your opinion we should wait until libgit2 is ready,
and not improve libgit.a.

>> How many years has libgit2 been brewing? Do you think it's closer for
>> merging so it can be used by Git's core? No, it doesn't, and it will
>> not in the future, because it was never meant for that.
>
> There has been about 2 years of active development, and there's been
> quite a lot of improvement in that time. Closer than what? Than it was 2
> years ago? Yes, I think it is. But it still has a ways to go.

Why is it closer? In what ways is it a better fit now than 2 years
ago? What is missing before merging to be used in Git's core?

> I do not think there will be a flag day where we throw away git.git's
> code and start using libgit2. But we could slowly start replacing
> underlying bits with libgit2 bits, if that implementation proves to be
> robust and clean enough to do so.

And what are we waiting for then? Shouldn't we copy the whole libgit2
code and start migrating?

>> > But hey, you don't need to listen to me. If you think it would be easier
>> > to make the git.git code into a library, go ahead and work on it. But I
>> > think you will find that there are a large number of hard-to-find bugs
>> > caused by implicit assumptions about global state, how file descriptors
>> > are used, and so forth.
>>
>> That's impossible. Specially since moving irrelevant code out of
>> libgit.a is not permitted.
>
> I'm not even sure what your second sentence means.

It means this:
http://article.gmane.org/gmane.comp.version-control.git/226752

I move code that doesn't belong in a libgit library out of libgit.a,
and the change gets rejected.

> But it seems to me that the first step would be cleaning up the internal
> code so that it is more friendly to library callers (both in interface
> and in being re-entrant),

That is the second step. It doesn't make sense to make code
re-entrant, if that code will only be used by builtin commands. First
step is to move irrelevant code out of libgit.a.

>> >> There's a reason why the Git project doesn't use libgit2, and for the
>> >> same reason the official Ruby scripts should not use it.
>> >
>> > What reason is that?
>>
>> You tell me. Why isn't Git using libgit2?
>
> Wait, you indicated you had such a reason in mind, but now you won't
> tell me? Is it a secret?

I did not. I made the assumption that there was a reason, if there's
no reason to stay clear of libgit2, then let's merge it already.

>> > I think it is a matter of critical mass. If you were to start linking
>> > against libgit.a and 90% of it worked, you might have a reason to fix
>> > the other 10%. But I suspect it is more the other way around.
>>
>> It doesn't matter if it's 90% or 10%, it's the only thing we have.
>>
>> Unless you are in favor of including libgit2 and start using it for
>> Git's core *right now*, the only way forward is to improve libgit.a.
>
> That seems like a false choice to me. You obviously feel that libgit2 is
> some kind of dead end. I don't agree. Whatever.

I never said so. It is a dead end *if* we don't do an effort to have a
proper libgit library, which is the path we are taking.

> I have very little interest in discussing this further with you, as it
> is not leading in a productive direction. In my opinion, the productive
> things to do would be one (or both) of:
>
>   1. Work on libgit2.
>
>   2. Clean up non-reentrant bits of git.git, hopefully making the code
>      more readable and more modular (and taking care not to make it
>      worse in other ways, like maintainability or performance).

You forgot the first step of 2.: move irrelevant code out of libgit.a.

-- 
Felipe Contreras
