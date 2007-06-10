From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] filter-branch: Simplify parent computation.
Date: Sun, 10 Jun 2007 08:14:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100813400.4059@racer.site>
References: <200706082328.39758.johannes.sixt@telecom.at>
 <7vmyz8eu3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHgJ-0003pB-1A
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760604AbXFJHRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760707AbXFJHRp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:17:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:38466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760523AbXFJHRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:17:45 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:17:43 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp009) with SMTP; 10 Jun 2007 09:17:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192tTwhoh922VRc5zXVnNoB2mRvzf5K4qFUmUAMQ1
	qcPIEsm9YGtspE
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyz8eu3y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49659>

Hi,

On Sat, 9 Jun 2007, Junio C Hamano wrote:

> Anyway, I've manually fixed up the offending three patches (two from you 
> and one from the other Johannes) and pushed the results out on 'next'.

Sorry. I guess we were just beaming patches back and forth, applying them 
in our local repos, and working from there.

I promise to try better.

Ciao,
Dscho
