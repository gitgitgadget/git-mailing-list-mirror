From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 21:42:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804062135290.12583@eeepc-johanness>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 22:43:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jibhn-0006Bp-89
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 22:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbYDFUm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 16:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYDFUm1
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 16:42:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:57466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730AbYDFUm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 16:42:27 -0400
Received: (qmail invoked by alias); 06 Apr 2008 20:42:24 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO eeepc-johanness.home) [86.165.92.90]
  by mail.gmx.net (mp041) with SMTP; 06 Apr 2008 22:42:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U+HIZT12UxKKTZ5EIJbAvYiTAv5DPG6a/UMDcuQ
	y1sG0s6W6rwcJY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78923>

Hi,

On Sun, 6 Apr 2008, Adam Simpkins wrote:

> I do like the fact that git-forest prints the names of the refs that 
> point to each commit.  For the graphing API, we could perhaps add a "%r" 
> specifier to --pretty=format to print the refs pointing to the commit.

Would "--decorate" help?

Ciao,
Dscho
