From: Steven Cole <elenstev@mesatop.com>
Subject: Naming the SCM (was Re: Handling renames.)
Date: Thu, 14 Apr 2005 14:42:16 -0600
Message-ID: <200504141442.17235.elenstev@mesatop.com>
References: <002701c54129$da2ffdd0$9b11a8c0@allianceoneinc.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Zach Welch'" <zw@superlucidity.net>,
	"'Linus Torvalds'" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMBD4-0003FN-QS
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 22:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVDNUsC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVDNUsC
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 16:48:02 -0400
Received: from nacho.zianet.com ([216.234.192.105]:56841 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261573AbVDNUqD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 16:46:03 -0400
Received: (qmail 57717 invoked from network); 14 Apr 2005 20:46:01 -0000
Received: from 216-31-65-29.zianet.com (216.31.65.29)
  by 0 with SMTP; 14 Apr 2005 20:46:01 -0000
To: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
User-Agent: KMail/1.6.1
In-Reply-To: <002701c54129$da2ffdd0$9b11a8c0@allianceoneinc.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 14 April 2005 01:40 pm, Andrew Timberlake-Newell wrote:
> Zach Welch pontificated:
> > I imagine quite a few folks expect something not entirely unlike an SCM
> > to emerge from these current efforts. Moreover, Petr's 'git' scripts
> > wrap your "filesystem" plumbing to that very end.
> > 
> > To avoid confusion, I think it would be better to distinguish the two
> > layers, perhaps by calling the low-level plumbing... 'gitfs', of course.
> 
> Or perhaps to come up with a name (or at least nickname) for the SCM.
> 
> GitMaster?
> 

Cogito.  "Git inside" can be the first slogan.

Differentiating the SCM built on top of git from git itself is probably worthwhile
to avoid confusion.  Other SCMs may be developed later, built on git, and these
can come up with their own clever names.

Steven
