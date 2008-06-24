From: Nicolas Pitre <nico@cam.org>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 11:02:17 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806241101160.2979@xanadu.home>
References: <alpine.DEB.1.00.0806241515460.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 17:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBA38-0000Jb-W9
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 17:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYFXPCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYFXPCS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 11:02:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26904 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYFXPCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 11:02:18 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K2Z00ILP33TCGH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 11:02:17 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0806241515460.9925@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86069>

On Tue, 24 Jun 2008, Johannes Schindelin wrote:

> 
> When you look for a fix instead of a regression, it can be quite hard
> to twist your brain into choosing the correct bisect command between
> 'git bisect bad' and 'git bisect good'.
> 
> So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

I really like it.  And yes, I know what you mean.


Nicolas
