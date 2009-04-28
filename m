From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Eric Sink's blog - notes on git, dscms and a "whole product" approach
Date: Tue, 28 Apr 2009 11:16:07 -0700 (PDT)
Message-ID: <m3ocugod96.fsf@localhost.localdomain>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 20:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyrqt-00043L-W5
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 20:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760603AbZD1SQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbZD1SQL
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 14:16:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:46819 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZD1SQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 14:16:09 -0400
Received: by fg-out-1718.google.com with SMTP id 16so224790fgg.17
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vuS72uRgcauhSGBX3HtV0ZmvKbHQEv+TEcjXhQIpM/Q=;
        b=SCYqQWU7bRkfN37DCJHuLycmOTvBiiNVLh4URqBh/bck7gQHzTiWfZi21HyvwGo5XI
         zsPZNcI5xEMrMw+i6DtI7ErE9beZkAmCN3yTS9sg5QiL/yZ7BQWCSMKxOjI9o4LbK+ez
         SGdxYrBOskrUPmIkAVJEHNZWuzw19Dd3r4O+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pZIyWaUgZwoFeefZockHBCA1CiEi4TVR8RYSZaYOOwAmioY45SMMbRPvCXVLaPRVf7
         x1xynIi6oI5aafoVXElvDvusLuYiPibRAD4FhjBOdC5GfEPZMk8EUdv/Co+vYV1uJWNO
         K1VeMvWwvAqdWWqxpLtCUZCQ3jK01zvB6J4X8=
Received: by 10.86.95.20 with SMTP id s20mr4653203fgb.26.1240942567937;
        Tue, 28 Apr 2009 11:16:07 -0700 (PDT)
Received: from localhost.localdomain (abvq17.neoplus.adsl.tpnet.pl [83.8.214.17])
        by mx.google.com with ESMTPS id 4sm6705597fge.8.2009.04.28.11.16.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 11:16:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n3SIG7bj025069;
	Tue, 28 Apr 2009 20:16:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n3SIG6ri025060;
	Tue, 28 Apr 2009 20:16:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117801>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Eric Sink hs been working on the (commercial, proprietary) centralised
> SCM Vault for a while. He's written recently about his explorations
> around the new crop of DSCMs, and I think it's quite interesting. A
> quick search of the list archives makes me thing it wasn't discussed
> before.
> 
> The guy is knowledgeable, and writes quite witty posts -- naturally,
> there's plenty to disagree on, but I'd like to encourage readers not
> to nitpick or focus on where Eric is wrong. It is interesting to read
> where he thinks git and other DSCMs are missing the mark.
> 
>    Maybe he's right, maybe he's wrong, but damn he's interesting :-)
> 
> So here's the blog -  http://www.ericsink.com/

"Here's a blog"... and therefore my dilemma. Should I post my reply
as a comment to this blog, or should I reply here on git mailing list?

I think I will just add link to this thread in GMane mailing list
archive for git mailing list...
 
> These are the best entry points
*  "Ten Quirky Issues with Cross-Platform Version Control"
>   http://www.ericsink.com/entries/quirky.html

which I have answered in separate post in this thread

*  "Mercurial, Subversion, and Wesley Snipes"
>   http://www.ericsink.com/entries/hg_denzel.html

which I will comment now.  The 'ES>' prefix means quoting above blog
post.


First there is a list of earlier blog post, with links, which makes
article in question a good staring point.

ES> As part of that effort, I have undertaken an exploration of the
ES> DVCS world.  Several weeks ago I started writing one blog entry
ES> every week, mostly focused on DVCS topics.  In chronological
ES> order, here they are:
ES>
ES> * The one where I gripe about Git's index

where Eric complains that "git add -p" allows for committing untested
changes... not knowing about "git stash --keep-index", and not
understanding that comitting is (usually) separate from publishing in
distributed version control systems (so you can check after commit,
and amend commit if it does not pass test).

ES> * The one where I whine about the way Git allows developers to
ES>   rearrange the DAG

where Eric seems to not notice that you are strongly encouraged to do
'rearranging the DAG' (rewriting the history) _only_ in unpublished
(not made public) part of history.

ES> * The one where it looks like I am against DAG-based version
ES>   control but I'm really not

where Eric conflates linear versus merge workflows with
update-before-commit versus commit-then-merge paradigm, not noticing
that you can have linear history using sane commit-update-rebase
rather than unsafe update-before-commit.

ES> * The one where I fuss about DVCSes that try to act like
ES>   centralized tools

where DVCS in question that behaves this way is Bazaar (if I
understood this correctly).

ES> * The one where I complain that DVCSes have a lousy story when it
ES>   comes to bug-tracking

where Eric correctly notice that distributed version control would not
help much if you use centralized bugtracker, and speculates about
required features that distributed bugtracker should have.  Very nice
post in my opinion.

ES> * The one where I lament that I want to like Darcs but I can't

where Eric talks about difference between parentage in merge commit
(which is needed for good merging) and "parentage"/weak link in
cherry-picked commit; Git uses weak link = no link.

ES> * The one where I speculate cluelessly about why Git is so fast

where Eric guesses instead of asking on git mailing list or #git
channel... ;-)

ES> Along the way, I've been spending some time getting hands-on
ES> experience with these tools.  I've been using Bazaar for several
ES> months.  I don't like it very much.  I am currently in the process
ES> of switching to Git, but I don't expect to like it very much
ES> either.

Aaaargh... if you expect to not like it very much, I would be very
suprised if you find it to your liking...

ES> So why don't I write about Mercurial?  Because I'm pretty sure I
ES> would like it.
ES>
ES> I chose Bazaar and Git for the experience.  But if I were choosing
ES> a DVCS as a regular user, I would choose Mercurial.  I've used it
ES> some, and found it to be incredibly pleasant.  It seems like the
ES> DVCS that got everything just about right.  That's great if you're
ES> a user, but for a writer, what's interesting about that?

Well, Mercurial IMHO didn't get everything right. Not mentioning
implementation issues, like dealing with copies, binary files, and
large files, it got IMHO wrong:
 * branching in multiple branches per repository
 * tags which should be transferrable but non-versioned

-- 
Jakub Narebski
Poland
ShadeHawk on #git
