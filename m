From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Thu, 21 Aug 2008 03:30:44 +0200
Message-ID: <200808210330.44908.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com> <7v4p5fqw91.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 03:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVz1n-0008F2-0L
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 03:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYHUBav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 21:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbYHUBav
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 21:30:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:53963 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYHUBat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 21:30:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so355246nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 18:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=A9W1cPF9jhimF8C9onEjW+bQ9CjjU+uGLnIYMPlKOw0=;
        b=mGOa8Dm+W/ymdUcZ9/WpCVRuaf+gx11HqTXh5d5tKe1tNyWCTQnViiRLc6pQcz/92k
         5YZmtq+Tx7g4+0Ik7XRN6YssclsN1ZJaMMSpnDJkfxIIZ9Y42H3SFZkt4vt9i1FB/pwA
         RbsSvOIGZHWw6JtDqz8vWqlxKaf7M2Ko9RqaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CKyMuioWs+gMEJF4JMHLpbPsfr6mD1Aoy9VVt8o7OtlbXgsOk+uFLbQZkOfJYJZB7B
         ++bgYqq9nP/PkVyfLc8cmue5VzdbxnFlH8VW3MmO8zQgb//9yp22ZDKK0rZmG6TN7GWm
         iEgw43jNiA2MjTlCvOmhcKy0osya5wIVkbwn0=
Received: by 10.210.48.14 with SMTP id v14mr1019552ebv.96.1219282246757;
        Wed, 20 Aug 2008 18:30:46 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.246.2])
        by mx.google.com with ESMTPS id 3sm427177eyj.3.2008.08.20.18.30.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Aug 2008 18:30:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4p5fqw91.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93085>

On Wed, 20 Aug 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This is second revision (version) of proposed questions 
> > for Git User's Survey 2008.
> 
> Very nicely done.

Thanks

> > Getting started with GIT
> >
> >    xx. How did you hear about Git?
> >        (single choice?, in 2007 it was free-form)
> >      - Linux kernel news (LKML, LWN, KernelTrap, KernelTraffic,...),
> >        news site or magazine, blog entry, some project uses it,
> >        presentation or seminar (real life, not on-line), SCM research,
> >        IRC, mailing list, told by friend, word of mouth (off-line),
> >        other Internet, must be used at job, other off-line, other(*)
> >      + the problem is with having not very long list (not too many
> >        choices), but spanning all possibilities.
> >      + is this question interesting/important to have in survey?
> 
> I'd say this is more interesting than "what programming language do
> you speak".

Perhaps.

I've had some trouble with coming with a list of answers, because
I wanted to have as few free-form questions as possible.

> >    xx. Which Git version(s) are you using?
> >        (zero or more, multiple choice:
> >         one can use different versions on different machines)
> >      - pre 1.3, 1.3, 1.4, 1.5, 1.6, master, next
> >      + might be important when checking "what did you find hardest" etc.
> 
> This is a very good idea.  "What is hardest" grouped by "How proficient
> are you with git".

Errr... I didn't add "How proficient are you with git?" question to
Git User's Survey 2008, but I think I would.

> > Other SCMs (shortened compared with 2007 survey)
> >
> >    xx. What other SCM did or do you use?
> >      ! (zero or more: multiple choice)
> >        (matrix with the following columns: never/used it/still use)
> 
> "Plan to use"?

Hmmm...

> >      - SCCS, RCS, CVS, Subversion, Arch or clone (ArX, tla, ...),
> >        Bazaar-NG, Darcs, Mercurial, Monotone, SVK, AccuRev, Perforce,
> >        BitKeeper, ClearCase, MS Visual Source Safe, MS Visual Studio
> >        Team System, PVCS, custom, other (please specify)
> 
> With this number of "other systems", it is easier to pick if they are
> sorted alphabetically.

There is some order to this... and as there is, as far as I can see,
easy way to reorder _answers_ in a question on Survs (as opposed to
reordering questions), I think I would keep it in current (dis)order.

> > How you use Git
> >
> >    xx. Which (main) git web interface do you use for your projects?

It is currently on Survs

  xx. Which git web interface do you use for your projects/have installed?
      (Web interfaces used by git hosting sites do not count)

> >        (zero or more: multiple choice)
> >      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), Gitorious,
> >        other (please specify)
> 
> You have reworded this question on the site but it has typo "Unless of
> cours you are hosting..." (s/cours y/course y/).

Thanks, corrected.

> >    xx. How do you publish/propagate your changes?
> >        (zero or more: multiple choice)
> >      - push, pull request, format-patch + email, bundle,
> >        git-svn, foreign SCM (not via git-svn),
> >        other (see also below)
> 
> cvsexportcommit?

This I think fits in "foreign SCM"; well, git-svn is also "foreign SCM",
but as it seems most popular I kept it separate.

> >    xx. If the way you publish your changes is not mentioned above, how
> >        do you publish your changes?  Please explain.
> >        (free form, either input field or textarea)
> >    xx. How often do you use the following forms of git commands or extra
> >        git tools?
> >        (matrix form: never/rare/often)
> 
> "never, rarely, *sometimes*, often"?

My idea was to have minimal number of possible choices, to make it
easier on the responder to select appropriate answer.  'Never' is
I think obvious, 'often' was to meant that it is incorporated in one's
workflow, and 'rare' is in between.  Nevertheless I guess that having
four columns doesn't make it that much harder.

Changed.

> >         . git add -i / -p
> > 	    . git add -u
> >         . git am
> >         . git am -i
> > 	    . git apply
> 
> "apply --whitespace=fix"?

Done.

> > 	    . git cvsserver
> 
> "git daemon" and "git daemon (pushing enabled)" as separate items.

Done.

> > 	. git ... --dirstat
> 
> "diff --check"?

Hmmm... does anybody have it as part of his/her workflow?  What I mean
is to ask if there is anybody for whom the answer would be 'often'.

Currently not added, but it can be.

> >     . git pull
> 
> "pull --rebase"?

Good catch. Added.

> > 	. git pull <remote>
> > 	. git pull <URL> <ref>
> >     . git push
> 
> Separate "(empty) vs <remote> vs <URL> <refspec>" entries for "git push"?
> Also for "git fetch"?

I'm not sure if distinguish between "git pull" and "git pull <remote>",
and I'd rather limit number of possible responses. Note that
"git pull <URL> <ref>" works *differently*, as it doesn't use
remote-tracking branch.

> > 	. git stash
> 
> "git stash pop"?
> "git stash save --keep-index"?

Added the second one.  Good catch, thanks.
 
> >      + in what order should be those commands; currently they are in
> >        alphabetical order?
> 
> That is the most sensible.

I was thinking about dividing them line on git(1) manpage; this would
be useful in dealing with 50-replies limit on Survs (it would be nice
to have it explicitly mentioned somewhere), which made it a bit harder
to add new suggestions.

> >    xx. Which of the following features do you use?
> >        (zero or more: multiple choice)
> >      - git-gui or other commit tool, gitk or other history viewer, patch
> >        management interface (e.g. StGIT), bundle, eol conversion (crlf),
> >        gitattributes, submodules, separate worktree, reflog, stash,
> 
> If you single out "eol conversion", perhaps separate "whitespace
> attributes" out of generic "gitattributes"?

eol conversion is not only attributes, but also two config variables
(core.autocrlf and core.safecrlf).
 
> s/separate worktree/& (git-new-workdir)/;

Or core.worktree.

> > Documentation
> >
> >    xx. What could be improved on the Git homepage?
> >        (free form)
> >    xx. What could be improved in Git documentation?
> >        (free form)
> 
> "What can/will you do to help improve them?"?

Good idea.  I have added this, separately for each question...

...but now I'm not sure if not remove it.

> > Translating Git
> >
> >    xx. What is your preferred non-programming language?
> >   (or) What is the language you want computer communicate with you?
> >    xx. What do you need/want to have translated?
> >        (zero or more, multiple choice)
> >      - commands messages, manpages, manual & tutorial etc.,
> >        technical documentation, HOWTOs, git homepage, git wiki,
> >        git-gui/gitk, subcommands and long option names
> 
> LOL on the last one ;-)  Please keep it --- we may find amusing results.

Yeah, that was me making with the funny. "git Eintragen", anyone?

> > Getting help, staying in touch
> >
> >    xx. Have you tried to get Git help from other people?
> >     -  yes/no
> >    xx. What channel did you use to request help?
> >        (zero or more: multiple choice)
> >     -  git mailing list, git users group, IRC, blog post, 
> >        asking git guru/colleague, other
> 
> You have "IRC (#git)".  Perhaps a separate item "IRC (#github)"?

Good catch.  If we are separating git mailing list and user's group
(Google Group) it would be nice to distinguish IRC channels.

Added.

> > Open forum
> >
> >    xx. What other comments or suggestions do you have that are not
> >        covered by the questions above?
> >        (free form)
> >    xx. Should such a survey be repeated next year?
> >     -  yes/no/no opinion
> 
> "Such a", meaning "This"?

Yes.  Now it reads:

  58. Should Git User's Survey be repeated next year?

-- 
Jakub Narebski
Poland
