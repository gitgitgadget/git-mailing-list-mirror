From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add committer and author names to top of
 COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 21:26:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801112124520.31053@racer.site>
References: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Sinclair <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRPO-0007MQ-Ut
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758226AbYAKV0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759369AbYAKV0z
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:26:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:44883 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617AbYAKV0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:26:55 -0500
Received: (qmail invoked by alias); 11 Jan 2008 21:26:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 11 Jan 2008 22:26:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XozQEYDMXc8EBcV6Rw4Bwat2tbBvvAlBToZvEGJ
	j5k+wR2hb5YmFF
X-X-Sender: gene099@racer.site
In-Reply-To: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70208>

Hi,

On Fri, 11 Jan 2008, Stephen Sinclair wrote:

> Add committer and author names to top of COMMIT_EDITMSG.

This commit message is severely lacking: it is just a repetition of the 
commit subject, it is too technical (what is COMMIT_EDITMSG for, 
anyway?), and even worse, it does not begin to explain _why_ this is a 
good change.

Ciao,
Dscho
