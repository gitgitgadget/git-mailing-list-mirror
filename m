From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 00:48:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 19 00:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT570-0007R1-SE
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 00:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933408AbXCRXs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 19:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933452AbXCRXs3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 19:48:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:55955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933408AbXCRXs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 19:48:28 -0400
Received: (qmail invoked by alias); 18 Mar 2007 23:48:27 -0000
X-Provags-ID: V01U2FsdGVkX18wsjFGZiYwfhLoGTprBtDaMuAdWl4opKSymjWgIl
	BMxpyS9BtVro2a
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070318140816.GG4489@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42543>

Hi,

On Sun, 18 Mar 2007, Petr Baudis wrote:

> [...] if you look at the UNIX history, you'll notice that first people 
> started with non-reentrant stuff because it was "good enough" and then 
> came back later and added reentrant versions anyway. Let's learn from 
> history. It's question of probability but it's very likely this will 
> happen to us as well.

Yes, let's learn from history. Start with a libgit that is good enough. 
And when somebody actually needs it to behave a little differently, or 
more sophisticated, then let that somebody work on it!

Ciao,
Dscho
