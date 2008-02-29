From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] path-list: add functions to work with unsorted
 lists
Date: Fri, 29 Feb 2008 02:15:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290214150.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 03:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUunL-0001I2-9o
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 03:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbYB2CPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYB2CPm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 21:15:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:56525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753241AbYB2CPl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 21:15:41 -0500
Received: (qmail invoked by alias); 29 Feb 2008 02:15:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp031) with SMTP; 29 Feb 2008 03:15:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M968DG3oM/xDp4mR1b1ri+rOqeh8RXFcqCok0R7
	Y9o+RVvxHQEscp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprugfrgw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75497>

Hi,

On Thu, 28 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	This is probably useful to a number of existing non-users of
> > 	path_list.
> 
> I suspect most of the non-users will stay non-users, until the
> thing is renamed to something more sensible.
> 
> The wholesale renaming, if we were to do so, should happen when things 
> are quiet, and this is probably not a good time for it.

Right.  Will try to think of a patch when the right time has come.  Just 
to make sure: "string_list"?

Ciao,
Dscho

