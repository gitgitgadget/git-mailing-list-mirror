From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Wed, 14 May 2014 16:26:28 -0500
Message-ID: <5373df8424a35_592416ad2f8c7@nysa.notmuch>
References: <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <20140514202646.GE2715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:37:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgrp-00059U-QD
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753627AbaENVha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:37:30 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:62223 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbaENVh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:37:27 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so205157oag.29
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=XktLYJ7z/iWWxlC/QUprBDah50sQfk+KPwwZ4Kv8hJo=;
        b=Y3pkl3hDaMv7w4J2gJP1ELrELs3h8I9YVTtj84PQjJofOA5M5ZXetFGTz/kmoSWcyr
         v6DUOgzEsJ8tW/gJEO6FfDB+ExYc7gGljQ0/zqd4dXPsG8RcNH0/XgY7GRPcXSEh8fFf
         DBIDzaG/9TT+ur5HwjeBVUfTRT/esW50z+hTcdUBoWBQ4JP/W89SyVG+ey0Jn+1TCmq9
         MK7CjD5TAjLazPovKo88UXcsqtRcBTyVjBAcDQrSjdEB+rFvbCqbLWcfZR4v7fm6eYPM
         OZq3Vu0Zt4oL4H04JnUDylAVese2SJq70wlcjU1pMrA97Jj7Wy7TSU+T2rBCb0vog1fM
         uuvA==
X-Received: by 10.182.117.195 with SMTP id kg3mr5980371obb.17.1400103446766;
        Wed, 14 May 2014 14:37:26 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dg2sm5354055obb.17.2014.05.14.14.37.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 14:37:25 -0700 (PDT)
In-Reply-To: <20140514202646.GE2715@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248999>

Jeff King wrote:
> On Wed, May 14, 2014 at 02:35:08PM -0500, Felipe Contreras wrote:
> 
> > Prior to his decision there were no complaints about my "manners" since
> > I returned. It was his *TECHNICAL* decision that triggered this.
> 
> There have been several complaints about your behavior since you
> returned[1,2,3,4],

> [1] http://article.gmane.org/gmane.comp.version-control.git/247108

This is not a complaint, you are merely saying you are not interested in
discussing with me without mentioning any bad behavior at that time.

And this is not related to remote-hg/bzr.

> [2] http://article.gmane.org/gmane.comp.version-control.git/247121

This is a complaint without pointing out what are the specific instances
of bad behavior, present or past.

> [4] http://article.gmane.org/gmane.comp.version-control.git/247168

This is not a complaint about bad behavior. Unless you think making a
bet is bad behavior.

And this is unrelated to remote-hg/bzr.

> [3] http://article.gmane.org/gmane.comp.version-control.git/248000

This is a complaint about a factual statement, a prediction about the
future that turned out to be true. Unflattering factual predictions can
hardly be considered "bad behavior"

And this is unrelated to remote-hg/bzr.

> I have not paid all that close attention to this remote-hg contrib
> argument. Maybe you are 100% right and Junio is wrong and lying and
> cannot back up his decision, but somehow needs to cover it up through
> rhetoric. But that does not at all match my past experiences with
> Junio's behavior.

The fact that something hasn't happened in the past doesn't mean it's
not happening right now.

I am still waiting for Junio's answer to *one* question.

If your expectation about Junio is correct, it should be easy for him to
say "Felipe is wrong, here's where I explained in full my rationale
of the technical issues that triggered my decision to demote the remote
helpers, and as you can see, the importance of the decision is well
matched by the detail of my explanation". But he is not doing that, is
he?

It would be easy for him to do that, why isn't he doing so? You are
giving him a free pass.

> I can understand that it hurts to be called a troll. I really do believe
> you are trying your best to improve git. But I hope you also understand
> that in terms of the time and emotional drains on other participants,
> from our perspective interacting with you is quite similar to
> interacting with a troll.

Yes, I can understand that, and I would understand if Junio said I was
acting *like* a troll. But he unequivocally said I was a troll, even
when I asked for clarification.

Maybe that's acceptable to you. That's where I draw the line.

> Your continued arguing on this topic does not seem like it is going
> anywhere,

I'm not arguing on this topic any more. I gave up on Junio trying to
answer my *one* question. The remote helpers will not graduate because
Junio said so, and he didn't explain his reasoning. That's an
unfortunate fact.

All I'm trying now is to move foward, by:

 1) Add a warning about the new location of remote-helpers

 (Junio chose to argue instead)

 2) Remove the remote-helpers and replace them with warning stubs

 ("Somehow" the patches didn't reach the mailing list)

 3) Make sure everything is in place for users and packagers to use the
    new location (it can't never be as good as graduating to the core)
 
 (The fact that Junio is preventing 1) and 2) doesn't help)

Additionally:

 4) Correct any misconceptions in the lingering threads

> and I believe is wasting time and hurting the atmosphere of
> the list. Please stop.

Tell other people to stop. I am merely replying to misconstrued
conceptions. If other people stop, so would my replies.

I am not going to let the record about such an important decision be
tainted by these misconceptions.

> [5] Even though you were previously asked to leave, I believe people
>     on the list gave interacting with you a fair shot in the past month
>     or two. And we somehow still ended up at the same place.  That's
>     just my perception, of course. I'd invite anybody watching to form
>     their own opinions.

And that's entirely Junio's fault for making a haste decision, and
giving no rationale about it.

Given all the time I've spent on these tools, I wasn't willing to let my
work be threated like crap by Junio. I deserved an explanation, and if
he wasn't going to give one, I'd rather leave the project trying to get
one (even if that meant behaving in a way other people considered
"bad").

And BTW, I still think git-archimport and git-quiltimport should be
demoted from the core, and I think the contrib area should be cleaned
up, many of the tools removed, and others maintained out-of-tree. Do not
think I sent those patches to "troll".

Cheers.

P.S. While we disagree on many topics, I do appreciate the fact that you
are never condescending and try to be honest, and when it becomes
difficult to do that, you explain so and leave the discussing. Never
letting your ego get in the way of a clear record. Which is more than I
can say about Junio after this incident.

-- 
Felipe Contreras
