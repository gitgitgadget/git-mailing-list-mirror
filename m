From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Thu, 12 Nov 2009 22:04:23 +0200
Message-ID: <94a0d4530911121204o59f94bbcv84bd11b8c79b6009@mail.gmail.com>
References: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
	 <7vy6n065os.fsf@alter.siamese.dyndns.org>
	 <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
	 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
	 <20091025111438.GA11252@progeny.tock>
	 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
	 <4AFBF18E.7070906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 21:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8fuA-0007Nz-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbZKLUET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbZKLUET
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:04:19 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:62429 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbZKLUES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 15:04:18 -0500
Received: by iwn8 with SMTP id 8so2056303iwn.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=GkU2esS7mOHLU1MYaTuUplvVKvBbU2kgXbMBQKaXAd8=;
        b=slcZqMCddrUVYlobDgAwxcbnjYIQpvp7Ke2b4C7JK+L0yOZaotTdgtoart/fLrXfB3
         ucIM5ZAFbVjw2rm4ROnIC4BnZB8lGQey2crqGrVkansXMROhS3QKq57iV10qctWkMfza
         fkbLJ0PSzlgIpKLhJ0UB9867nC9Es13DynT0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MxP2BXZDfq1n+0ab0E4tqCp8PjamL80nsRvXsLXu6sXXW7vzq/cIGj69h7vrGU0h02
         PmB3hqdlz11TLMz/oWehUrZKq4a6/hZxiZqUR7xP8CJc7JKzhDITmqqjs5P/0MlZ4Sy+
         //j4MbKQgOcrcFu0xpWXOzfWIQtdYJ+mHjYX0=
Received: by 10.231.121.164 with SMTP id h36mr1280758ibr.9.1258056263748; Thu, 
	12 Nov 2009 12:04:23 -0800 (PST)
In-Reply-To: <4AFBF18E.7070906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132795>

On Thu, Nov 12, 2009 at 1:29 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Feel free to bring this issue on for a change in Git 1.7.0. It would be
> good to research any possible incompatibilities this would imply (other
> than the looks of the output),

Isn't that what we are doing just now?

> The process can be frustrating at times. Many patches go through many
> rounds. I've had occasions where I got frustrated and gave up, as well
> as those where I learned a lot and the actual result was much better
> than it would have been without thorough discussions. It's this process
> which tries to ensure that the project is moving forward most of the
> time, rather than sporadically back and forth; moving forward maybe a
> bit slower, but still at an impressive overall rate.

Except in this case there is no path forward. If there is, I would
like to hear it.

> Regarding this specific patch series: I took part in the initial
> discussion, and got frustrated by the original poster's seemingly
> unwillingness to accept advice, so I left. I'm not drawing any general
> conclusions, and please don't take this as an ad hominem argument.
> Sometimes it's simply a matter of mismatching participants.

What are you talking about? All your comments were addressed in
subsequent patches, as the commit message of the patch in this thread
points out.

Moreover, in the paragraph before you argued that these thorough
discussions are actually a good thing. Or are patch committers not
allowed to discuss?

> I didn't read that out of the survey. On the other hand, the last survey
> pretty impressively showed where it had been publicized most
> prominently. One should keep that in mind when interpreting the results.

So? What are the surveys supposed to be for, if not to use the results?

> If you care to go back to that discussion you see that there is good
> reason for having both --cached and --index. They are different. "git
> help cli" explains this nicely.

"good" is a very subjective term; I don't think "they are different"
is a good reason. By that logic --only-index and
--index-and-working-dir serve the same purpose, just like --gogo and
--dance.

But there's no point in discussing this until people accept there is a
problem, and there seems to be unwillingness to accept that very few
people use the stage properly.

> "To stage" has been introduced to describe what "git add" does to people
> who hard wire "add" to the meaning it has in other VCSes. In fact, this
> would be unnecessary if the concept of Git as a *content* tracker could
> be transmitted more successfully. Git cares about content only, so what
> could "git add" possibly mean?

usage: git add [options] [--] <filepattern>...

I don't see any mention of this "blob" mythical creature. In the vast
majority of the minds of git users, 'git add' adds files to the
repository, just like any other VCS.

Proof of that is that only 23% of the people use "git add -i / -p" and
15% "git add -u / -A" often.

> "git stage" is a failed follow up ui experiment.

I agree with that. But assuming because one UI experiment failed, all
other "stage" proposals are doomed.

> In this regard, I think the problem is that there are really two kinds
> of people in terms of learning style:
>
> - Some prefer recipes, similarities with previously known recipes. "How
> do I...?" And then try do understand "How does (G)it...?" from that.
>
> - Some want to understand concepts first: "How does (G)it...?" And then
> figure out how to use (G)it to do what they want.
>
> I'd guess most developers and a large fraction of the "technical crowd"
> belong in the second camp.

I actually belong to the two groups. When I started to use git I
learned it through recipes and grew fond of it, but didn't really know
what was really happening even thought I used it for years. It wasn't
until a colleague recommended me to read "Git from the bottom up",
then I really started to understand git and realized I didn't know
squat. Sure, I heard concepts such as "feature branches", "rebase" and
"stage interactive", and I had in my to-do list to learn them, but
that was it.

I'm pretty sure the vast majority of users are in the darkness just as I was.

> I still think we should both

What?

> - try and teach concepts early, emphasize that Git is different
> (content, index, branch - that's it)

Well, that's the first failure right there. If your objective is to
confuse people, then sure, call it "index", otherwise choose a name
that corresponds with it's purpose: stage.

> - make Git behave in "expected ways", making it easy for the (willing)
> beginner) without compromising its usefulness as a power tool.

Sure, but if the UI was more friendly people would learn to use the
advanced features through it's use. Currently there are no ropes to do
that. You have to read a book or something.

-- 
Felipe Contreras
