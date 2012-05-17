From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v5] git-svn: clarify the referent of dcommit's optional
 argument
Date: Thu, 17 May 2012 09:37:07 +0000
Message-ID: <20120517093707.GA18177@dcvr.yhbt.net>
References: <1337224843-21718-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 11:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUx92-0002Bj-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 11:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab2EQJhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 05:37:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56521 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab2EQJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 05:37:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6E41F4DE;
	Thu, 17 May 2012 09:37:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1337224843-21718-1-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197915>

Jon Seymour <jon.seymour@gmail.com> wrote:
> The documentation of the dcommit subcommand is reworded to clarify that
> the optional argument refers to a git branch, not an SVN branch.
> 
> The discussion of the optional argument is put into its own paragraph
> as is the guidance about using 'dcommit' in preference to 'set-tree'.
> 
> The section on REBASE vs. PULL/MERGE is reworded to incorporate the
> advice to prefer 'git rebase' previously in the description of 'dcommit'.
> 
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Thanks, Acked-by: Eric Wong <normalperson@yhbt.net>

Pushed to git://bogomips.org/git-svn along with Avishay's recent patch
