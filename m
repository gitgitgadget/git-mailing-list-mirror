From: Petr Baudis <pasky@suse.cz>
Subject: Re: small merge tool for temporary merges
Date: Sun, 3 Aug 2008 18:58:05 +0200
Message-ID: <20080803165805.GY32184@machine.or.cz>
References: <20080803163415.GB14513@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 18:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPgvI-00068j-7n
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 18:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbYHCQ6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 12:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbYHCQ6J
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 12:58:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46518 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756277AbYHCQ6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 12:58:09 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B08FC3939B3E; Sun,  3 Aug 2008 18:58:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080803163415.GB14513@gmx.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91253>

  Hi,

On Sun, Aug 03, 2008 at 06:34:15PM +0200, Marc Weber wrote:
> I'd like to announce the exisntance of my small git test merge tool.
> 
> After reading 
>  Linux kernel mailing list may remember that Linus complained about such
>  too frequent test merges when a subsystem maintainer asked to pull from
>  a branch full of "useless merges"
> in the man page of git-rerere I had to start it..
> 
> $ git clone git://mawercer.de/git-test-merge

  for the mildly curious ones, your friendly gitweb provider service
offers

	http://repo.or.cz/w/git-test-merge.git

				Petr "Pasky" Baudis
