From: Nicolas Pitre <nico@cam.org>
Subject: Re: The big git command renaming..
Date: Sat, 30 Apr 2005 10:24:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504301023060.14033@localhost.localdomain>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 16:19:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRsoK-0004SW-Bn
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 16:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVD3OYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 10:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVD3OYw
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 10:24:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44621 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261232AbVD3OYs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 10:24:48 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IFR005IVK19LY@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 30 Apr 2005 10:24:45 -0400 (EDT)
In-reply-to: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Linus Torvalds wrote:

> So I just pushed out a change that renames the commands to always have a 
> "git-" prefix. In addition, I renamed "show-diff" to "diff-files", with 
> together with the prefix means that it becomes "git-diff-files" when used.

While at it, could you also rename show-files to ls-files?


Nicolas
