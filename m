From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 16:15:12 +0530
Message-ID: <CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
 <51B6AA7F.1060505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 11 12:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmM5N-0002tY-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 12:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab3FKKpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 06:45:53 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60517 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab3FKKpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 06:45:52 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so5558718ied.14
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KCt3ztikBBCL4TbRY7Yo/M/aRr7eZVAsOzu24mHcedY=;
        b=kZ87tjCUP2kZqiyVP+Y/h0ChFriLOZm9/ViuGapV4zqFMtgSO/3Qiq3eAqFim0ydfH
         zyuk9GyrnrmRqqSc3v57OQjdXeil38RJfSIByzKi+JunixN9DjMW7vZt06fftKqJXOWf
         s3H8qzBbk5N5NrklTP8FnOnPNrAWwRjRVnZThOrTRashxsujmc6zJt/mHlxJWNmKF+7A
         a5iFU3lCndc7RCzRBZEGiGLR5pG4yN4+hKDnDMWmQpg2XKnp/UpeWBJG5QTZwHeD/tUf
         Hm0pfjO+2MP/2y39MGVoZnh4/qSnxHsZEx0gO/G/YWMQHt3QBDjhno9CLL2RldqodKDA
         A7kw==
X-Received: by 10.42.135.5 with SMTP id n5mr5376121ict.14.1370947552149; Tue,
 11 Jun 2013 03:45:52 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 11 Jun 2013 03:45:12 -0700 (PDT)
In-Reply-To: <51B6AA7F.1060505@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227427>

Michael Haggerty wrote:
> Thank you for drafting a proposed CommunityGuidelines document; I think
> such a document would be helpful.  But I don't like the overall flavor
> of your proposal; frankly, it sounds to me more like
>
> Documentation/GuidelinesForCommunityToBendOverBackwardsToLiveWithFCsProvocations

It has nothing to do with Felipe.  I've merely documented repeating
patterns in fire threads as violations, in an attempt to avoid fires.
I have not worked forward from axioms to derive "transcendentally
desirable behavior", but rather backwards from a disaster to derive
"patterns that have been shown to lead to large fires".  Why?  Because
it's easier to derive unambiguous statements using my approach; as I
will show shortly, there are various problems with your arguments.

What gives you the impression that I documented everyone else's
violations, but not Felipe's? ;)

>> 0. You do not take offense, no matter what.  If someone attacks you
>> irrationally, you do not respond.  This is a public mailing list, and
>> we are all rational people: the attacker has already humiliated
>> herself in public, and everyone can see that.
>
> This is secondary to the more important rule, "do not attack other
> people on the mailing list".  Not taking offense is at best a(n
> important) fallback position for those regrettable occasions when
> somebody else has already violated the primary guideline.

The problem with your guideline is that you now need to define some
sort of objective basis to determine whether or not someone attacks.
What is this transcendental notion of "attack"?  I say something, and
you take offense, while someone else does not.  Have I or have I not
attacked you?  One possible solution to this dilemma is to use
"majority opinion" as a basis.  This is a very dangerous road to go
down, as fringe behaviors will keep getting eliminated until we're
left with a bunch of yes-men on the list.  In other words, an
extremely suffocating atmosphere.

My guideline does not suffer from this problem.  It only requires you
to believe that you were personally offended, and act accordingly.
Whether or not you were justified in being offended is nobody's
business.

>> 2. You stop pointing fingers.  Every heated discussion requires more
>> than one participant, and a flamewar requires many participants.  If
>> you participate, you have implicitly agreed to share the blame for
>> whatever happens on the thread.  People can judge for themselves who
>> is to blame.
>
> Here your wording "every heated discussion requires more than one
> participant" seems to put more of the blame for heated discussions on
> participants 2..N and give a pass to participant number one.

I'm not going to comment on the issue of wording, since I've already
made it clear that this "patch" is not for inclusion.

It is unclear who "Participant #1" is, but I'm not giving anyone a
pass; everyone must share the blame.

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

The guidelines serve as a means of educating people on the list about
how they can avoid fuelling fires, not for literally quoting and
beating up violators.  As I have already stated in the final
paragraph, there needs to be no consensus on whether or not a rule has
been violated: everyone can judge that for themselves.

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

Let's see what your guidelines look like.

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
> [...]

Summary: be a "nice" person, said in a very gentle way.  How is it
better than the documents various internet communities have spent
years writing and perfecting? [1]

[1]: http://www.ubuntu.com/about/about-ubuntu/conduct
