From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:26:21 +0200
Message-ID: <20070520222621.GG25462@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520210954.GB942MdfPADPa@greensroom.kotnet.org> <20070520212432.GE25462@steel.home> <20070520214732.GC942MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 00:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptrH-0006rB-VH
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217AbXETW0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757112AbXETW0Z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:26:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:27246 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbXETW0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:26:24 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (mrclete mo59) (RZmta 6.5)
	with ESMTP id K0437cj4KK6w4A ; Mon, 21 May 2007 00:26:22 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 236FD277BD;
	Mon, 21 May 2007 00:26:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id EC0C2D195; Mon, 21 May 2007 00:26:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520214732.GC942MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47938>

Sven Verdoolaege, Sun, May 20, 2007 23:47:32 +0200:
> 
> How would _you_ specify which subprojects to checkout ?
> 

Aren't the ones which already have .git in them are kind of specified?
