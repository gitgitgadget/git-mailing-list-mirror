From: Sven Verdoolaege <skimo@liacs.nl>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 18:14:23 +0200
Message-ID: <20050630161423.GC26808@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:09:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do1aP-0006Fx-UU
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVF3QPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVF3QPb
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:15:31 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:32724 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S262991AbVF3QPU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 12:15:20 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5UGEOPl002524;
	Thu, 30 Jun 2005 18:14:29 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id DF4436FEA; Thu, 30 Jun 2005 18:14:23 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050630161043.GR10850@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2005 at 06:10:43PM +0200, Matthias Urlichs wrote:
> I'll find it. However, you don't actually need to re-import your
> existing CVS->GIT trees; as long as the dates and the branch names
> match, my script will continue where the other left off.

I wanted to check first whether it would do the right thing.
I'll wait for your update to do further checking.

skimo
