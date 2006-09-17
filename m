From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Setting up Password protected repositories?
Date: Sun, 17 Sep 2006 12:43:47 -0400
Message-ID: <20060917164347.GA21710@fieldses.org>
References: <E1GOktx-0005JY-ER@jdl.com> <7virjn8eua.fsf@assigned-by-dhcp.cox.net> <E1GOm3h-0005jq-5u@jdl.com> <20060917022013.GA7512@spearce.org> <E1GOzP9-0001Fn-G8@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 18:44:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOzkX-0003OM-1b
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 18:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWIQQny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWIQQny
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 12:43:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50371 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965006AbWIQQny
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 12:43:54 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1GOzkB-0006sw-7P; Sun, 17 Sep 2006 12:43:47 -0400
To: Jon Loeliger <jdl@jdl.com>
Content-Disposition: inline
In-Reply-To: <E1GOzP9-0001Fn-G8@jdl.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27198>

On Sun, Sep 17, 2006 at 11:22:03AM -0500, Jon Loeliger wrote:
> So, like, the other day Shawn Pearce mumbled:
> > Access is controlled by standard UNIX user/group read/write access
> > and ACLs if your OS/filesystem support them.  You can also control
> > pushing with an update hook.
> 
> OK.  I seem to recall a recipe down this line somwhere...  Is there
> a current "Best Practices" write up somewhere with these details
> outlined in it?

There's a few sentences in Documentation/cvs-migration.txt, and a little
more in Documentation/howto/update-hook-example.txt

--b.
