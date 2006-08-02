From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: What's in git.git
Date: Wed, 2 Aug 2006 12:29:22 -0700
Message-ID: <20060802192922.GA30539@prophet.net-ronin.org>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 21:29:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8MPL-0002Uj-Kq
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 21:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHBT32 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 15:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWHBT32
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 15:29:28 -0400
Received: from S0106000ea6c7835e.no.shawcable.net ([70.67.106.153]:11720 "EHLO
	prophet.net-ronin.org") by vger.kernel.org with ESMTP
	id S932161AbWHBT31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 15:29:27 -0400
Received: from ramune by prophet.net-ronin.org with local (Exim 3.35 #1 (Debian))
	id 1G8MPC-0007zM-00; Wed, 02 Aug 2006 12:29:22 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24671>

Any plans on a fix for:
http://marc.theaimsgroup.com/?l=git&m=115089393505286&w=2

I use gitk a lot, but having to nuke ~/.gitk every time I launch it is a bit
annoying. :-)

Commenting out the line mentioned in the reply lets me resize the window and
see the bottom panel properly -- but I do have to resize it every time so it
doesn't extend past the bottom of the screen.

FYI, if it's not easy to reproduct, I'm running it on Debian/stable systems,
i386 and x86_64, both with backports.org X servers, using tcl/tk 8.4

-- DN
Daniel Nobuto
