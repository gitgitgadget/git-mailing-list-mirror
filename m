From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] packed delta git
Date: Thu, 19 May 2005 15:30:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505191529290.20274@localhost.localdomain>
References: <200505171857.46370.mason@suse.com>
 <200505191428.52238.mason@suse.com>
 <20050519183810.GF8105@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 21:32:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYqiE-000716-N6
	for gcvg-git@gmane.org; Thu, 19 May 2005 21:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVESTaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVESTaR
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 15:30:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14569 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261229AbVESTaN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 15:30:13 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGR00L694U6SB@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 May 2005 15:30:07 -0400 (EDT)
In-reply-to: <20050519183810.GF8105@cip.informatik.uni-erlangen.de>
X-X-Sender: nico@localhost.localdomain
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 19 May 2005, Thomas Glanzmann wrote:

> Hello Chris,
> 
> > size (du -sh .git)              2.5G                  227M
> 
> wow that beats bitkeeper in size. What is missing to actual use such a
> approach in a distributed environment?

Me completing fsck-cache support for delta objects.


Nicolas
