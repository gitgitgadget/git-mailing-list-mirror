From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 01:28:27 -0500
Message-ID: <CAMP44s2Kwx+B27QUP2jO-Gc3oaGXiHx1ZLC1JqKiOCAhTWnTZA@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 11 08:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmI4U-0007Gc-37
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 08:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab3FKG23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 02:28:29 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:62023 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3FKG22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 02:28:28 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so6564830lab.28
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9yAdzA4152zgC9bXM6YB4VCotDbKNtd7p366KRG9ZXE=;
        b=KMszN6jyEjT0PvoE9S5YDbXOXPcQQFzL5Iv3AqwYRNbVbXjGTbUYkrkMvjVn4NOSK5
         AR11ivtD8OLyODBnnGZcaY7+OsR9re0m/jTKmO3XG91Lj1OXpP/6aDOSs04ivGSgQSCz
         1zAPbRdZBJ3WxvEhegaHGy9qPmHe/cI4NPdePS6s+kLZI0LBMFoGY6AoH4y5oIR12kUz
         YcOd4PZVOpjxVrPZCssK2t6R+FvVW3P+K8VwD89XfzdVvH+kENzTkT1RKOMgwkccQ0uT
         lLxF44TakqBa+LgOWfwnSnwkdBEIqiUrjeF1aah69jA1bt+TiJRPQj68ePA8YNWxBRNz
         m6FQ==
X-Received: by 10.112.156.5 with SMTP id wa5mr8003554lbb.63.1370932107111;
 Mon, 10 Jun 2013 23:28:27 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 23:28:27 -0700 (PDT)
In-Reply-To: <51B6AA7F.1060505@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227419>

On Mon, Jun 10, 2013 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/10/2013 03:28 PM, Ramkumar Ramachandra wrote:
>> I've tried to write down a bare minimum, without restating the obvious.
>
> Thank you for drafting a proposed CommunityGuidelines document; I think
> such a document would be helpful.  But I don't like the overall flavor
> of your proposal; frankly, it sounds to me more like
>
> Documentation/GuidelinesForCommunityToBendOverBackwardsToLiveWithFCsProvocations
>
> and I don't think that is healthy.

The LKML would disagree with you, as this draft is rather similar to
what they do. Have you ever heard the phrase "don't feed the troll"?
Well, it's every similar.

This also happens in any civilized modern society. Maybe you don't
agree with the Tea Party, or some other political group, but you
deport them? Do you squash their protests? No. You let them say what
they need to say, and you ignore them.

It's best for you, and it's best for the community. Ignore them and move on.

>> 0. You do not take offense, no matter what.  If someone attacks you
>> irrationally, you do not respond.  This is a public mailing list, and
>> we are all rational people: the attacker has already humiliated
>> herself in public, and everyone can see that.
>
> This is secondary to the more important rule, "do not attack other
> people on the mailing list".  Not taking offense is at best a(n
> important) fallback position for those regrettable occasions when
> somebody else has any other already violated the primary guideline.

Yes but you can't control what other people do, only what you do.
Presumably you think you are not going to violate any of the other
rules, so it's all the more important that you do follow this one,
because that's the one *you* are possibly going to need to remember.

But by you I really me "we", because we all think we are not going to
violate the other rules. We all think we don't commit logical
fallacies, we all think our comments are right, productive, rational,
and sensible.

Of course that's not the case, what you think is a perfectly
reasonable comment, somebody else might consider offensive. In fact,
somebody is bound to find something offensive, so when that someone
happens to be you, take a deep breath, and don't.

>> 1. You do not take sides or vote.  Do not post emails under the
>> pretext of agreement: repeating what has already been said does not
>> strengthen the argument.  Post only if you have something unique to
>> add to the discussion.
>>
>> 2. You stop pointing fingers.  Every heated discussion requires more
>> than one participant, and a flamewar requires many participants.  If
>> you participate, you have implicitly agreed to share the blame for
>> whatever happens on the thread.  People can judge for themselves who
>> is to blame.
>
> Here your wording "every heated discussion requires more than one
> participant" seems to put more of the blame for heated discussions on
> participants 2..N and give a pass to participant number one.

Which might actually be the case. If a drunk punches you in the face,
and you fight back. Who do you think the police is going to find
guilty of brawling?

>> 3. Thou shalt not commit logical fallacies.  The ones that are most
>> common on this list: strawman, ad hominem, burden of proof, false
>> cause, the texas sharpshooter, and appeal to authority.
>
> I think putting a rule like this in CommunityGuidelines puts too much
> weight on it.  In my recollection, pointing out other people's supposed
> logical fallacies is far more often used on this list as a nitpicking
> diversionary tactic that usually leads a conversation *further* away
> from the real issues.  I think it would be a mistake to encourage such
> formal and stylized argument on the ML.

If you are not going to argue on the basis of logic and reason, what
are you going to argue on the basis of?

Being logical and reasonable is not finicky, it's a necessity. At
least if you want to stay close to the real world.

>> 4. Lead by example.  If you do not like how someone presents
>> themselves on the list, you counter it by presenting yourself nicely
>> on the list.  Others will follow your example, making that person's
>> behavior the minority.  It is far more powerful than explicitly
>> stating what is "acceptable" behavior and what is not.
>
> Leading by example is a great approach, and has the effect that you
> describe on the majority of people.  But I also think it would be
> helpful for the community to agree on a few very minimum standards of
> behavior that we insist on, and to call people out (preferably in a
> private email) if they fall short of these standards.
>
>> 5. We are a community of programmers, and we are here to collaborate
>> on code.  The argument that leads to higher efficiency and better code
>> has an automatic advantage over the argument that doesn't.
>>
>> If someone breaks one of these rules, there's a very simple way to
>> communicate this to them: you don't respond to their email.
>> Optionally, respond to their email off-list calmly explaining what
>> went wrong.
>
> I would prefer a community standards document that looks more like this:
>
> * Treat other community members with courteousness and respect.

I disagree. Respect should be earned.

Moreover, tolerance is what is needed, respect is not. You should be
tolerant, even to the people who don't respect you.

> * Conduct disagreements on a technical, not a personal, level.  It is
> unacceptable to attack another community member personally, even by
> insinuation.

I believe this is obvious and hardly worth mentioning. But on the
other hand, once could say I have been a victim of personal attacks,
not on a technical level. Perhaps it is worth mentioning.

> * Keep in mind that email is a medium prone to misunderstandings, and
> that many mailing list participants do not speak English as their first
> language.  Interpret other people's emails charitably.  If you are not
> sure that you understand, ask for clarification.  Assume good intentions
> on the part of others, and do not attribute technical disagreements to
> ulterior motives.  Choose your words carefully to help other people
> avoid misinterpreting them, and avoid hyperbole.

I agree, but I think my wording of assuming good faith is better.

> * Strive to keep the mailing list a forum for effective collaboration.
> Only post if you have something worthwhile to add to the discussion.  Be
> concise and do not repeat what has already been said.  Code reviews,
> contributions of patches, and concrete data such as bug reports are far
> preferable to philosophizing, vague suggestions, and whining.  Avoid
> bikeshedding and do not participate in flame wars.  Avoid revisiting
> settled debates unless the facts have changed.

Mostly agree, but the flamewar part needs to be emphasized and in its own point.

> * Accept reviewers' comments gratefully and take them very seriously.
> Show that you appreciate the help by giving the reviewer the benefit of
> the doubt.  If, after careful consideration, you find that you cannot
> agree with a reviewer's suggestion, explain your reasoning carefully
> without taking or giving offense, and seek compromise.

Agreed. But I would say 'consider compromise'; often a compromise is
in the project's best interest, but not always.

But it's missing the guideline for the reviewer.

* Accept comments on your reviews gracefully. If the original patch
submitter doesn't agree with your review, don't take offense. Don't
assume the submitter has to automatically modify the patches according
to your comments, or even necessarily seek a compromise. The submitter
is entitled to his opinion, and so are you. Also, remember that each
person has their own priorities in life, and it might take time before
the submitter has time to implement the changes, if ever. The changes
you request might be beyond the time the submitter is willing to
spend, and it's OK for him to decide to drop the patches as a result.
You can help by picking the patches yourself in those situations.

> * It is not OK to use these guidelines as a stick with which to beat
> supposed violators.  However, if you genuinely feel that another
> community member is routinely behaving in ways that are detrimental to
> the community, it might help to calmly express your concerns to that
> person, preferably in a private email, and naming concrete and specific
> incidents rather than broad generalizations.

Very good. It's good to remember these are guidelines, not by-laws.
One should not focus on the transgressions of others, for which
there's no defined punishment, but rather; on what one can do oneself.

-- 
Felipe Contreras
