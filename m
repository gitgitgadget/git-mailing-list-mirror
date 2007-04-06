From: Nicolas Pitre <nico@cam.org>
Subject: Re: kde.git is now online
Date: Fri, 06 Apr 2007 08:59:00 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704060857240.28181@xanadu.home>
References: <46152BF5.3050502@zytor.com>
 <7vk5wqo6ms.fsf@assigned-by-dhcp.cox.net>
 <43336D7E-AFE7-4BAF-93C7-B302933363B5@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 15:03:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZo2E-0007IB-NQ
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 14:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767598AbXDFM7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 08:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767601AbXDFM7G
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 08:59:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47972 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767598AbXDFM7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 08:59:05 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG2001PGUQFU810@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Apr 2007 08:59:03 -0400 (EDT)
In-reply-to: <43336D7E-AFE7-4BAF-93C7-B302933363B5@adacore.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43911>

On Fri, 6 Apr 2007, Geert Bosch wrote:

> On my Mac OS X system, cloning this fails with:
> 
> potomac:~/kde%git clone http://userweb.kernel.org/~hpa/kdegit/kde.git
> Initialized empty Git repository in /Users/bosch/kde/kde/.git/
> Getting alternates list for http://userweb.kernel.org/~hpa/kdegit/kde.git/
> Getting pack list for http://userweb.kernel.org/~hpa/kdegit/kde.git/
> Getting index for pack c3df59bc67f69b3861ebef8de308156f1c5fe017
> Getting pack c3df59bc67f69b3861ebef8de308156f1c5fe017
> which contains ca908d2d51f154aab9f5727c1e57fb23a2942485
> fatal: packfile
> /Users/bosch/kde/kde/.git/objects/pack/pack-c3df59bc67f69b3861ebef8de308156f1c5fe017.pack
> cannot be mapped.
> 
> Even worse, al files seem to have been deleted, so I have to
> download this again. I guess, I shouldn't have used git clone...

Given that this repo is pushing it to the limits, you better download 
the .tar.bz2 archive and play with it locally first.


Nicolas
