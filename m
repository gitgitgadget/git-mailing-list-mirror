From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [RFC] Git User's Survey 2007
Date: Mon, 30 Jul 2007 09:44:05 +0200
Message-ID: <4d8e3fd30707300044l79133442of45b37a8192f7bca@mail.gmail.com>
References: <200707250358.58637.jnareb@gmail.com>
	 <200707271320.06313.jnareb@gmail.com>
	 <4d8e3fd30707290950lce19ef4g103cbb7ad1abbe23@mail.gmail.com>
	 <200707300221.23511.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:44:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFPvJ-0002DP-G4
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbXG3HoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754362AbXG3HoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:44:09 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:27660 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbXG3HoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:44:07 -0400
Received: by py-out-1112.google.com with SMTP id d32so2619316pye
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 00:44:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P/VGfHMLiSAEo3fzlNLXD46W3YnE0od2Pa8Im4sDbQ5o8amBsYiKN/io4e7Fn7n5YCMy1xJvHkrY1iJp+mZfjzZ9LE+pVk1hCMA9/nmp4gcNz5/ujXGKKnk3MH4yC1VtM7F/oc1NgE48tMiotAIi6WNPqXSsI4IxMnPGg7TATT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r3zo7OTXlKqmcwJLYdYrQP82HbIHP1iaaqtzbMFiWiJBigcDJ966EsusSxOgGuqrAH/qVKMxYOWVt0kzJJ/Duj5Gl/qEoemM+3Mk8kB3kxqAHxWReKy/0h1z9Shd95pX1sQNvI95HAwBuUIDH1Dic2PonxdSWPuTkaXS9M4vHOw=
Received: by 10.142.12.14 with SMTP id 14mr286887wfl.1185781445934;
        Mon, 30 Jul 2007 00:44:05 -0700 (PDT)
Received: by 10.143.163.10 with HTTP; Mon, 30 Jul 2007 00:44:05 -0700 (PDT)
In-Reply-To: <200707300221.23511.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54199>

On 7/30/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Paolo Ciarrocchi wrote:
> > On 7/27/07, Jakub Narebski <jnareb@gmail.com> wrote:
>
> >> First there is a question about the form of survey. Should we use web
> >> based survey, as the survey before (http://www.survey.net.nz), sending
> >> emails with link to this survey, or perhaps do email based survey,
> >> with email Reply-To: address put for this survey alone?
> >
> > I vote for the survey.net.nz approach. I think that from a user
> > prospective that's the right thing to do, we can have "multiple choice
> > questions" and avoid some of the more common mistakes.
>
> I think it also better (especially that I started devising questions
> with multiple-choice and single-choice answers in mind...).
>
> >> Third, where to send survey to? I was thinking about git mailing list,
> >> LKML, and mailing list for git projects found on GitProjects page on
> >> GIT wiki. Do you want to add some address? Or should info about GIT
> >> User's Survey 2007 be sent also to one of on-line magazines like
> >> LinuxToday, or asked to put on some blog?
> >
> > I think that one of the mistakes I did when I sent out the first
> > survey was to not contact any magazines and blog.
>
> Any proposals? Besides LWN, NewsForge, Slashdot?

www.osnews.com and I can contact a few Italian portals.

> >> ----
> >> About you
> >>
> >>     1. What country are you in?
> >
> > I know that lot of people will disagree with me but from a pure
> > statistical prospective I'd like to add a couple of questions about
> > gender and age.
> >
> > I understand very well that these questions will not be useful for
> > making git any better but it will be interesting to have a better
> > picture abut the git customer base.
>
> I'm not sure it would add any important informatant information;
> although "age" (years, or age bracket?) could be useful.
>
> >> How you use GIT
>
> >>     8. Which porcelains do you use?
> >>        (zero or more: multiple choice)
> >>     -  core-git, cogito, StGIT, pg, guilt, other
>           IsiSetup
>
> > git-gui ?
> >
> >>     9. Which git GUI do you use
> >>        (zero or more: multiple choice)
> >>     -  gitk, git-gui, qgit, gitview, giggle, other
>           tig, instaweb, (h)gct, qct, KGit
>
> I consider git-gui an UI (like qgit or tig), not a porcelain. To be
> a porcelains tool need to add some SCM functionality not present in
> git-core.
>
> > How about adding a question about whether the user migrated from a
> > different SCM? If so, from which SCM and why?
>
> I have added, suggested [somewhat] by Andy Parkins, the following
> set of questions:
>
> ----
> Other SCMs
>
>     1. What other SCM did you use?
>     2. What other SCM do you use currently?
>     3. What other SCM do you use as a main SCM for your project
>        instead of git, if any? Why?
>     *  example: Mercurial, better MS Windows support
>     5. What would you require from git to enable you to change,
>        if you use other SCM for your project?
>     4. Do your git repository interact with other SCM? Or what SCM
>        did you import from? What tool did/do you use?
>     *  examples: CVS, import: fromcvs, interaction: git-cvsserver;
>                  Subversion, git-svn

Fine with me. Thanks for you work Jakub.

Just a general comment, let's try to avoid as much as possible
multiple questions in a single question. It tends to confuse people
when they are answering to the survey.

Ciao,
-- 
Paolo
