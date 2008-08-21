From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Thu, 21 Aug 2008 23:26:20 +0200
Message-ID: <20080821212620.GA9718@leksak.fem-net>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com> <20080820211852.GA27226@leksak.fem-net> <200808211311.24600.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:27:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHgp-00050Z-6B
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbYHUV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754639AbYHUV00
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:26:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:33655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754516AbYHUV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:26:23 -0400
Received: (qmail invoked by alias); 21 Aug 2008 21:26:21 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp050) with SMTP; 21 Aug 2008 23:26:21 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+iDhZzQI2iXtYfXIQQWT4X6skVfkeOWvppuWwBkf
	ZRejHtqD3RM7Qo
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KWHfg-00037C-Qj; Thu, 21 Aug 2008 23:26:20 +0200
Content-Disposition: inline
In-Reply-To: <200808211311.24600.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93212>

Hi,

Jakub Narebski wrote:
> > So I've scrolled across your test survey on survs.com and I think it
> > should be kept on one page. Looks nice and manageable.
> 
> I also prefer single page surveys; it would be better if this survey
> was shorter
[...]
> but there are so many interesting questions...

Yes, there are, but I think the length is ok and all questions are
optional (should this be mentioned somewhere?), right?
So there should be no problem.

> (by the way, how long did you took to complete test survey?),

I filled in some stuff here and there and submitted, but I didn't
actually complete the survey.
But I'd say it's manageable within 10 minutes.

> > This question leads me to a question that could be put into the survey:
> > 
> > 	Where have you read about this survey? (optional)
> > 	[Free form]
> 
> But where to add it?  Additionally I'd rather limit free-form questions
> to absolute minimum.

If you want to add it nonetheless, then it could be question 60.

> > > What other SCM did or do you use?
> > >[..]
> > >  custom ( ) ( ) ( )
> > 
> > custom?
> 
> I mean here custom, not published (or no longer existing) SCM; something
> that would be hard to write about.

This means the difference to "other" is that it is something somebody
has written for herself (or a company product only used in that
company) and "other" is some less popular but public SCM?

I see you've changed it to "custom (non published)". There is a typo:
s/non /non-/  ;)


Btw I wonder if people that are very new to git (perhaps started using
it in 1.6.0) will not know the "SCM" abbreviation. But the possible
choices should make it clear. (And if not, "Never" to everything will be
the right choice.)

> > Uh, this is ambiguous.  Is this our git or some script on top of git?
> > In both cases, this should be clarified.
> 
> There is "my own scripts" at the bottom; I mean here using no additional
> porcelain, no interface on top of git command line.

So just pure, naked git? The real git[tm]^H^H^H^H? ;-)
Ok, if I had not asked, I wouldn't have checked this option.

> But it is here for completeness only; however if you have some good
> explanation for "core-git" option I can put it below this question.

I think it should be rephrased by "git" or "git (pure)" or "git (core)".
But "core-git" really looks like another tool to me.

> > > (*) Unless of cours you are hosting some git hosting site
> >              ^^^^^^^^                                      ^
> > 	     typo, but I'd rather do s/of cours //   and s/$/./ :-)
> 
> Thanks.  Done.

Now it is:
> (*) Unless of course you are hosting some git hosting site
            ^         ^                                     ^
I like punctuation:
  (*) Unless, of course, you are hosting some git hosting site.

*nitpick* :-)

> > > 28. Which of the following features do or did you use?
> > 
> > I think many of the possible replies have been used in several other
> > questions before, e.g. in 
> >  - 21. (gitk, git gui), 
> >  - 24. (git bundle),
> >  - 26/27. (git gui, gitk, git stash)
> >  - ...
> > 
> > But this question still seems to makes sense for:
> >  [ ] eol conversion (crlf)
> >  [ ] gitattributes
> >  [ ] reflog (ref@{23})
> >  [ ] shallow clone
> >  [ ] detaching HEAD   <- I think several people could have used that without knowing
> >  [ ] commit templates
> >  [ ] integration with IDE/editor
> >  [ ] non-default hooks

No comment here? ;-)

When replying to this question I really felt like having answered all
that before.

> > And btw:
> > > [ ] working with dirty tree      <- Eh? Is this a feature?
> 
> This is distinguishing feature.  What I mean here that you can use
> "git add" and "git commit" (not "git commit -a")

Sounds like "Taking advantage of using the index".
(Yesterday/today/tomorrow I am using SVN in university and I wished so
much that I had some git or at least git-svn[1] just because of the
*index*.)

OT Footnote [1]:
 I tried to install git (and git-svn) into $HOME/root ($HOME/root/bin is
 in PATH), but git-svn needs Perl bindings to SVN and they're pain to
 install into $HOME/root from source, because it is in the subversion
 source, and that needs a lot of Apache stuff and other things.
 So does anybody own a quick guide how to get that working without having
 to compile subversion from source (and without having root access, of
 course)?  ... (Some version of subversion is installed, but not the 
 perl modules. Just copying the .pm files did not seem to work.)

> and have some
> uncommitted changes, like for example change of version in Makefile.

Ok, this is "working with dirty tree", but I nonetheless wonder if this
is really a feature.


Another general comment: Multiple choice question have the disadvantage
that we cannot distinguish "None" and skipped questions.
So if this is an issue, I wonder if adding a "None of the above" choice
could help. But perhaps this is no issue and can be ignored.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
