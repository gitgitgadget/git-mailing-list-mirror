From: "Tom Werner" <pubsub@rubyisawesome.com>
Subject: Re: git-scm.com
Date: Sun, 27 Jul 2008 20:11:01 -0700
Message-ID: <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>
	 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>
	 <20080727113707.GC32184@machine.or.cz>
	 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>
	 <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>
	 <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 05:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNJ9b-0003sH-FF
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 05:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYG1DLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 23:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYG1DLG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 23:11:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:16678 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbYG1DLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 23:11:03 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3586613wri.5
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 20:11:02 -0700 (PDT)
Received: by 10.90.63.15 with SMTP id l15mr6807641aga.79.1217214661542;
        Sun, 27 Jul 2008 20:11:01 -0700 (PDT)
Received: by 10.90.75.3 with HTTP; Sun, 27 Jul 2008 20:11:01 -0700 (PDT)
In-Reply-To: <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90398>

On Sun, Jul 27, 2008 at 4:19 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> And the choice of language has nothing to do with helping people
> around. If they care about getting recommendations from list regulars,
> anyway. Maintaining a great user-facing website might be their way of
> engaging and interacting with us.

As cofounder of GitHub I'd like to jump in and say a few words. I'm a
huge fan of git. HUGE. But that should already be obvious. We started
GitHub because we saw that git was a tremendously useful tool but was
missing a way to easily and flexibly share your public and private
code with other developers. That simple idea grew into what we now
like to call "Social Code Hosting."

I find it a bit confusing that some here seem to have a strong dislike
for GitHub. It's true that we haven't been active on the developer
list or in the #git channel on freenode, but we are constantly in
#github and have answered a *great* many questions from developers
that are new to git. At the same time, like Martin finally guesses, we
believe that our contribution to the git community is GitHub itself.
We provide free git hosting for over 16,000 open source repositories!
As mentioned earlier in the thread, the Ruby-Git binding that Scott
and I wrote has been open source from the beginning. While we did not
announce it here, we have publicized it in the Ruby circle (where,
presumably, people would most likely find it useful) and in fact there
are currently 28 forks and 138 watchers of the project. We've also
released albino, facebox, and github-services via GitHub. You can see
all the open source stuff we use at GitHub here:
http://github.com/github.


Perhaps it is the commercial aspect of GitHub that offends. The only
reason that GitHub is as featured and polished as it is, is because we
can make money from it. We hope to soon be working on GitHub full
time. There is no way this could have been possible if we did not
offer paid private repositories. A part of being a commercial
operation is making the main product closed source. One might argue
that we could still have GitHub as a service while making the code
open source, but the truth of the matter is that this is not in the
best interest of our future plans for the company.

I don't like the thought of being at odds with the git developer
community at all, and let me be the first to apologize if we've
offended anyone. It certainly is not our intention. Our goal with
GitHub is to help make git even better by offering a service that
helps people streamline their git workflows and discover projects that
may interest them. We're trying to give back to the community how we
know best: by offering kickass git hosting and associated
collaboration tools.

Having had to implement a git-daemon replacement that fit our needs, I
have some ideas on how to improve git-daemon and fetch-pack with
regards to error messages and logging. I'll be sure to bring those up
on this list. One thing you should probably understand about us is
that we're all about getting things done. Which is one reason we
weren't bothering everyone in here when we started GitHub. We like to
design from first principles, see how good we can do, and then get
feedback from the users. If you're a GitHub user (or have a reason why
you are *not* a GitHub user), we'd love to hear your feedback on ways
we can improve!

Tom Preston-Werner
github.com/mojombo
