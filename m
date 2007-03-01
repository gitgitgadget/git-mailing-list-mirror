From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Thu, 1 Mar 2007 18:13:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703011811560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <200702282348.51478.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.63.0703010213420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200703011256.50659.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 18:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMoqY-0001Xq-1j
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 18:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417AbXCARNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 12:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbXCARNP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 12:13:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:35072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965417AbXCARNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 12:13:14 -0500
Received: (qmail invoked by alias); 01 Mar 2007 17:13:13 -0000
X-Provags-ID: V01U2FsdGVkX1/7gWkgXBj79adLXw6Tk0u8Ul3LH7ygLxTPlWzpM0
	jvbWijPiz5404u
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703011256.50659.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41107>

Hi,

On Thu, 1 Mar 2007, Robin Rosenberg wrote:

> - What do you want to do today?
> 	a) Screw me with copies
> 	b) Screw me with text links
> 	c) Screw me with shortcuts (cygwin does this which is fine as long 
>	   as I stay within cygwin, so it is ok as a default behaviour 
>	   there, but not otherwise)

I think we already wasted enough quality time on this Windows hell. I will 
not, repeat, not waste any more time on this issue.

Ciao,
Dscho
