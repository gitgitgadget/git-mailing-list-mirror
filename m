From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Git weekly news: 2008-49
Date: Fri, 5 Dec 2008 23:49:52 +0200
Message-ID: <94a0d4530812051349tff33aaan76e29402215dcae2@mail.gmail.com>
References: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com>
	 <m3d4g6ipah.fsf@localhost.localdomain>
	 <7v3ah2z6jh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:51:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8ia4-0001sW-2U
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 22:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbYLEVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 16:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbYLEVt6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 16:49:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:39389 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042AbYLEVtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 16:49:55 -0500
Received: by ey-out-2122.google.com with SMTP id 6so92621eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=i1NT2ssLCayWZdAAyeiVJDZfPQTRW2oARW5pvHjH6Xg=;
        b=HJEVAknxF8rGdR9XkwHYehJ/kkFVQU7P6TKbdWR1nX8IBbyh1hAf2XR/V6jU60s5lO
         UTKXGGJ7XpvTH5TZnKr2sVQ1frJeqdVb6uAYd1Iqmqj+M/p2ji4DSDNt37oFWJ7IFb9g
         SNMRLUYceZc2RmIsjEc1z/LU7kfwDzoYburOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CF3Ps21ar2BLqmH71eZVyC+l+XN9/67xBBg5GylVZQX0pTtcGr5sjhTrwD5fmtQvpW
         p3pIL2sk7QhdQrcq3kZ0SZQhsLJWrC+DpzibIsId3RNWfMrZAF6Y7cubyur6thhPc/Aw
         SDf8ui3s81aC0tsi8Xnw3WzcXgz/c57ylRab4=
Received: by 10.210.46.14 with SMTP id t14mr433679ebt.39.1228513793458;
        Fri, 05 Dec 2008 13:49:53 -0800 (PST)
Received: by 10.210.50.8 with HTTP; Fri, 5 Dec 2008 13:49:52 -0800 (PST)
In-Reply-To: <7v3ah2z6jh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102414>

On Fri, Dec 5, 2008 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> [1] It would be nice if somebody resurrected GitTraffic, offshot of
>> now defunct KernelTraffic, or at least helped to write Git articles
>> for KernelTrap (which currently is in a bit of hiatus).
>
> While I 100% agree with you that "Git Traffic" was a terrific attempt, I
> do not think expecting or asking Felipe to duplicate it is realistic.
>
> I searched for Felipe's proposal on the list archive, and its title was
> "Planet Git".  That shows why the focus could be different.
>
> "Git Traffic" was great because it attempted to directly address the issue
> that the traffic on the mailing list was simply too high (and still is) to
> follow for casual observers.  It did so by giving a comprehensive summary
> of what important topics were discussed recently on the list from the
> viewpoint of one dedicated person who followed many, perhaps not all,
> important threads carefully, who very well knew what was going on, and who
> had a good taste on what is important and what is not.
>
> But "Planet Git" is quite different from "Git Traffic".  For the latter,
> somebody needs to do a real work, continuously.  But more importantly, I
> think they would serve different purposes.  A "Planet" could be valuable
> to have with or without "Traffic".
>
> I think what was presented as "Official Git blog", however, is also
> different from what people expect a "Planet" to be.  I do not think it is
> unreasonable to expect or ask Felipe to improve on making his service more
> "Planet" like.
>
> A "Planet", as I understand it, is an aggregator of (selected) people's
> blogs, and even though I am not currently involved in any Planet nor
> follow any Planet myself, I can imagine that it could be a valuable
> resource to have a "Planet Git" that subscribes to and aggregates what
> influential figures write on git in their blogs.

Yes, a planet is an aggregation of blogs. I've been involved in some
planets and they are not exactly great.

One disadvantage of planets is usually there's no control of the topic
of the posts. For example in planet GNOME there's some people that
mostly blog only about GNOME, but other people blog about everything,
including what they did in the morning, ate at lunch, and discussed at
the water cooler. Some people have their blogs properly categorized
and the right feeds go to the right planets, but they are the
minority.

Planets are great if you want people to "get intimate" with the
community, probably a small one. Not for git IMHO.

There's a single "planet" I know that doesn't follow the norm;
beagleboard news[1]. There one guy basically uses Google Reader to
share whatever he thinks is somehow interesting for the beagleboard
community. The advantage is that the feed is much more focused than a
planet, but still there's a lot of bias in the links, which sometimes
have nothing to do with the beagleboard.

> Felipe's page currently is a random collection of links, and other than
> their titles, there is no indication for readers to judge which link is
> worth clicking and reading.  It does not even mention who wrote each
> piece, let alone editorial comments (e.g. "This is worth reading") like
> you added.  When you click one of them in order to read it, you leave the
> "list of links".  That is not how navigation (the click and thought flow
> for the readers) usually works in a "Planet".

Lets remember that this is the first try, and there's many more links
that what would fit in any given week, but I just didn't want to leave
them out.

Maybe for the next weeks I'll do a bit of explanation about each link, lets see.

> If this wants to be a "Planet Git", I do not think there is any need for
> Felipe to ask "who wants accounts?"  It would go the other way.  Instead,
> Felipe, as the coordinator of the "Planet", would find people who writes
> noteworthy things on git on their own blogs, would ask for permission to
> slurp and aggregate what they wrote, and produce the page by aggregating
> their writings.  That would make a good "Planet Git".
>
> Expecting people to apply for an account and write for that page would not
> fly.  As Felipe said himself, many people already have their own blog.
>
> Having said all that, I am not sure "Planet" would work for the git
> community as well as it would for others.  I do not know of many core-ish
> people write on git on their blogs (and I know at least two core-ish
> people who flatly say "blogging is a waste of time").

I actually propose two things:

a) planet git

This would be a collection of blogs, probably not developers, which
might consider blogging to be a wast of time, but git enthusiasts. I
don't expect the list of dedicated bloggers to be that big, hence my
second proposal:

b) git blog

A blog can be shared by a bunch of people, much line online news
sites. Junio could write a post once for each release, for example,
without having to setup his own blog, maybe somebody else can
copy-paste "What's cooking in git.git", or any kind of semi-official
announcement.

And I'm sure there will be one or two developers who wouldn't mind
sharing their frustrations and/or visions.

These two are not exclusive, of course.

For a) I need a server (there's a few already offered), setup the
planet software, and people to send me their RSS feeds, which
hopefully are categorized for git-specific posts. I don't have much
faith on this, nor interest.

For b) I just need interested people to send me their emails.

[1] http://beagleboard.org/news

-- 
Felipe Contreras
