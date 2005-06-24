From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 15:06:04 +0200
Message-ID: <20050624130604.GK17715@g5.random>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Fri Jun 24 15:04:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlnq0-0004nd-0I
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVFXNIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFXNIs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:08:48 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63535
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262416AbVFXNGK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 09:06:10 -0400
Received: by g5.random (Postfix, from userid 500)
	id E5C9557538B; Fri, 24 Jun 2005 15:06:04 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050624064101.GB14292@pasky.ji.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
> Cool. Except where the concepts are just different, Cogito mostly
> appears at least equally simple to use as Mercurial. Yes, some features
> are missing yet. I hope to fix that soon. :-)

The user interface and network protocol isn't the big deal, the big deal
is the more efficient on-disk storage format IMHO.
