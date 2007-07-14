From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn patch faulty (was: failing to send patches to the list)
Date: Sat, 14 Jul 2007 03:54:55 -0700
Message-ID: <20070714105455.GB14842@muzzle>
References: <20070713093050.GA18001@lapse.madduck.net> <20070713095644.GA26743@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 12:54:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9fH8-0002dq-TW
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbXGNKy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbXGNKy4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:54:56 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41656 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756440AbXGNKyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:54:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7536E2DC032;
	Sat, 14 Jul 2007 03:54:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070713095644.GA26743@lapse.madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52470>

martin f krafft <madduck@madduck.net> wrote:
> Hi there,
> 
> still not having figured out the problem with the list (and I did
> contact postmaster@), I just discovered that in fact the patch only
> handles git-svn clone, not git-svn init. Thus, it's best to ignore
> it for now. I am sorry for not taking enough care before publishing
> it.

Heh, I haven't used git-svn init in months :)

-- 
Eric Wong
