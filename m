From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Fri, 14 Dec 2012 21:14:36 -0600
Message-ID: <CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
	<CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
	<F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 04:18:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjiGb-0003L1-OK
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 04:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743Ab2LODOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 22:14:38 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46601 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab2LODOh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2012 22:14:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4250639oag.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 19:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=D4+aJrjBej/p5eYgIiRSRtTRF7twS6gvgNQeDfdMZng=;
        b=lSQO09l+5LUwkr3jSH3DhZUv4OObxp+I4PFPA3KETjn9/mgNhoCydpEil3Y7qcRp7i
         8DFEFOmvF4NNIpYBL6STXA/8+9msejgzdG+VRcK+CtcQkb5NdPLT5xYc2R9/PqCLIrab
         xhhHeK48SybttK55b+3RrO/LFC7gF6KJJ/B0P31C2ngc1q94Q3+Cd++TwXDsNepk9vQ+
         ShpQa6erDqkKQIsDYyuUNL0yrWi+fGpBTVsRMZ7yzdtVCC1CMQPYKV3gj51RMQv0wy3f
         54Wkgxfx8xal/bJ8FzPuWhXY//ZfUblFmCCMPlCpKT1PDTKLH/zOJXWCLWNKg2ex2I5C
         MQEQ==
Received: by 10.182.17.72 with SMTP id m8mr6251410obd.55.1355541276778; Fri,
 14 Dec 2012 19:14:36 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Fri, 14 Dec 2012 19:14:36 -0800 (PST)
In-Reply-To: <F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211517>

On Fri, Dec 14, 2012 at 7:11 AM, Max Horn <postbox@quendi.de> wrote:

> please stop referring to "facts" and "obvious". You pretend to be a being of pure reason and that everything you say is logical, drawn from facts. But you forget or perhaps do not know that logic by itself proofs nothing, it all depends on the axioms you impose. And yours are quite different from what others consider as such, and apparently also inconsistent.

When I say something is a fact, I do mean it. It's not my opinion,
it's not what I think, it's a fact. The Earth revolves around the Sun,
Junio is the maintainer, Junio can merge whatever he wants, those are
facts.

If you think the Earth revolving around the Sun is not a fact, that's
your choice, but if you want to convince others that this is not a
fact, you need to show *why*.

> So, instead of trying to twist things around so that broken things in your code are not broken after all, why not simply re-roll your patch with the "obvious" fixes applies?

First of all, it depends on your definition of "broken". To me
something broken is something that does not *work*. The code works,
the tests have some cruft in it, but it *works*, it's not broken.

And I said multiple times now that I WILL FIX IT. I'm not going to
repeat it again, and quite frankly, I don't think I'm going to reply
to this thread any more. What makes you think that you owe my free
time? I do with my free time whatever I want. I will fix it, when I
feel like fixing it. This code will not go into 1.8.1, so there's no
point hurrying the fix, I have other things to do.

> As you write yourself, time is not pressing at all -- so I don't see why your patch should be merged now, and fixed later, contrary to how other people's patches are treated? Why not fix them first, and then apply? We do have time, after all! And nobody is expecting you to do that while you are on vacation, either. Nor that you do it instantly.

Time is not pressing because Junio decided not to merge, and he
decided not to merge, because of this "issue". This hurts users, and
benefits no one.

> Just say: "OK, I see there is a problem with the patches; even though I consider it unimportant, I will play by the rules everybody here has to follow, and re-roll the patch series. But this is of low priority for me, so I cannot say right now when it will happen".

That is what I said. What part of "I didn't say it was irrelevant, it
should be fixed" didn't you understand? And no, this is not a "rule",
you assume it *must* be re-rolled, it doesn't.

> Everybody would be happy then. Except perhaps the hypothetical users, who would have to wait a bit longer -- but oh, not really, because they can just use remote-bzr from your repo, yay :-). I really like that about it, it lives in contrib, so one can use it w/o it being merged into git.git.

It's not because of me that users would have to wait, it was Junio's
decision, there was literally nothing I could do, before, or now, for
this code to be merged for 1.8.1. And yes, people can use my repo *if*
they know about it, most people just follow the mainline, and many
don't even read the news.

> Instead, you make claims that make you look like a foolish and arrogant ass, all the while insulting Junio and me implicitly. Why do you do that??? It delays acceptance of your nice work. As you write, this hurts the users. So why do it?

Show me *exactly* where I insulted anybody, and show me where I made a
false claim. And no, this discussion doesn't delay the acceptance, the
acceptance was already delayed before this discussion, there was
nothing I could do, neither in the past or present.

> Since you keep complaining that nobody ever really can point to anything wrong your said, I'll do you the favor by deconstructing one of the claims you made:

Please.

> On 13.12.2012, at 20:06, Felipe Contreras wrote:
>
>> On Thu, Dec 13, 2012 at 6:04 AM, Max Horn <postbox@quendi.de> wrote:
>>>
>>> On 13.12.2012, at 11:08, Felipe Contreras wrote:
>>>
>>>> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>>>> New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>>>>> for 'next'.
>>>>>>
>>>>>> What minor fixes?
>>>>>
>>>>> Lookng at the above (fixup), $gmane/210744 comes to mind
>>>>
>>>> That doesn't matter. The code and the tests would work just fine.
>>>
>>>
>>> It doesn't matter? I find that statement hard to align with what the maintainer of git, and thus the person who decides whether your patch series gets merged or not, wrote just above? In fact, it seems to me that what Junio said matters a great deal...
>>
>> So you think Junio knows more about remote-bzr than I do?
>
>
> This is a classical straw man argument.

It was not a straw man argument, in fact, it's not an argument at all,
it's a *question*.

>  No, I do not think that. But I do think that Junio knows enough to review your code, and I do think that the point he raised is valid. You disagree with the importance of his point

No, you don't understand. Junio pointed out correctly that the code
didn't "work" in the sense that it didn't do anything, but in fact,
not doing anything was good, because we don't need that code. That
second part Junio did not see, that is a fact. So, my claim that it
didn't matter was based on information Junio did not have, but you
implied that because Junio said it mattered, it did.

Please select to whom does this matter:
a) users of remote-bzr
b) git developers that run make -C t
c) git developers that run make -C contrib/remote-helpers
d) maintainers of remote-bzr
e) Junio

Presumably, the answer is e), so is that really important? I don't
think so, you and Junio, of course, can disagree, but disagreeing is
not insulting. And the fact that very very few people will be affected
negatively if the code is merged is a *fact*, not my opinion.

>> I repeat; it
>> doesn't affect the tests, it doesn't affect the code, it doesn't cause
>> any problem. remote-bzr could be merged today, in fact, it could have
>> been merged a month ago.
>>
>> You don't trust me? Here, look:
>>
> [..]
>
>> All this code is a no-op, because, as Junio pointed out, cmd is null.
>> How is that a problem? It's not.
>
> It is a problem. Because either the code inside the if is important, and then this is a bug. Or it is not important -- then it should not be there in the first place.

Everything is a problem. You can say that the fact that bazaar exists
at all is a problem, and ideally bazaar should disappear, and the
whole remote-bzr gone. The there are problems, and there are
*problems*.

I ask you again, who will be affected negatively by this "problem"?

> Either way, the patch series should be re-rolled.

No. A re-roll is one of the many solutions. Another solution is to
merge first, fix with a separate patch later.

In fact, it was Junio himself that proposed to do later fixes of
remote-bzr on top of what was already merged (v2). Shock horror! This
"broken" code was already merged in 'next', and guess what, nothing
exploded, because, as I said; it's not broken, it's not a big
"problem".

http://article.gmane.org/gmane.comp.version-control.git/210677

> Of course in a whatever time frame suits you. If you are not willing to do that, this is sad, but of course also your right!

Again, as I said multiple times now, I will fix it, eventually.

> [...]
>
>>> This is a very strange attitude...
>>>
>>> In another email, you complained about nobody reviewing your patches respectively nobody voicing any constructive criticism. Yet Junio did just that, and again in $gmane/210745 -- and you replied to neither, and acted on neither (not even by refuting the points brought up), and now summarily dismiss them as irrelevant. I find that quite disturbing :-(.
>>
>> I didn't say it was irrelevant, it should be fixed,
>
> Actually, you wrote:
>
>  "That doesn't matter."
>
> So I paraphrased. In any case, I am glad to hear you finally agree that it should be fixed (which you did *not* say in your initial reply). So the problem we have seems to be that you do not understand how patches typically handled in git.git.

Please, spare me the condescension, I think I have enough patches
landed in git.git.

> Well, based on my observation: If reviews point out things in a patch series that are not optimal or even broken, it is expected that the submitter fixes this locally and resubmits a new version of the series. In some cases, it is possible to make exceptions, e.g. trivial typo fixes can be applied on the fly. But otherwise, you re-roll, you do not get your stuff merged just based on the promise that you'll submit a series of fixes later. Esp. if the fixes are relatively easy.

No code is ever perfect. And stop saying "this should be re-rolled",
Junio himself already had this code merged and argued that further
fixes should be *on top*, of what was already there.

I sent v3 on November 11, he made the mistake of picking v2, if he
hadn't done that, remote-bzr would be on track for 1.8.1, the same if
I hadn't asked to pick v3 instead and we continued with v2. The no-op
"problem", might or might not have been spotted, and if it did, Junio
himself might have written and pushed a fix *on top* of what was
already there (not "re-roll"). Even if the problem wasn't spotted,
users of 1.8.1 wouldn't be affected negatively in any way, and I
explained before, *nobody* would have been affected negatively.
Eventually, I might have spotted the issue myself, and sent a patch
*on top*, which might be picked for 1.8.2, 1.8.1.1, or maybe even
1.8.1.

Insisting that this is re-rolled, and that *I* do the fix, is
insisting on a synthetic problem that just wouldn't be there if Junio
hadn't made the mistake of picking v2, or if v2 wasn't reverted.

>> but Junio said
>> "With minor fixes, this may be ready for 'next'." which is no true
>> IMO, it's ready *now*, it was ready one month ago. For 'next', this
>> problem doesn't matter.
>>
>> The feedback is appreciated, but delaying the merging of this code for
>> no reason makes little sense to me.
>
> And here goes the insult. You say Junio has no reason to delay the merging.

That is my opinion. Are you saying that having opinions is insulting?
Or are you saying that voicing my opinion is insulting? Note that I'm
being careful here, and I'm not stating it as a fact, because it's
not. I'm not saying that Junio did something that doesn't make sense,
I said *to me*, it doesn't make much sense. It follows then, that it
might make sense to others, it's a matter of opinion, and having
different opinions is not insulting.

> When you really mean that you don't agree with his reasons.

That is exactly what I said.

> So you attack his professionalism and integrity by alluding that he has some ulterior motives to delay the patch.

I never said anything like that. This, actually, is a prime example of
what a straw man argument looks like.

> E.g. that he is hates you, is just mean, does it out of stubbornness, etc.

Don't put words on my mouth.

>> Junio, of course, can do whatever he wants. The removal of this no-op code can wait, or it can be done
>> on top of v3, there's no need for re-roll, and Junio already
>> complained about the v3 re-roll.
>>
>> And I didn't act because I was on vacations, git development is not my
>> only priority.
>
> Of course. Nobody is complaining that you take too long to reply. We are just unhappy in the way you reply when you do reply :-(.

I know. But I'm only stating facts. The code could be merged to 'next'
today, that is a fact. And in fact, it was already merged in 'next'.

>> And even if I had time, I don't see why I should
>> prioritize this fix, it's not important, the code is ready.
>
> Another straw man: Nobody asked you to prioritize the fix, take your time.

> It was you who asked that the series should be applied without any further fixes.

I didn't ask for anything, I said the series *could* be applied
without any further fixes, the fixes can come next.

And I repeat, this "broken" code was already applied! Hadn't I asked
Junio to pick v3 of the series instead, the fix would have to come as
a separate patch *on top* of what was already merged.

You keep assuming that there's only one way to apply the fix, as a
re-roll, stop doing that.

>>>>> but there may be others.  It is the responsibility of a contributor to keep
>>>>> track of review comments others give to his or her patches and
>>>>> reroll them, so I do not recall every minor details, sorry.
>>>>
>>>> There is nothing that prevents remote-bzr from being merged.
>>>
>>> Well, I think that is up to Junio to decide in the end, though :-). He wrote
>>
>> No. He can decide if the code gets merged, but he is not the voice of
>> truth. Nothing prevents him from merging the code, except himself.
>> There is no known issue with the code, that is a true fact.
>
> Here are a multitude of fallacies hidden, partially explainable by a differing set of axioms, and/or shear arrogance.
>
> Let us re-reread what was said: Initially, you claimed that "There is nothing that prevents remote-bzr from being merged".
>
> Now, it wasn't said in the above, but let me make it explicit: This statement is "obviously"[1] wrong. There are parts of the patch series Junio thinks are not up to par, and he made it quite clear that he will not merge it until these things are resolved.

That is his *choice*, but nothing is preventing him from merging.

You are not looking at the claim objectively. If I'm on top of a
skyscraper and say "there's nothing that prevents me from jumping
down, except myself" that might be true, even if I have no intentions
of jumping, because, in fact, the reasons for not jumping are mine.
However, the top of the skyscraper might be surrounded by a glass
wall, in which case, there is something that would prevent me from
jumping, other than myself.

Of course, completely objectively, the claim that Junio can merge it,
doesn't say much, merely that he has commit access, that github is not
down, and so on. It just says that *physically* Junio is not
constrained from merging. But if you take a step further, it means
that among the guidelines of what constitutes reasons for merging, or
not merging something, this series does in fact fulfill those reasons.

But ultimately the proof that there was nothing preventing Junio from
merging to 'next' is that *HE ALREADY DID IT*:

http://git.kernel.org/?p=git/git.git;a=commitdiff;h=ad38af72b334150e6cf1978721c37077ae3c6d7f

See? Now tell me that my claim is wrong, and he could in fact not do
it, if the already did.

> Hence, ignoring all else, there obviously *is* something that prevents remote-bzr from being merged. That is a "fact". You even admit so yourself, also contradicting yourself:
>
>   "Nothing prevents him from merging the code, except himself."
>
>
> So how is it possible that you can claim that there is nothing that prevents the merge? Ignoring the self-contradicting aspects of what you wrote, the basis for your differing conclusion seems to be that you change the terms of discussion and are using a different set of axioms. In particular, you apparently redefine
>   "things that prevent remote-bzr from being merged"
> as
>   "things that in Felipe's view prevent remote-bzr from being merged".

No. No. No. No.

It's not me that makes something mergeable or not. It's not me who
determines if there's something that prevents a person from jumping
from a skyscraper. Either there are walls, or there are not.

And I don't think you know what an axiom means.

Either way, even if my claim was wrong (it isn't, because Junio
already did it in the past), it wouldn't be a fallacy.

> Of course one can arbitrarily bend the rules by this definition. For example, we could redefine "nothing prevents the merge" as
>  "no technical reasons prevent the merge", and the latter is indeed quite true; your patch series applies perfectly fine, git can do that. Of course the same holds for a patch which removes git.c from the repository, so I don't think this definition is particularly useful...

You go to great extents to say that my claim is wrong, and then you
say: except if... Sorry, that's not logic works.

> This is something what a lot of people would consider a strong insult towards the professionalism and integrity of Junio. There are more examples of this in previous communications between you and other people in the list.

So you do think disagreeing is insulting. Good to know. I disagree.

> You finally add "There is no known issue with the code, that is a true fact.". Within your axiom set, this is certainly true. It certainly is not true in mine or Junio's... Yet you very strongly emphasis with your statement that your set of axioms is the correct one to use here, although I would guess that most people would disagree.

Now it's obvious that you don't know what axiom means:

"An axiom is a premise or starting point of reasoning. As classically
conceived, an axiom is a premise so evident as to be accepted as true
without controversy."

If there's controversy, it's not an axiom, because if you change
axioms, you can argue *anything*.

No, it is a fact even with commonly shared axioms. Tell me, what
outstanding issues with this series are going to affect negatively
anybody? That is the only way you can dispute my claim, by providing
actual, real, objective issues.

> This is especially arrogant in view of the another straw man argument you are employing: By writing "[Junio] he is not the voice of truth.", you implicate that I or anybody were of this opinion.

I did not imply that. If it's not clear, objective issues either
exist, or they don't. If there are no objective issues, Junio's
thoughts can't make them appear.

> But I am not, and what I wrote cannot logically be construed as saying so. At least not within what most people would consider as axiom set; of course if your axiom set includes "Max believes Junio is the voice of truth", your claim because truth, albeit a tautological one. But let me make clear that any such axioms, or set of axioms leading to that implicating, are inconsistent: In my view, of course Junio is fallible and makes mistakes, and can be wrong etc. -- like any human being. Including most definitely me and you.

Again with the shady definition of axioms. The truth is the truth, it
doesn't matter what you, Junio, or I, say; the truth remains the same.
Axioms are things that can't possibly be wrong, not what anybody
considers is the truth.

And even if you were correct in all that, you haven't provided a
single possible fallacy. Here is a list:
http://en.wikipedia.org/wiki/List_of_fallacies

I haven't seen you arguing that I committed any of those.

> This is a horrible way of working within a team effort :-(. I find this a great pity, because I believe you are doing some really nice work, I esp. like your remote-hg which works much better for me than the others I tried so far.

I'm not going to voice my opinion on this, because to you, apparently
voicing my opinion is insulting.

> [1]  As a mathematician, I was taught to avoid the word "obvious" in any written form of proof, as it makes you sound arrogant, and it also discourages the reader from thinking critical about a statement, which is considered extremely bad. But since you like it so much, I am using here on purpose.

We are not writing mathematical proofs, and even if we were, avoiding
the word "obvious" would be a guideline, right? Your paper wouldn't be
rejected if you did use it.


I'm going to say it one last time; merging this patch series either
creates issues for the users, or not. There is a reality out there,
independent of what you, Junio, or me think or say. And the fact is,
that if this patch series is going to create issues for the users,
*nobody* has pointed out why, so, since there's no evidence for it,
the only rational thing to do is believe that there will be no issues
for the users.

There is no known issue with the code, that is a fact. This code could
be easily merged today, and in fact, it was merged by Junio already
(but then reverted). There are no positive outcomes from the delay,
only negative ones. I will address the minute issue about the extra
cruft, eventually.

I'm not going to reply to this thread any more, because when you have
to explain in a discussion what 'axiom' means, you know the points of
view could hardly be more distant, and it would take a lifetime to
converge. Same for what a fallacy is, what an argument is, and what
straw man means.

Cheers.

-- 
Felipe Contreras
