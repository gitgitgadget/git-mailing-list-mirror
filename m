From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 13 Jun 2012 20:04:32 +0200
Message-ID: <CAMP44s2yPJq=zF-pvC0O7jb-4BjXa2GL3fM=2Zh7zos-Jkduxg@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
	<7vbokwmifp.fsf@alter.siamese.dyndns.org>
	<CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
	<7vmx4baaqc.fsf@alter.siamese.dyndns.org>
	<CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com>
	<7v7gvdaogr.fsf@alter.siamese.dyndns.org>
	<CAMP44s1SOOBHRD7=u78S0dyRMdY0Q=zzkULxoz72ZzBaGC8Fyg@mail.gmail.com>
	<7v8vfri0xx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:04:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Servr-0005j3-ND
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2FMSEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 14:04:35 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40853 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2FMSEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 14:04:34 -0400
Received: by lbbgm6 with SMTP id gm6so1443482lbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xQy1A9SyQRIKym7SmoPMP3SoYlfLcX4bTs8qSibUNSI=;
        b=EOq0S40CF5ueryTgCF5SrJEGxL7aaKDKOHJ/y1TlyiZk7LVdLGNJALSCjnh072qWjg
         s0XYrnckbWo7cmgb4FXQDKjvz8XJr4+vzjHa3x+GKfxWyyxkmxrAlMUcbwz4Cz+b4TbW
         FZkkvKIa61D9VAPkBhGY2a7qJcCAo/QPgU4O0t2g0YvL1f9J2C27GO7Dbfq0TXNaJjRr
         AINAvds9WeK8lK7wdUQXhSDs/IBYlihaHTqEp5pUTHyjkvlkj3jgv7T5VK7U5eAc+z9R
         ktH9pa0GmLZz27o3HUCGAZ0uAz1mzgCLZy1/jRJKjqL3q3tgBj8nJFXSvXqx0KxN+SSp
         pbjQ==
Received: by 10.152.125.116 with SMTP id mp20mr25182148lab.19.1339610672299;
 Wed, 13 Jun 2012 11:04:32 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 13 Jun 2012 11:04:32 -0700 (PDT)
In-Reply-To: <7v8vfri0xx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199913>

On Wed, Jun 13, 2012 at 7:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Jun 11, 2012 at 4:54 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> You say I'm being irresponsible, I say you are being preoccupied b=
y a
>>>> theoretical problem that will not occur, and would not cause any
>>>> problems if it does.
>>>
>>> See how the two implementations are different
>>
>> They are not.
>>
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/completi=
on/git-completion.bash;h=3D13690eaecb4d8fafa67b79d33e804e6f8c64d742;hb=3D=
refs/heads/pu#l37
>>
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/completi=
on/git-prompt.sh;h=3D29b1ec9eb1797e0f2c3c9f7067222432150ba85f;hb=3Drefs=
/heads/pu#l54
>>
>> Where is the difference?
>
> Look at your patch that introduces the separate file af31a45
> (completion: split __git_ps1 into a separate script, 2012-05-22)
> instead. =C2=A0The extra $GIT_DIR one in git-completion.sh bba88ea
> (completion: respect $GIT_DIR, 2012-05-09) is on another topic that
> is stalled and waiting for a reroll.
>
> And your message brings things back to my exact point.
>
> Unlike the other topic, the topic fc/git-prompt-script we have been
> discussing is almost ready except for this nit. =C2=A0If we make it
> graduate to 'master' without doing anything about the other commit,
> we will have two different versions from day one.

Emphasis on *if*. Currently there's no difference on 'pu', which is
where all the current patches are.

If there's a difference, I wouldn't be doing that, you would.

Of course it's easy to fix; just rebase and copy the relevant version.
Anybody could do that, I could do that; just tell me on top of which
commit I should rebase the patches.

> And the worst part of the story is that you are not just placing the
> burden of noticing and having to worry about these things on other
> people (in this case, me), but are actively sabotaging the effort to
> make future mistakes less likely to happen by endlessly bitching and
> refusing to admit that there is a problem.

What is the problem?

Let's say you pick the patches as they are, and the newer version of
__gitdir() ends up in 1.7.11. What would happen?

Absolutely nothing.

> It seems that it is too
> difficult for you to admit that you were wrong and say "Yes there is
> a problem, and among the three approaches you suggested, this is the
> least intrusive one" or "Yes there is a problem, but I do not like
> any of the approaches you suggested, so I propose this alternative
> that is much less intrusive than any of them", and until that
> happens I do not see a point in talking with you at all.

There is no problem. There would be a problem if you cherry-pick the
patches out of 'pu' without synchronizing. This could be fixed in 1
minute; literally. Just tell me on top of which commit you want these
patches and you would have them immediately. No problem.

Then, if __gitdir() is updated later on (which is likely, but only
because Szeder is already working on it), there _would_ be a tiny,
insignificant problem.

No user would care about this "problem". Basically __gitdir() _might_
be a little slower; whoa, we'll get tons of users complaining in the
mailing list... NOT.

The "problem" you mention is hypothetical, and if you want to discuss
imaginary issues, you would have to discuss with an imaginary me that
cares, because I do not; I care about *real* issues, and dynamic
loading is a *real* issuers that is hitting *real* users right now,
and *real* distributions need workarounds. You are the one that
doesn't accept that.

There's no reason not to fix it; we can fix it _right now_, and there
would be no problems.

How about we make a bet; I bet no user would complain with something
like "'git foo --tab' completion stopped working", and the root of the
problem turns out to be a difference in __gitdir(); if somebody does
complain, you win; and my penalty would be to accept what you say
without discussion from that point on forward.

Cheers.

--=20
=46elipe Contreras
