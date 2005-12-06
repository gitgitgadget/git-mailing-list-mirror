From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Wine + GIT
Date: Tue, 6 Dec 2005 12:39:09 -0500
Message-ID: <20051206173909.GE17457@fieldses.org>
References: <4394CD68.8020500@codeweavers.com> <4394F173.6000505@pobox.com> <20051206170803.GD17457@fieldses.org> <7vacfe2ks1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 18:42:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjgmY-0002k5-GI
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 18:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVLFRjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 12:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVLFRjL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 12:39:11 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43916 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932598AbVLFRjK
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 12:39:10 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1EjgmT-0005t1-5x; Tue, 06 Dec 2005 12:39:09 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacfe2ks1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13283>

On Tue, Dec 06, 2005 at 09:33:02AM -0800, Junio C Hamano wrote:
> There is a long time-horizon plan to move most of the things out
> of /usr/bin/, and codewise we have the infrastructure to do it
> today. The only reason we haven't done so is that it would break
> scripts written by people who learned git from documents that
> tell them to write things in dash form, "git-diff".

I've enjoyed getting tab completions without having to add whatever's
required to my .bashrc to teach it about git subcommands.  Oh well, I'll
get over it.

I suppose the git-subcommand convention will continue for the purpose of
naming manpages?

--b.
