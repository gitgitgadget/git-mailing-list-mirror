From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Another Perforce importer for git
Date: Mon, 14 Aug 2006 16:07:15 +0200
Organization: At home
Message-ID: <ebq016$fd3$1@sea.gmane.org>
References: <81b0412b0608140604u75c6522brbc1bc83fc7c9c5c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 16:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCd5y-0006h2-T5
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 16:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWHNOHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWHNOHG
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 10:07:06 -0400
Received: from main.gmane.org ([80.91.229.2]:55991 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751370AbWHNOHF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 10:07:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCd5Z-0006YK-Ai
	for git@vger.kernel.org; Mon, 14 Aug 2006 16:06:45 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 16:06:45 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 16:06:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25353>

Alex Riesen wrote:

> Just in case someone might ever need this: it imports
> a _synced_ state into git repo. IOW, you sync down
> the files as you were commanded (it's corporal, umm...
> corporate, remember?) and run the script to create
> a commit for you. You still have to run git-commit manually,
> but don't have to pass "-a" to it (which can be dangerous,
> and does not pick up the files recently added to p4 repo).

Could you please add appropriate entry in GitWiki page
 http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
Thanks in advance...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
