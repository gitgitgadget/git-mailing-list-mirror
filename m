From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: EGIT, was Re: [PATCH] Fix nullpointer exceptions in Quickdiff
Date: Fri, 11 Jul 2008 22:50:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112249010.8950@racer>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com> <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com> <200807112334.47552.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQWF-0000Zc-8A
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbYGKVuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755520AbYGKVuK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:50:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754928AbYGKVuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:50:08 -0400
Received: (qmail invoked by alias); 11 Jul 2008 21:50:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp041) with SMTP; 11 Jul 2008 23:50:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oWr1+RW3oKk8eMwbdTR7P+i3nZO2RtgRkrFDF9R
	YyThkLvwXoYLtk
X-X-Sender: gene099@racer
In-Reply-To: <200807112334.47552.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88182>

Hi Andreas,

On Fri, 11 Jul 2008, Robin Rosenberg wrote:

> 
> --- 
> I saw some problem when resources were no longer in the worspace, such as during a bisectg. 
> This one should probably just be squashed into patch 1.

This patch is for egit, before you ask.

But be prepared for a lot of unmarked Windows discussion, somebody wants 
to shift msysGit's mail list payload to git@vger ;-)

Ciao,
Dscho
