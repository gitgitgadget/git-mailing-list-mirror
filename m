From: Tom Lord <lord@emf.net>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 19:14:23 -0700 (PDT)
Message-ID: <200504280214.TAA19991@emf.net>
References: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org>
Cc: hpa@zytor.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQySn-0000mD-HG
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVD1COi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVD1COi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:14:38 -0400
Received: from emf.emf.net ([205.149.0.19]:15377 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261543AbVD1COZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 22:14:25 -0400
Received: (from lord@localhost) by emf.net (K/K) id TAA19991; Wed, 27 Apr 2005 19:14:23 -0700 (PDT)
To: torvalds@osdl.org
In-reply-to: <Pine.LNX.4.58.0504271722260.18901@ppc970.osdl.org> (message from Linus Torvalds on Wed, 27 Apr 2005 17:57:07 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   > I think a lot of people understand it intellectually, but I really do 
   > think that we're lackign the kind of "institutionalized" knowledge
   > where people understand things at a much more visceral level.

I know that Arch and its progeny, as they stand, don't seduce you
but you should be made aware that the Arch community is one where
good SCM sense that you would agree with (although you might not
recognize it at once) is well on the path to being institutionalized.
It's gratifying/amazing/inspiring to see a bunch of folk catch up 
on the topic.

One thing there's still a shortage of in my world is folks steeped
in both perspectives: "unix" /and/ SCM.  Thus, I get folks who have
pretty decent SCM ideas in the abstract -- plus utterly terrible 
ideas about how to make them real.

There is a higher-level bug I think you'll eventually viscerally 
feel yourself, related to:

   > I think a lot of people understand it intellectually, but I really do 
   > think that we're lackign the kind of "institutionalized" knowledge
   > where people understand things at a much more visceral level.

Once you get to the BK or Arch level of SCM, beyond that there are
many possible paths.  Many of those are false paths -- imaginary
(unrealizable) ideals about how things like merging can work and
be good.   Some people seem to get stuck on those paths.

   > With git, this isn't the case. The _only_ reason I started git in the 
   > first place is that I knew better than pretty much anybody else what my
   > needs were, and I was forced to act on them because nothing out there 
   > really solved the problem for me.

That's debatable but neither here nor there.  Supposing that Arch
were /perfect/ for your needs today (which I don't claim) -- `git'
would still have been the better route to take (though my reasons
probably aren't the same as yours).

   > I'm not actually all that interested in SCM's.

In a certain way: same here, oddly enough.  Go figure.

   > Quite the reverse: such a person "knows" a lot of things, but I'm pretty
   > damn sure that such a person has _never_ actually worked on a system that
   > works the way the kernel development does

I've been avoiding the topic of how kernel development works ever since
i realized, that with each additional detail you reveal, i have little
but yellow and red cards to raise.   Doesn't seem productive to have that
fight when the option of simply improving the situation is open.

   > And I really _am_ sorry. I don't actually _like_ being nasty about these 
   > things.

It's healthy enough that you are, for your sanity and others.  Just 
be tolerant of others pointing that out.

   > The good news? I actually think my needs are very basic.

So it would seem.  This is partly because the process you advertise
yourself as doing is, sorry, garbage.  It's understandable why it
happens to work for now, but it's garbage nonetheless.  Not your fault --
you haven't been afforded the degrees of freedom to do better, afaict.

   > But for now, the _only_ point of git is as a kernel maintenance tool. 

Math is math.  You don't get to say what it means.

-t


