From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 14:02:48 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231401340.4353@racer.site>
References: <47E64F71.3020204@jwatt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Watt <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdPs4-0006HL-0K
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759762AbYCWNDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761860AbYCWNDj
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:03:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:42028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759717AbYCWNDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:03:38 -0400
Received: (qmail invoked by alias); 23 Mar 2008 13:03:02 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp040) with SMTP; 23 Mar 2008 14:03:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188G+k5Ha08Jy+JpIflbXQDdoEiMN4bH/P8QYP4f/
	lZpdZYy/EQ/ver
X-X-Sender: gene099@racer.site
In-Reply-To: <47E64F71.3020204@jwatt.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77887>

Hi,

On Sun, 23 Mar 2008, Jonathan Watt wrote:

> There seems to be a problem with git-push when the working copy of the 
> directory being pushed to came from the magic revision HEAD, but not 
> when the working copy came from some other revision.

http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

Sidenote: I am constantly amazed how people have no problem accepting that 
a CVS-Server has no working directory, but all of a sudden think that a 
Git-server should have one, and auto-update it.

Ciao,
Dscho
