From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 20:19:17 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702272011300.29426@xanadu.home>
References: <20070227155042.GB3230@spearce.org>
 <Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702271717080.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 02:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMDTV-0005wu-Mz
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 02:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbXB1BTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbXB1BTT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 20:19:19 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16606 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbXB1BTS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 20:19:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE5002UCFO510B3@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 20:19:18 -0500 (EST)
In-reply-to: <alpine.LRH.0.82.0702271717080.29426@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40869>

On Tue, 27 Feb 2007, Nicolas Pitre wrote:

> For reference the GIT tree itself has 585 unique names.
> 
> The Linux kernel has 12263 of them.

OK I lied.  In fact those are the frequency of the most used name 
amongst all tree objects, not the number of unique names.

The real number of unique path components in the Linux repo is 16073.

For the GIT tree it is 1444.

Just for fun here's the 10 most used path components in the Linux kernel 
with their number of hits:

12263:  Makefile
5541:   Kconfig
4050:   kernel
3960:   net
3818:   lib
3785:   mm
3665:   crypto
3337:   sound
3185:   include
3181:   README


Nicolas
