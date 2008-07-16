From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsexportcommit keyword mismatch issue
Date: Wed, 16 Jul 2008 12:31:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807161229460.8503@eeepc-johanness>
References: <E1KJ30U-0004EL-BV@corti>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Barak A. Pearlmutter" <barak@cs.nuim.ie>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4IG-0007eJ-1M
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbYGPKad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755185AbYGPKad
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:30:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:45616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754065AbYGPKad (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:30:33 -0400
Received: (qmail invoked by alias); 16 Jul 2008 10:30:31 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp002) with SMTP; 16 Jul 2008 12:30:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/tdwSksk/RVH6pjS+8QvY0ECEh7GUv0uUYy3+tL
	yzKSsMRHrUE3gc
X-X-Sender: user@eeepc-johanness
In-Reply-To: <E1KJ30U-0004EL-BV@corti>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88657>

Hi,

On Wed, 16 Jul 2008, Barak A. Pearlmutter wrote:

> So what I'm hoping is that this lengthy discourse of mine will convince 
> someone to add code to git-cvsexportcommit that causes the patch 
> creation and application stuff inside it to ignore keyword expansion 
> mismatches (on files which do not have -kb on in CVS), perhaps by simply 
> contracting keywords on all files/patches from both CVS/git at an early 
> stage.

I doubt that this is going to happen.  Obviously, it has been nonbody's 
itch _enough_ to scratch it.

I see your problem, but unless you start hacking, I do not see it being 
solved anytime soon.

Ciao,
Dscho
