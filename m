From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 40/40] compat/pread.c: Add foward decl to fix warning
Date: Thu, 28 Feb 2008 15:51:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281551110.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-41-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:52:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUl3u-0001wp-0t
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421AbYB1PwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757629AbYB1PwH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:52:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:34103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756103AbYB1PwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:52:05 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:52:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 28 Feb 2008 16:52:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HFUoI08PHNeoNY3nGRVG8NcPAdnHb0doOWHDAYy
	78PxRlHGZapqFl
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-41-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75414>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> +   This function in used in compat/pread.c.  But we can't include

s/ in / is /

Thanks,
Dscho

