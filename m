From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Sun, 24 Aug 2008 23:36:34 +0200
Message-ID: <20080824213634.GA16753@leksak.fem-net>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 23:37:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXNHS-0002lJ-5Z
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 23:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbYHXVgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYHXVgn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 17:36:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:44933 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbYHXVgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 17:36:42 -0400
Received: (qmail invoked by alias); 24 Aug 2008 21:36:40 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp048) with SMTP; 24 Aug 2008 23:36:40 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+Di/EtZ7WDW1dNNUycYGvvnnYg2FTGtArh4tHOeH
	W1n61Hc+7CUEHF
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KXNGE-0006rM-QE; Sun, 24 Aug 2008 23:36:34 +0200
Content-Disposition: inline
In-Reply-To: <200808200308.26308.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93568>

Hi again,

> 8.  Which Git version(s) are you using? 
>  [ ] pre 1.3
>  [ ] 1.3.x
...
>  [ ] master
>  [ ] next

I wonder if people who do not know about master/next being git.git
branches may do "[X] next" because they think they will use the next
version available.

So could you write "master branch of official git repository" and the
same for "next"?

> 12. What other SCM did or do you use?
...
> By "custom (non-published)" it is meant here version control system
> which was not released to the public, for example something written
> for yourself, or internal company project used only in company.

Better:
 "custom (non-published)" means a version control system which has
 not been released to the public, for example, something written for
 yourself or your company only.

And I am unsure if "SCM" is better than "version control system"
in this sentence, but I do not think this is really important.

> 16. I use Git for (check all that apply):
...
> Note that above choices are neither orthogonal nor exclusive.
> You might want to check multiple answers wven for single repository.
                                           ^^^^^^^^^ "even for a"

> 17. How do you obtain Git?
...
>  [ ] pull form main repository
            ^^^^ from

> Explanation: binary package covers pre-compiled binary; source script
> is meant to cover installation in source-based distributions, like
> 'emerge' in Gentoo.

"pre-compiled binary (e.g. from rpm or deb archives)"

Right?
I think naming two popular package formats of distributors should people
help to get the point.

> 29. Which of the following features do or did you use?

I still dislike that there are a lot of choices that generate redundancy
to other questions.
On the other hand, scientific surveys always contain (hidden) redundancy
to ensure that the test person gives sane answers.

> 59. Should Git User's Survey be repeated next year?
  
>  ( ) Yes
>  ( ) No
>  ( ) no opinion
> Reset

I wonder if the "no opinion" choice is not needed because there is the
"Reset" button.


Apropos!

Is it possible to add a header text?

I'd like that there are three things being clarified at the beginning of
the survey page:

 * The survey is anonymous, but all information that the users provide will
   be publicly available on the wiki.

 * The users may skip questions as they like.

 * The user needs JavaScript to submit the survey.

I btw do not like the last fact, but since most users nowadays have
JavaScript activated, it may not be that bad.

Also, I still do not get a succesful message after submitting, but that
may be related to the channel (test), if you have configured it like
that. Have you? ;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
