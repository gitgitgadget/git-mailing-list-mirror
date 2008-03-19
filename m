From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-remote: Fix missing newline at end of listing
 of pushed branches
Date: Wed, 19 Mar 2008 21:43:04 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803192142440.3983@racer.site>
References: <200803182152.00187.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5E7-000683-Hf
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbYCSUnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761602AbYCSUnI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:43:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:58016 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757188AbYCSUnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:43:05 -0400
Received: (qmail invoked by alias); 19 Mar 2008 20:43:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 19 Mar 2008 21:43:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18joipfLSkjCpygAtqw5v4UmXfcrHKiNx3oZZav8Q
	4gsCMyhEKqIZyR
X-X-Sender: gene099@racer.site
In-Reply-To: <200803182152.00187.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77540>

Hi,

On Tue, 18 Mar 2008, Johannes Sixt wrote:

> Without this the output of 'git remote show' does not end with a new-line:
> 
> bash> git remote show repo
> * remote repo
>   URL: repo.or.cz:/srv/git/kdbg.git
>   Tracked remote branches
>     maint master mob
>   Local branch pushed with 'git push'
>     +master:masterbash>

Obviously Acked-by: me.

Sorry & Thanks,
Dscho
