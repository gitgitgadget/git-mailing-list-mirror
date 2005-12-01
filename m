From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [Question] Fetching a new branch from remote
Date: Thu, 01 Dec 2005 14:40:56 -0600
Message-ID: <1133469656.30767.76.camel@cashmere.sps.mot.com>
References: <7vk6eoinqa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Carl Baldwin <cnb@fc.hp.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 01 21:50:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhvMW-0002aW-LZ
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 21:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbVLAUtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 15:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbVLAUtA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 15:49:00 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:8626 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751714AbVLAUtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 15:49:00 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id jB1Krt67020409;
	Thu, 1 Dec 2005 13:53:55 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id jB1KmZUQ015989;
	Thu, 1 Dec 2005 14:48:35 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6eoinqa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13072>

On Thu, 2005-12-01 at 14:09, Junio C Hamano wrote:

> 
> I just found out that the documentation for '-f' flag is simply
> missing.  I'd propose to add the following.  Thanks for noticing.

Hmm.  Apologies.  I had mentioned it back here, but
didn't know what it did and so didn't document it:

        
    From: 	Jon Loeliger <jdl@freescale.com>
    To: 	git@vger.kernel.org
    Subject: 	[PATCH] Add --tags documentation, scraped from JC mail.
    Date: 	Mon, 7 Nov 2005 07:03:30 -0700 	

    Signed-off-by: Jon Loeliger <jdl@freescale.com>

    ---

    Thin territory here for me.  Feel free to alter if not right! :-)
    Also notice the lonely --force option still...
