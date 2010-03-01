From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [RFC,PATCH] git-amend -- darcs like amend-record for git
Date: Mon, 1 Mar 2010 12:08:59 -0500
Message-ID: <20100301170859.GA4142@cthulhu>
References: <1267107365-2973-1-git-send-email-kirr@mns.spb.ru>
 <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 18:09:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm97D-0004mH-Jb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 18:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab0CARJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 12:09:00 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:50381 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0CARJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 12:09:00 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 6957C82201E; Mon,  1 Mar 2010 12:08:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <be6fef0d1003010116p443985b3ib71f229a1978f831@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141333>

* Tay Ray Chuan (rctay89@gmail.com) [100301 04:16]:
> Hi,
> 
> On Thu, Feb 25, 2010 at 10:16 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > Ever wanted to type `git commit --amend HEAD~3` ? But had to fall back to commit
> > and interactive rebase with fixup? And was tired by a lot of typing? And also
> > rebase works only on clean worktree, so stash save and stash pop have to be
> > used...
> >
> > Forget it.
> >
> > Now one can just do `git add ...` to prepare index, and then
> > `git amend <commit>` to merge that changes from index into <commit>.
> 
> this may be a little late, but I'd like to indicate my interest in
> such a feature.

I like it too.

  --larry
