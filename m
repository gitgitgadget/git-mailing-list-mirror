From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merging initial part of a branch?
Date: Fri, 13 Jan 2006 10:10:05 -0500
Message-ID: <20060113151005.GA29804@fieldses.org>
References: <20060111230451.GH8618@fieldses.org> <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <20060112005531.GB14599@fieldses.org> <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net> <20060113030837.GD27214@fieldses.org> <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 16:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExQZA-0005u1-VI
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 16:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWAMPKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 10:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWAMPKJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 10:10:09 -0500
Received: from mail.fieldses.org ([66.93.2.214]:17608 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1422713AbWAMPKH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 10:10:07 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1ExQZ4-00081A-0F; Fri, 13 Jan 2006 10:10:06 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14629>

On Thu, Jan 12, 2006 at 08:00:06PM -0800, Junio C Hamano wrote:
> Backward compatibility is that it was only either "<branch>" or
> "tag <tag>".  When heads/branch or tags/tag came later,
> supporting the separate word form "tag <tag>" was a bit
> cumbersome but was done for b/c.

Thanks for the explanation, makes sense.

I might try to put together some more extensive documentation patches
over the next couple weeks if you're willing to take them.  Plain git
actually seems to have pretty usable interfaces at this point, but it's
not always obvious where to find them....

I also have Yet Another Git Tutorial, at
http://www.fieldses.org/~bfields/kernel/git.html.  (Corrections and
suggestions welcomed.)

--b.
