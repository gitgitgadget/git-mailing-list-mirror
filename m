From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Mention install-doc in INSTALL
Date: Sun, 22 Jan 2006 13:12:54 -0500
Message-ID: <20060122181254.GF31954@fieldses.org>
References: <E1F0SYe-0005ix-WB@puzzle.fieldses.org> <20060122001255.GR28365@pasky.or.cz> <7vr771gcu9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 19:13:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0jiI-0006il-VH
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 19:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWAVSM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 13:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWAVSM7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 13:12:59 -0500
Received: from mail.fieldses.org ([66.93.2.214]:35492 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964782AbWAVSM6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 13:12:58 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F0jhu-0001iK-5e; Sun, 22 Jan 2006 13:12:54 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr771gcu9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15056>

On Sat, Jan 21, 2006 at 07:29:02PM -0800, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > But you really do not want to build the documentation as root.
> 
> True.
> 
> > Cogito's "solution" is:
> >
> > + - By default, separate documentation (manpages, text, HTML) is not built
> > +   since it requires asciidoc and xmlto, and those tools are not so common.
> 
> That's cheating ;-), but I cannot blame you.
> 
> I'll push out this hopefully tonight.

Looks good to me; thanks!--b.
