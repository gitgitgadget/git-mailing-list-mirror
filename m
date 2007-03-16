From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 00:26:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703170025100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161145520.5518@xanadu.home>
 <Pine.LNX.4.63.0703161710400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 00:26:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLoW-0000Qx-Aw
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 00:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbXCPX0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 19:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXCPX0V
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 19:26:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:41453 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753275AbXCPX0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 19:26:20 -0400
Received: (qmail invoked by alias); 16 Mar 2007 23:26:18 -0000
X-Provags-ID: V01U2FsdGVkX1/elMRRwT/e6LOcKif2IgHer3dD+mnI1slBIJHMan
	F97f/mwJRZOyyZ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LFD.0.83.0703161218140.5518@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42409>

Hi,

On Fri, 16 Mar 2007, Nicolas Pitre wrote:

> [...] the output from an executable is a damn good abstraction and the 
> executable itself is an impenetrable boundary.  Anything can change (and 
> did change) underneath.
> 
> This is why a public API must be done at a higher level to allow for 
> anything to change at the lower level as we wish.

Absolutely.

Ciao,
Dscho
