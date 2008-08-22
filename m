From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Fri, 22 Aug 2008 02:06:56 +0200
Message-ID: <200808220206.59694.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808211311.24600.jnareb@gmail.com> <20080821212620.GA9718@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKBE-0003QT-NJ
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYHVAF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYHVAF6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:05:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:60398 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbYHVAF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:05:57 -0400
Received: by ey-out-2122.google.com with SMTP id 6so13470eyi.37
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CTiuAWbY7sVeihM8Dhj4z0mjt2uMUdY6FmsPlRfezDc=;
        b=Vt3QhUUkzFrAVCD2Kyxt3htWxuKJ0yGz0VShoWfdZ6YjgrrAVmHeagkEeMrExyPKpw
         nJHfqiCa7FZYLdjc0TBwIyRJCtYbyJ/KmoufpNZ5qsvnPPmf6qBWxVbz5qIs3+AzCinx
         HIhj8LBqZ5Bcpoja3b2HKMC4vpSeUFHIUMtnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MICXkf/VSY+uro9SQXkRjt61OGO5g8gKWYFl1EJlVGMs4xmTANkvwmdNfuXwcY/xF5
         XlZT9JeVaON8vx73ySIHvHW2Tot9xxHRcCa4xKof+DAUL7HxGFVTQc/165xVyQQ5NotL
         uhM0xIoAhgkpCRXMk8sB0PKE8CVLpFKVUeDuA=
Received: by 10.210.24.12 with SMTP id 12mr541202ebx.72.1219363555037;
        Thu, 21 Aug 2008 17:05:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.114])
        by mx.google.com with ESMTPS id h7sm3041689nfh.4.2008.08.21.17.05.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 17:05:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080821212620.GA9718@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93233>

Stephan Beyer wrote:
> Jakub Narebski wrote:

> > > This question leads me to a question that could be put into the survey:
> > > 
> > > 	Where have you read about this survey? (optional)
> > > 	[Free form]
> > 
> > But where to add it?  Additionally I'd rather limit free-form questions
> > to absolute minimum.
> 
> If you want to add it nonetheless, then it could be question 60.

I'll added it.  It would be useful if there would be survey in
the following years.

> > > > What other SCM did or do you use?
> > > >[..]
> > > >  custom ( ) ( ) ( )
> > > 
> > > custom?
> > 
> > I mean here custom, not published (or no longer existing) SCM; something
> > that would be hard to write about.
> 
> This means the difference to "other" is that it is something somebody
> has written for herself (or a company product only used in that
> company) and "other" is some less popular but public SCM?

Yes.

> I see you've changed it to "custom (non published)". There is a typo:
> s/non /non-/  ;)

Thanks, corrected and added explanation below the question.
 
[...]
> > But it is here for completeness only; however if you have some good
> > explanation for "core-git" option I can put it below this question.
> 
> I think it should be rephrased by "git" or "git (pure)" or "git (core)".
> But "core-git" really looks like another tool to me.

Done.

> > > > (*) Unless of cours you are hosting some git hosting site
> > >              ^^^^^^^^                                      ^
> > > 	     typo, but I'd rather do s/of cours //   and s/$/./ :-)
> > 
> > Thanks.  Done.
> 
> Now it is:
> > (*) Unless of course you are hosting some git hosting site
>             ^         ^                                     ^
> I like punctuation:
>   (*) Unless, of course, you are hosting some git hosting site.
> 
> *nitpick* :-)

Done.

> > > > 28. Which of the following features do or did you use?
> > > 
> > > I think many of the possible replies have been used in several other
> > > questions before, e.g. in 
> > >  - 21. (gitk, git gui), 
> > >  - 24. (git bundle),
> > >  - 26/27. (git gui, gitk, git stash)
> > >  - ...
> > > 
> > > But this question still seems to makes sense for:
> > >  [ ] eol conversion (crlf)
> > >  [ ] gitattributes
> > >  [ ] reflog (ref@{23})
> > >  [ ] shallow clone
> > >  [ ] detaching HEAD   <- I think several people could have used that without knowing
> > >  [ ] commit templates
> > >  [ ] integration with IDE/editor
> > >  [ ] non-default hooks
> 
> No comment here? ;-)
> 
> When replying to this question I really felt like having answered all
> that before.

They _are_ different questions; yes, some answers repeat themselves
because I tried each question to be self-contained, if possible, so
it should be easy to skip some question and still have full value
in the rest of questions.

> > > And btw:
> > > > [ ] working with dirty tree      <- Eh? Is this a feature?
> > 
> > This is distinguishing feature.  What I mean here that you can use
> > "git add" and "git commit" (not "git commit -a")
> 
> Sounds like "Taking advantage of using the index".
> (Yesterday/today/tomorrow I am using SVN in university and I wished so
> much that I had some git or at least git-svn[1] just because of the
> *index*.)

Hmmm... reading the above I have thought about adding "incremental
committing" to the list of features; I mean here the workflow of
"<edit>; git add; git diff/git diff --cached; <edit>; git add; commit"

But I think I'll just add "the index" to question

  30. Which features do you find unique and/or useful ones,
      compared to other systems (other SCMs)?

and leave the rest for free-form question 31. following it: "If you use
some important Git features not mentioned above, what are those?".

> Another general comment: Multiple choice question have the disadvantage
> that we cannot distinguish "None" and skipped questions.
> So if this is an issue, I wonder if adding a "None of the above" choice
> could help. But perhaps this is no issue and can be ignored.

Hmmmm....

-- 
Jakub Narebski
Poland
