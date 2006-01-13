From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merging initial part of a branch?
Date: Fri, 13 Jan 2006 15:01:52 -0500
Message-ID: <20060113200152.GI4369@fieldses.org>
References: <20060111230451.GH8618@fieldses.org> <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <20060112005531.GB14599@fieldses.org> <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net> <20060113030837.GD27214@fieldses.org> <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net> <20060113151005.GA29804@fieldses.org> <7v4q477vqj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 21:05:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExVAc-00061G-3G
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 21:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWAMUDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 15:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWAMUCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 15:02:09 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40157 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1422878AbWAMUBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 15:01:54 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1ExV7Q-0002cq-QK; Fri, 13 Jan 2006 15:01:52 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q477vqj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14644>

On Fri, Jan 13, 2006 at 11:50:44AM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> but the general sentiment was that having another document is
> making things more confusing and we should try to clarify the
> main documentation instead.

Understood.  We may need to add documentation here and there, but that
needs to be done alongside clarifying the existing text and
organization, and without creating unnecessary duplication.

> So I would really appreciate documentaiotn patches to clarify
> the current mess ;-).

OK.  I'll see if I can up with something useful!

> > I also have Yet Another Git Tutorial, at
> > http://www.fieldses.org/~bfields/kernel/git.html.  (Corrections and
> > suggestions welcomed.)
> 
> The $prefix defaults to $HOME/bin/.  Having $bindir on $PATH
> ought to be enough and exporting GIT_EXEC_PATH is not needd.
> 
> Other than that I did not see anything obviously wrong, although
> I suspect you did not intend to say clone with stgit.

Whoops, right.  Thanks for the corrections; I've applied all three.

--b.
