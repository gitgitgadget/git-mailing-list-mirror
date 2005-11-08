From: Petr Baudis <pasky@suse.cz>
Subject: Re: Regarding: git-lost+found
Date: Tue, 8 Nov 2005 18:48:46 +0100
Message-ID: <20051108174846.GE1431@pasky.or.cz>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de> <20051108174524.GD1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 18:54:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZXau-0006aF-Jq
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 18:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVKHRst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 12:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVKHRst
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 12:48:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5843 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932403AbVKHRss (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 12:48:48 -0500
Received: (qmail 19416 invoked by uid 2001); 8 Nov 2005 18:48:46 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20051108174524.GD1431@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11345>

> > I think this is a valuable addition to the "Now what?" part of git. 
> > However, I'd like to see the results stored into .git/refs/lost+found/ 
> > rather than .git/lost+found/, so that it is possible to inspect them 
> > easily with gitk or git-show-branch.
> 
> What is it supposed to be?

Sorry for the noise - /lost.found/ found some matches (see the "what
after 0.98" mail from Junio). (Still, it would be helpful to put a
reference to your mail.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
