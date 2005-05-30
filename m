From: Nicolas Pitre <nico@cam.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 16:49:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 22:47:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcrAB-00058h-A5
	for gcvg-git@gmane.org; Mon, 30 May 2005 22:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVE3Utl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVE3Utl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 16:49:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29417 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261742AbVE3Utk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 16:49:40 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHB00AT5LULB0@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 30 May 2005 16:49:33 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 30 May 2005, Linus Torvalds wrote:

> 
> Ok, I'm at the point where I really think it's getting close to a 1.0, and
> make another tar-ball etc.

Any chance you could merge my latest mkdelta patch _please_ ???

I just posted it twice in the last 4 days and it still didn't appear in 
your repository.

Again, the current version of mkdelta in your tree has a bug that can 
screw things up, and it is fixed in the latest patch of course.


Nicolas
