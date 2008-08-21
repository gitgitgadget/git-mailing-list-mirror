From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Thu, 21 Aug 2008 13:11:23 +0200
Message-ID: <200808211311.24600.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com> <20080820211852.GA27226@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 13:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW84b-0001bJ-J9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 13:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbYHULKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 07:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbYHULKV
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 07:10:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:6236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbYHULKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 07:10:19 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1002657ugf.37
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PKnk5/VBF0bvRxaZKCjbqIFWjsFNJ1EFE1cJRfRb/ZE=;
        b=w/LTize7eHM9p4cxeXLAlezik4RSXSOnpoGby0AoWBNipRkumyxxffAyF6L1VT84Ij
         76pmTnj/pe4BWwdJsJK3EBxej9Bf4yGXg9msdnUD1MyEBVkP/fmYo4CwyusbuhntyIvS
         b3Rc1zQjx5gT7aPAnNCB8zQRexvShkO2O/OBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v8gc5lr2R/8z7vS87w/lO+AsOd/wcAdyCoIfqs1fY8Xh2IB7BQ9qxDviHvHud936un
         0PrsUIAby1TbrK2i8hqGoXp1QRUY5hcNCFWHNYNWUvZiK6zBZ7uCz2qfd4RSPDw3xk6V
         +em0fRzTlzFqo9D7t7bp6rrKOalT8vGHuY44c=
Received: by 10.67.116.19 with SMTP id t19mr1258190ugm.56.1219317017137;
        Thu, 21 Aug 2008 04:10:17 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.114])
        by mx.google.com with ESMTPS id 23sm1232721ugf.56.2008.08.21.04.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 04:10:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080820211852.GA27226@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93135>

On Wed, 20 Aug 2008, Stephan Beyer wrote:
> Jakub Narebski wrote:
> 
> > By the way, should the survey be divided in pages, or simply use
> > headers to divide survey into sections?
> 
> Divided pages have a psychological impact, they don't look much and you
> can say "Almost there!" on each page.
> 
> But headers and one-page surveys have a big advantage for users that pay
> for Internet access per time unit: they can go offline, answer the
> questions, and go online again to submit the survey.
> 
> So I've scrolled across your test survey on survs.com and I think it
> should be kept on one page. Looks nice and manageable.

I also prefer single page surveys; it would be better if this survey
was shorter (by the way, how long did you took to complete test survey?),
but there are so many interesting questions...
 
> > Third, where to send survey to / where to publish information about the 
> > survey?
> 
> This question leads me to a question that could be put into the survey:
> 
> 	Where have you read about this survey? (optional)
> 	[Free form]

But where to add it?  Additionally I'd rather limit free-form questions
to absolute minimum.

This is the question I was lacking, so I'll think about adding it to
the survey.

> So, some comments on the questions now:
> 
> > About you
> > 
> >    xx. What country are you in?
> 
> "What country do you live in?" perhaps?

This is better phrasing.  Changed.
 
> > Getting started with GIT
> > 
> >    xx. How did you hear about Git?
> 
> There is a typo on survs.com (hear_d_).
> Should this by the way be multiple choice?
> I have heard about Git several times before I tried it.
 
Good idea, I think, and doesn't lead to more work when analysing.
And it would perhaps make it easier to choose appropriate answer.

Changed. 

> I will only quote from survs.com now:
> 
> > told by friend (word of mouth)
>                  ^^^^^^^^^^^^^^^ ? :) I think this should be removed

O.K.

> > What other SCM did or do you use?
> >[..]
> >  custom ( ) ( ) ( )
> 
> custom?

I mean here custom, not published (or no longer existing) SCM; something
that would be hard to write about.

I agree that it is not the best phrasing.

> > 20. Which porcelains / interfaces / implementations do you use?
> >  [ ] core-git
> 
> Uh, this is ambiguous.  Is this our git or some script on top of git?
> In both cases, this should be clarified.

There is "my own scripts" at the bottom; I mean here using no additional
porcelain, no interface on top of git command line.

But it is here for completeness only; however if you have some good
explanation for "core-git" option I can put it below this question.

> > 22. Which git web interface do you use for your projects/have installed?
> > (Web interfaces used by git hosting sites do not count[*])
> [...]
> > (*) Unless of cours you are hosting some git hosting site
>              ^^^^^^^^                                      ^
> 	     typo, but I'd rather do s/of cours //   and s/$/./ :-)

Thanks.  Done.

> > 26. How often do you use the following forms of git commands
> > or extra git tools?
> >
> >		Never | Rare | Often
>                                      | Not yet, but sounds cool   ;-)
> 
> No no :-)
> 
> But I wonder if we could split the "Never" case into several cases with
> reasons like:
>  - Do not know.
>  - Not yet needed.
>  - Other (did not understand; tried but did not work; ...)
> 
> But this will perhaps bloat the question even more, so we should keep
> "Never", though I think the reasons could be interesting.
> Could some "Comments" field for question 26 help?

Now it is 'never/rarely/sometimes/often'.  I think there are enough
free form questions that one can put his/her own comments about git
commands in this survey...

> Some other comment: I dislike that there is *one* "Reset" button for
> such matrix questions. But I guess you cannot change that?

Yes, this is canned web survey site.  I can only send feedback,
but I guess so can you (unless this requires subscription/invite...).

> > 28. Which of the following features do or did you use?
> 
> I think many of the possible replies have been used in several other
> questions before, e.g. in 
>  - 21. (gitk, git gui), 
>  - 24. (git bundle),
>  - 26/27. (git gui, gitk, git stash)
>  - ...
> 
> But this question still seems to makes sense for:
>  [ ] eol conversion (crlf)
>  [ ] gitattributes
>  [ ] reflog (ref@{23})
>  [ ] shallow clone
>  [ ] detaching HEAD   <- I think several people could have used that without knowing
>  [ ] commit templates
>  [ ] integration with IDE/editor
>  [ ] non-default hooks
> 
> And btw:
> > [ ] working with dirty tree      <- Eh? Is this a feature?

This is distinguishing feature.  What I mean here that you can use
"git add" and "git commit" (not "git commit -a") and have some
uncommitted changes, like for example change of version in Makefile.

> Big thanks for your efforts,
>   Stephan

You are welcome.

-- 
Jakub Narebski
Poland
