From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Tue, 27 Feb 2007 10:38:09 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702271036010.29426@xanadu.home>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerz
 burg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4P8-0003Tk-6Z
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbXB0PiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbXB0PiL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:38:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24322 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbXB0PiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:38:10 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE400EW7ORM6RA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 10:38:10 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40749>

On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> 
> This outputs the log in GNU ChangeLog format.

Please don't call it "changelog".  I personally find this format horrid 
and "changelog" is too generic for such a specific format.  
"gnu_changelog" maybe...


Nicolas
