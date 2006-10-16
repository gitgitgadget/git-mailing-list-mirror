From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Recent and near future backward incompatibilities
Date: Sun, 15 Oct 2006 19:13:05 -0700
Message-ID: <20061015191305.28f71cc2@dads-laptop>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
	<20061015224012.GC5092@thunk.org>
	<Pine.LNX.4.64.0610151650570.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 04:13:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZHz3-0001CZ-UC
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 04:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWJPCNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWJPCNh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 22:13:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932152AbWJPCNg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 22:13:36 -0400
Received: from dads-laptop (069-064-229-129.pdx.net [69.64.229.129])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9G2DIaX029100
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Oct 2006 19:13:27 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610151650570.3962@g5.osdl.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-0.577 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28944>

On Sun, 15 Oct 2006 16:52:04 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Sun, 15 Oct 2006, Theodore Tso wrote:
> > 
> > By the way, note that Ubuntu Dapper (the current stable version of
> > Ubuntu) is shipped with git version 1.1.3, and that incompatibility
> > extends not to the git repository, but also the Linux-2.6 repostiory
> > at
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> That should have been fixed earlier today, since I forced a repack when 
> this was discovered.
> 
> So if somebody still can't pull it with old git tools, please holler.
> 
> That said, Ubuntu should definitely upgrade.
> 
> 		Linus

They made some nice about putting a new version in the backport
repository.
