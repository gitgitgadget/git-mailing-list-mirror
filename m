From: Nicolas Pitre <nico@cam.org>
Subject: Re: author/commit counts
Date: Sat, 23 Dec 2006 09:31:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612230929410.18171@xanadu.home>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
 <Pine.LNX.4.64.0612230001590.18171@xanadu.home>
 <Pine.LNX.4.63.0612231521340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Randy Dunlap <rdunlap@xenotime.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:31:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7ty-0002NF-K6
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbWLWObB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbWLWObB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:31:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46277 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbWLWObB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:31:01 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAQ007NODNOZVO2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 09:31:00 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0612231521340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35320>

On Sat, 23 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 23 Dec 2006, Nicolas Pitre wrote:
> 
> > 	git log --author=<blah> | git shortlog -s
> 
> Note that the builtin shortlog reuses the fine revision walking machinery:
> 
> 	git shortlog --author=<blah> -n -s
> 
> works like a charm.

I know and use it myself.  But many people might not have a recent 
enough git version for that.


Nicolas
