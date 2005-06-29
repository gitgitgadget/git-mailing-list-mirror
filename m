From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Wed, 29 Jun 2005 12:27:46 +0200
Message-ID: <20050629102746.GA2484@ucw.cz>
References: <3886.10.10.10.24.1119991512.squirrel@linux1> <20050628221422.GT12006@waste.org> <3993.10.10.10.24.1119997389.squirrel@linux1> <20050628224946.GU12006@waste.org> <4846.10.10.10.24.1119999568.squirrel@linux1> <40A9C7C2-1AFE-45BC-90A5-571628304479@mac.com> <1765.10.10.10.24.1120001856.squirrel@linux1> <40A4071C-ED45-4280-928F-BCFC8761F47E@mac.com> <2661.10.10.10.24.1120004702.squirrel@linux1> <12B6F9A5-81F8-46BD-A05D-B9FA1A70A9FF@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Matt Mackall <mpm@selenic.com>,
	Petr Baudis <pasky@ucw.cz>, Christopher Li <hg@chrisli.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Wed Jun 29 12:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnZgZ-0007VF-5F
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 12:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVF2K1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 06:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVF2K1u
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 06:27:50 -0400
Received: from s243.chello.upc.cz ([62.24.84.243]:25564 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262500AbVF2K1f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 06:27:35 -0400
Received: by suse.cz (Postfix, from userid 10002)
	id 0F85E126AC6; Wed, 29 Jun 2005 12:27:46 +0200 (CEST)
To: Kyle Moffett <mrmacman_g4@mac.com>
Content-Disposition: inline
In-Reply-To: <12B6F9A5-81F8-46BD-A05D-B9FA1A70A9FF@mac.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2005 at 11:53:47PM -0400, Kyle Moffett wrote:

> On Jun 28, 2005, at 20:25:02, Sean wrote:
> >there will be a price to pay if the linux community fragments over
> >choice of scm.
> 
> I don't agree.  With the current set of SCMs, I don't think it will
> be long before somebody invents a gitweb/Mercurial/whatever gateway,
> such that I can "hg serve" from my Mercurial repository and have
> Linus "git pull" from a multiprotocol bridge.

I hope this will happen sooner than later, since that way the
competition between git and mercurial will give us the best tools while
keeping interoperability.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
