From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 13:17:43 -0400
Message-ID: <9e4733910609141017r37fbbd45q5fcf7d0f39b48cf3@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	<9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	<46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	<450872AE.5050409@bluegap.ch>
	<9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
	<4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org>
	<eebuih$u32$1@sea.gmane.org>
	<9e4733910609140927y30ecaa42wae0ff0597b8c3842@mail.gmail.com>
	<45098AE0.6030409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: monotone-devel@nongnu.org, dev@rapidsvn.tigris.org, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org Thu Sep 14 19:18:04 2006
Return-path: <monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org>
Envelope-to: gcvmd-monotone-devel@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNuqc-0007Fq-WD
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 19:17:59 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1GNuqc-0004TT-6q
	for gcvmd-monotone-devel@m.gmane.org; Thu, 14 Sep 2006 13:17:58 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1GNuqY-0004Qu-Fx
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:17:54 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1GNuqX-0004PN-9O
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:17:53 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1GNuqX-0004PE-6X
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:17:53 -0400
Received: from [64.233.162.206] (helo=nz-out-0102.google.com)
	by monty-python.gnu.org with esmtp (Exim 4.52) id 1GNusW-0004p7-CY
	for monotone-devel@nongnu.org; Thu, 14 Sep 2006 13:19:56 -0400
Received: by nz-out-0102.google.com with SMTP id n29so1275094nzf
	for <monotone-devel@nongnu.org>; Thu, 14 Sep 2006 10:17:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=gmail.com;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	b=t/+oZIX1s1VEppjw3YZ43HYaM6V1yJsDZqHDrBRpswXNGwEHb31u0prPBCyhl/UyevLgNauLxCKJ59dOd08xfQkAm+Dz0GQ0KWulqlt7IVP+Ef47AwKQme9lT4CZZNUSsWH2YttX1O6Q6aUzZsm86nqu7wcKl+5ba9f6d/tVgHQ=
Received: by 10.35.88.18 with SMTP id q18mr15396797pyl;
	Thu, 14 Sep 2006 10:17:43 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 14 Sep 2006 10:17:43 -0700 (PDT)
To: "Michael Haggerty" <mhagger@alum.mit.edu>
In-Reply-To: <45098AE0.6030409@alum.mit.edu>
Content-Disposition: inline
X-BeenThere: monotone-devel@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: developer discussion for monotone <monotone-devel.nongnu.org>
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/monotone-devel>
List-Post: <mailto:monotone-devel@nongnu.org>
List-Help: <mailto:monotone-devel-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/monotone-devel>,
	<mailto:monotone-devel-request@nongnu.org?subject=subscribe>
Sender: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Errors-To: monotone-devel-bounces+gcvmd-monotone-devel=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27018>

On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Jon Smirl wrote:
> > On 9/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Shawn Pearce wrote:
> >>
> >> > Originally I wanted Jon Smirl to modify the cvs2svn (...)
> >>
> >> By the way, will cvs2git (modified cvs2svn) and git-fast-import publicly
> >> available?
> >
> > It has some unresolved problems so I wasn't spreading it around everywhere.
> >
> > It is based on cvs2svn from August. There has been too much change to
> > the current cvs2svn to merge it anymore. [...]
> >
> > If the repo is missing branch tags cvs2svn may turn a single missing
> > branch into hundreds of branches. The Mozilla repo has about 1000
> > extra branches because of this.
>
> [To explain to our studio audience:] Currently, if there is an actual
> branch in CVS but no symbol associated with it, cvs2svn generates branch
> labels like "unlabeled-1.2.3", where "1.2.3" is the branch revision
> number in CVS for the particular file.  The problem is that the branch
> revision numbers for files in the same logical branch are usually
> different.  That is why many extra branches are generated.
>
> Such unnamed branches cannot reasonably be accessed via CVS anyway, and
> somebody probably made the conscious decision to delete the branch from
> CVS (though without doing it correctly).  Therefore such revisions are
> probably garbage.  It would be easy to add an option to discard such
> revisions, and we should probably do so.  (In fact, they can already be
> excluded with "--exclude=unlabeled-.*".)  The only caveat is that it is
> possible for other, named branches to sprout from an unnamed branch.  In
> this case either the second branch would have to be excluded too, or the
> unlabeled branch would have to be included.

In MozCVS there are important branches where the first label has been
deleted but there are subsequent branches off from the first branch.
These subsequent branches are still visible in CVS. Someone else had
this same problem on the cvs2svn list. This has happen twice on major
branches.

Manually looking at one of these it looks like the author wanted to
change the branch name. They made a branch with the wrong name,
branched again with the new name, and deleted the first branch.

> Alternatively, there was a suggestion to add heuristics to guess which
> files' "unlabeled" branches actually belong in the same original branch.
>  This would be a lot of work, and the result would never be very
> accurate (for one thing, there is no evidence of the branch whatsoever
> in files that had no commits on the branch).

You wrote up a detailed solution for this a few weeks ago on the
cvs2svn list. The basic idea is to look at the change sets on the
unlabeled branches. If change sets span multiple unlabeled branches,
there should be one unlabeled branch instead of multiple ones. That
would work to reduce the number of unlabeled branches down from 1000
to the true number which I believe is in the 10-20 range.

Would the dependency based model make these relationships more obvious?

>
> Other ideas are welcome.
>
> Michael
>


-- 
Jon Smirl
jonsmirl@gmail.com
