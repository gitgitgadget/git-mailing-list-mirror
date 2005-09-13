From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 23:14:44 +0200
Message-ID: <20050913211444.GA27029@mars.ravnborg.org>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 23:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFI4n-0007gV-Gy
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVIMVMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVIMVMW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:12:22 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:36977 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932392AbVIMVMW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 17:12:22 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id 2DBB626281F;
	Tue, 13 Sep 2005 23:12:20 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id E63CC6AC01D; Tue, 13 Sep 2005 23:14:44 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8486>

On Tue, Sep 13, 2005 at 02:07:58PM -0700, Junio C Hamano wrote:
> I've looked at ~80 git repositories publicly available at
> kernel.org and noticed only 23 are prepared to handle dumb
> transports.  That probably means either most of these trees are
> not pulled by people without kernel.org accounts, or public are
> using rsync or cogito to pull from these trees.  I somehow find
> this number very discouraging ...

Whats wrong using cogito?
In other words. Why does you feel like that when we use cogito to do
cg-update.

	Sam
