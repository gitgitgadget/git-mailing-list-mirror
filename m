From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 12:14:16 -0700 (PDT)
Message-ID: <m3d36jrc74.fsf@localhost.localdomain>
References: <86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com>
	<86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com>
	<CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
	<4FA2D1D7.3020807@palm.com>
	<CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
	<4FA2D97A.8090504@palm.com> <86ipgdhvjo.fsf@red.stonehenge.com>
	<4FA2F013.3020904@palm.com> <20120504155606.GB30130@sirena.org.uk>
	<4FA41E8E.20900@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Nathan Gray <n8gray@n8gray.org>,
	PJ Weisberg <pj@irregularexpressions.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:14:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQNxQ-0003Vj-PK
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab2EDTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:14:20 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56366 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab2EDTOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:14:20 -0400
Received: by wibhr7 with SMTP id hr7so1680057wib.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=T0SC8e5AzjWJvEzc/sSxPOJFEKAqrERlCe7B5y9bgqQ=;
        b=w3h4YrDQd1+VBmWhRN7ayXrQz9iN1g5XjKCZ6qMNReB37bq+VgKJPdkrCUiTv19Cyy
         4Fehf1pi26//hqagZa6GRvI2O7FvbivsUwOtCCfanSrk46tS+H54LdI06rzex3KGnzqK
         odEBj3AscaZAwU0AjHaWV26xPeYVyZ09PI8qyfBUD4XRJhp8d1ES2e7JTeISoAHrafiS
         qtqk81h0qMMsABNPoNEVUaw7TXZphacewspjyNwTYsQ1/EVWvDG55MtrYnebdQ4GZx2f
         DHBnhhvPBF6Aguz3flnOUBOcZqcXRLRqIoMMdKo4x7NY0dqKhZta5Wgjb8hU62U+BIed
         bzRw==
Received: by 10.216.225.216 with SMTP id z66mr4583512wep.71.1336158858766;
        Fri, 04 May 2012 12:14:18 -0700 (PDT)
Received: from localhost.localdomain (addh252.neoplus.adsl.tpnet.pl. [79.184.59.252])
        by mx.google.com with ESMTPS id gd4sm18031657wib.6.2012.05.04.12.14.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 12:14:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q44JEBhs023411;
	Fri, 4 May 2012 21:14:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q44JE7xC023407;
	Fri, 4 May 2012 21:14:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4FA41E8E.20900@palm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197052>

Rich Pixley <rich.pixley@palm.com> writes:
> On 5/4/12 08:56 , Mark Brown wrote:
> > On Thu, May 03, 2012 at 01:52:35PM -0700, Rich Pixley wrote:
> >
> > > It's not just hg.  It's other source code control systems as well.
> > > Check out any of the other daggy guys.  So sure, I'll admit a bias
> > > for current technology over older tech.
> >
> > I'm still not sure what's missing here without a central server?   The
> > other DVCSs I've used (which don't include hg) do require that the user
> > trigger a merge operation somehow; they don't magically go and merge
> > things without being asked.
> 
> Nor does hg.  Rather, it allows the collision to be tracked within the
> source code control tool so that anyone who wants to see it can do so,
> and so that anyone who wants to merge it can do so.  The data flow
> paths for collisions and proposed changes can follow precisely the
> same paths as any other code changes.  No meta channel is required.
> 
> This is a different situation from either the one where I,
> specifically me, must merge or the one where I intend my changes to
> stay separated from other development, (a new "branch").  The
> situation with multiple heads allows the merge, the branch, even the
> decision about whether to merge or branch, to be delayed indefinitely.
> 
> The fact that it allows for this also allows for a number of different
> repository network architectures, all of which are blocked in git
> because of the push problem.  In git, those decisions must be made
> _before_ the push.

Well, perhaps Git doesn't support "central repository" workflow, where
users push to common repository, as well as Mercurial.  The main
workflow is based on pairs of private (non-bare) + public (bare)
repositories, one pair for each developer.  You push to own
repository, and pull from other public repositories.
 
Note that there is no problem in Git in "pull" direction (at least for
pulling single branch): you either fast-forward (be updated), or be
asked to perform a merge.  Instead of anonymous heads you get
automatically named remote-tracking branches.

With respect to "push" direction Git assumes that you don't have shell
access to remote repository, so there is nobody to perform a merge;
hence assymetry between "git pull" and "git push".

BTW. can you get in Mercurial which anonymous head comes from which
repository?

> There's also a possibility of nonterminating merges.  That is, if my
> team is making changes faster than you can merge them, then you'll
> never get to push your changes.  With dual heads, you still can.  And
> then anyone who wants to can merge them.

Well, if you have that much activity, you better switch workflows away
from "central repository" one, perhaps to maintainer + lieutenants
pull-based workflow.

Or you can axplicitely push to side branch 

  $ git push repo master:foo/master

and ask in side channel to merge it.


For me using multi-tailed (multi-head) branches instead of
remote-tracking branches serves to blur important distinction
(assymetry) between pull and push directions.


Now if I understand correctly what you wanted to have is a set of
remote repositories, updated only by you (or at least updated in such
way that fast-forward non-merge updates are more common than merges),
and a way to fetch from those repositories so that branches gets
updated to most recent version from among the set of those
repositories, isn't it?

That's quite advanced workflow / requirement, isn't it?

-- 
Jakub Narebski
