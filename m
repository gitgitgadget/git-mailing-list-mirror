From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 15:23:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807251519290.11976@eeepc-johanness>
References: <4889B66D.4020306@keyaccess.nl> <4889B912.9040006@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Herman <rene.herman@keyaccess.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:23:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMNGx-0004pe-2C
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYGYNWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 09:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYGYNWs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:22:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:40585 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752414AbYGYNWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:22:47 -0400
Received: (qmail invoked by alias); 25 Jul 2008 13:22:45 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp013) with SMTP; 25 Jul 2008 15:22:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190f5h8iPd0/+5oHNOXB3NCj0fPhzJC69BWx1v+7m
	TPF7LcbKnoTk69
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4889B912.9040006@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90048>

Hi,

On Fri, 25 Jul 2008, Johannes Sixt wrote:

>   comm -13 <(git diff --name-only your-rev-here) <(git ls-files)

Thanks.  I learnt two new things from that: comm (funnily, I did not know 
that tool), and <() (looks almost like a puffin, doesn't it?).

But should it not be -12?

Ciao,
Dscho
