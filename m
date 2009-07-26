From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: en/fast-export, was Re: What's cooking in git.git (Jul 2009, #02;
 Sun, 26)
Date: Sun, 26 Jul 2009 12:32:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907261231070.8306@pacific.mpi-cbg.de>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV11j-0001Vf-71
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbZGZKcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZGZKcK
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:32:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:55340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753383AbZGZKcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:32:09 -0400
Received: (qmail invoked by alias); 26 Jul 2009 10:32:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 26 Jul 2009 12:32:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FR0cNp+5FeyYxMtyj1p5Zu4tYbIpAKDprP0NIOf
	dDof+TnPPe6XWU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124119>

Hi,

On Sun, 26 Jul 2009, Junio C Hamano wrote:

> * en/fast-export (Thu Jun 25 22:48:33 2009 -0600) 7 commits
>  + fast-export: Document the fact that git-rev-list arguments are
>    accepted
>  + Add new fast-export testcases
>  + fast-export: Add a --tag-of-filtered-object option for newly
>    dangling tags
>  + fast-export: Do parent rewriting to avoid dropping relevant
>    commits
>  + fast-export: Make sure we show actual ref names instead of
>    "(null)"
>  + fast-export: Omit tags that tag trees
>  + fast-export: Set revs.topo_order before calling setup_revisions
> 
> Shawn?  Dscho?

I think that those changes are good, even for 1.6.4.

Ciao,
Dscho
