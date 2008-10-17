From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Thu, 16 Oct 2008 18:57:04 -0700
Message-ID: <7vljwoq8zz.fsf@gitster.siamese.dyndns.org>
References: <20081015172543.GX10544@machine.or.cz>
 <bab6a2ab0810150315l273d4ef3k95cda8f43a4745ca@mail.gmail.com>
 <bab6a2ab0810150318pb616a6dj867efa36623ac12e@mail.gmail.com>
 <20C9ABEC-52E5-405E-A755-C58A6359D7A9@wincent.com>
 <d411cc4a0810150921j198fda93j60dae04c4cc9b9d1@mail.gmail.com>
 <20081016184239.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Scott Chacon <schacon@gmail.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 03:58:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqebo-00079u-5r
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 03:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbYJQB5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 21:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbYJQB5T
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 21:57:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYJQB5T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 21:57:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4EE26F5F3;
	Thu, 16 Oct 2008 21:57:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 19F286F5F2; Thu, 16 Oct 2008 21:57:05 -0400 (EDT)
In-Reply-To: <20081016184239.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 16 Oct 2008 18:42:39 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EAF2D254-9BEE-11DD-925E-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98440>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Petr Baudis <pasky@suse.cz>:
>> On Wed, Oct 15, 2008 at 09:21:50AM -0700, Scott Chacon wrote:
>>> I do wish that there wasn't this 'us vs them' mentality on this list,
>>> though. I think GitHub is doing some good things for the community,
>>> and I also think that 'the community' is bigger than this list.
>>
>> I think this last sentence is where we differ - for (most of?) us the
>> Git developers, 'the community' pretty much _is_ this list (with the IRC
>> channel as its casual extension).
>
> Curiously, whenever somebody says "git-scm.com is the official git
> homepage", you are not involved in the discussion.  Could you share your
> position on this issue with the rest of the "community"?

The thing is, I do not think whatever I say would be any more official
than what Pasky says when it comes to "the git homepage", even though I
might be a fairly central person in the developer community.

I first have to say that in this era of the Internet and distributed
development, "official" status means much less than what everybody seems
to think [*1*].  It is perfectly fine for people to decide which site they
would want to go for git related information for themselves, and direct
their friends to.

In other words, I do not care either way very much, personally.

The "official" maintainer of git was Shawn for a short while last year in
October, after he claimed to act as one during my absense, and everybody
accepted it not because I named him but he had the necessary respect and
trust from the developers.  I asked him to be the maintainer again this
year during early October, and again it worked quite well.  I imagine it
would have worked if it were not Shawn but any other people among the few
people I trust on this list.  I don't have to name them but you know who
you are, and more importantly, people in the developer community know who
you are.  That is what respect and trust are about.

It wouldn't have worked well if the self-claimed interim maintainer were
just some random Joe, and it wouldn't have worked well either, even if I
endorsed him, if the random Joe did not have enough respect and trust from
the community.

Pasky's site came first from very early in git's life, people contributed
contents to it over time, and he kept the site up-to-date, and through all
that effort, Pasky earned (at least my) respect and trust that the site
will keep serving the git users and developers well as it has been in the
past.  For this reason, to me personally, the "official homepage" has
always been git.or.cz, and will continue to be so, until Pasky says he
considers Scott and his pages earned enough respect and trust _from him_,
and wants to redirect git.or.cz traffic to git-scm.com [*2*].

Regarding "the community", I think what Pasky said in the quoted message
is right in that the word, used in a message on _this_ mailing list,
refers to "the developer community", whose definition I 100% agree with
what he said.

I sense that people around GitHub come from a different world --- it may
also be a legitimate "git community" (perhaps a "users and evangelists
community", which is not a bad thing in itself), but certainly it is
different from the git developer community as I know it.

I think "us vs them" mentality is unavoidable to a certain degree.  More
importantly, I should also point out that it goes both ways.  I think the
"fork once and part forever" attitude of git-scm.com from the very
beginning stems from the very same "us vs them" mentality.  The developer
community ("them" for Scott, "us" for me and Pasky) has been (and will
always be) text oriented, because we tend to try shooting for the greatest
common denominator.  The end-user community in this Web 2.0 era ("us" for
Scott, "them" for me and Pasky) on the other hand, would want to be
entertained by singing and dancing contents.  The two communities serve
different purposes and consist of different audiences.

Very early on, Scott made his intention clear that git-scm.com once copies
from git.or.cz, forks and is very unlikely to merge back because of this
vast difference of the target audience.  That's "us vs them" mentality
right there, but I do not think this division was particularly a bad thing
at all.  It led to what git-scm.com site has in addition to what it copied
from git.or.cz; git-scm.com has made git more approachable by the kinds of
end users who were repelled by the spartan git.or.cz's contents and
organization.  It was a good thing.

So let's help both sites improve support for git users _and_ developers,
and watch git-scm.com continue earning our respect and trust.  It is my
understanding that Pasky is hoping that it can turn into a good site that
supports not just end users but developers well, so that he can start
redirecting repo.or.cz traffic to it, and I am hoping the same.

And let's do so without flaming anybody ;-).


[Footnote]

*1* While I was researching to write this message, I was kind of surprised
to find that the Wikipedia article on git went through a few rounds of
flipping between pointing at git.or.cz and git-scm.com.  I didn't study
the page history deeply enough to see who did what change, but I doubt any
of the people who are doing real work on either site are stupid enough to
have got involved in the self promotion nonsense.  I trust Pasky that much
(and much more), and also I came to trust Scott at least that much, after
seeing git-scm.com adding useful contents over the past few months
(admittedly the rate of the improvement may have slowed down somewhat
recently, compared to its initial bulk import from git.or.cz).

*2* There is no point in duplicated effort when the goals of two sites are
compatible and when there is such trust between two parties.  I do not yet
know if the goals are compatible, though.  We'll see.
