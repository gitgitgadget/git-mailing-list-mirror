From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Proposal for new Git Wiki admin
Date: Wed, 11 Aug 2010 17:49:59 +0300
Message-ID: <AANLkTimQsNj-3M=y7Dop4brB8U-8vVPqgD0+zBX5R6FG@mail.gmail.com>
References: <20100810162602.GG3921@kytes>
	<m3y6ce2kdz.fsf@localhost.localdomain>
	<20100811050056.GA3715@kytes>
	<4C62494A.2030805@drmicha.warpmail.net>
	<AANLkTimuHzC_brw2bBDTvc=-Cj+70AMFEj7nzspW5mGq@mail.gmail.com>
	<20100811134640.GA10888@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 16:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCd9-0004K8-QG
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 16:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab0HKOuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 10:50:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0HKOuD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 10:50:03 -0400
Received: by bwz3 with SMTP id 3so166912bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mscv0e2KC4+8ZLSj39BdYP8ZUPfw1IF+/qs+NIVe5lU=;
        b=n512mf3lbvES0PmqK63tTr6JPm2YD31f/Zf3pVw7qwknXAYaBgVjJTnCU/N2Nj6eny
         SEuM2lARixPJkJk45mCBkwF9np++vVWXdxGurScFLRjTiB9WPdWn9PY2twJA/yM75kl/
         QXKZrMtEVHI5M7U05vsosppM+okM6N9BeDBCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pK9lbwZKVrYendWKNl1GTujM89c4/AaXJKQrwF4AjO8JXHEZbwf49BbOZ4tLUD0z7s
         PQU7nIM98Hi4Q0aoIdzpuBKAiythATWcZS4zQ4SeW1dvhFzbkdac6yG+3/AAOxcSaGtk
         sK4tXUxhlUWOSopDxGd/3mP4vjSTxJDfpqNiE=
Received: by 10.204.130.84 with SMTP id r20mr13066630bks.90.1281538199539; 
	Wed, 11 Aug 2010 07:49:59 -0700 (PDT)
Received: by 10.204.21.200 with HTTP; Wed, 11 Aug 2010 07:49:59 -0700 (PDT)
In-Reply-To: <20100811134640.GA10888@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153237>

On Wed, Aug 11, 2010 at 4:46 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras writes:
>> On Wed, Aug 11, 2010 at 9:55 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>> > +1 on Jakub and Ram because they showed restraint in the pertaining
>> > thread. We need moderators, not radiators ;)
>>
>> Ok, I was going to let go what happened, but you are calling me a
>> radiator. So here's what happened
> [...]
>
> Can I personally kneel down before you and *beg* you to let this go?

As I said, I had already let it go, but I wasn't going to let Michael
Gruber call me a "radiator" unfairly.

> I'm nobody- both you and Johannes have contributed far more to git.git
> than me. However, seeing you fight like this makes me sad. I don't see
> why I should be biased against either "Johannes", "Jakub", or "Felipe"
> - they're just random names to me. From what I've seen, using my best
> unbiased judgement, you're definitely over-reacting; to the extent
> that I'm almost convinced you have something against Johannes
> personally. Please, please stop- the list is no place for this. We can
> all write SO much good code and solve the world's hunger problems
> instead of squabbling like this.

I have nothing against Johannes, he has done much more for the
community than I have, but that doesn't mean I'm not going to express
my opinion when I think he is wrong.

> We're not ignoring anything. We have come to a solution together,
> voted for it, and are solving it now

IMO having more than one admin is only part o the solution, see:
https://git.wiki.kernel.org/index.php/WikiIdeas

> - Jakub and I will work with (or
> "to check" if you prefer that) Johannes. Personally, I don't think you
> should work with Johannes, atleast in the state in which you're in
> right now. Please disagree only if you feel that Jakub or I will do a
> bad job.

It's not Johannes' wiki; it's the community's. And I'm certain that I
can work just fine with Jakub as I've done it in the past.

> Can you please stop digging up old graves and let Johannes be now?

I have never seen Johannes said a word about why he unbanned Amir,
what he will do the next time this happens, his opinion on the new
admin proposal, or any of my list of suggestions. I don't see much
resolved.

> Can you trust that we understand the full magnitude of the problem and
> will do our best to prevent it from happening again?

I will trust, once I see comments on
https://git.wiki.kernel.org/index.php/WikiIdeas.

>> 7) At this point it was clear to me that Johannes had too much power
>> over the wiki, being the only admin, and that was specially worrying
>> since he had so low tolerance to accepting mistakes, therefore, on Aug
>> 10 I started a new thread asking for a new (as in extra) maintainer,
>> and one of the arguments was his misbehavior.
>>
>> Note: I consider raising a flag when there are problems to be a good thing.
>
> Yes, this is all very good. We got some suggestions, and we're working
> towards solving the problem. Are we not doing it fast enough?

Sure, but Michael made it look like a bad thing.

>> 8) The same day Johannes accepted he made a mistake, and silently
>> unblocked Amir with the message "I overreacted and am sorry". He never
>> accepted any wrongdoing on the mailing list, nor expressed any desire
>> in doing anything to avoid these issues in the future.
>
> Remind me why *you* have a problem with Johannes not writing a public
> apology note? He did whatever was needed to be done to solve the
> issue. Amir is happy, Johannes is happy, and nobody is fighting
> anymore. Why are you pressing on the issue of whether Johannes
> realizes his mistake or not? Whether or not he does, we'll be working
> with him- so he won't have a chance to "misbehave" again. I don't
> understand what you want from him.

I am merely stating what happened.

> Johannes: If Felipe still keeps insisting on a public apology, please
> oblige and get it over with.

I am not insisting on an apology, I am more interested on what will
happen the next time something like this happen. But I don't expect
anything from Johannes.

>> What we need is people that resolve the conflicts, not ignore them.
>
> How are we ignoring anything? We've called a vote. By virtue of having
> more votes than you, Jakub and I will step up if nobody has further
> objections. This matter is closed unless someone does.

I'm not saying you are ignoring anything. Read to what I replied:
>> > +1 on Jakub and Ram because they showed restraint in the pertaining
>> > thread. We need moderators, not radiators ;)

I think I've helped resolve the conflict, but Michael makes it look as
if I aggravated it. Also, according to Michael, Jakub has points
because he didn't make a single comment on the thread, thus implying
that ignoring conflicts is a good thing.

Note: in order to avoid confusion; I do think Jakub is a good
candidate, not because he didn't comment on the issue, but because of
his argumentation skills and other reasons.

Besides, this is not a competition; there's nothing wrong with having
more admins. However, notice that this voting doesn't even have a day
open.

Anyway, although I would like to help administering the wiki, just
having a second admin I think is huge progress. I just didn't like
Michael hurting my chances.

Cheers.

-- 
Felipe Contreras
