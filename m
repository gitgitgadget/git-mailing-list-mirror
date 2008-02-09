From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: All I wanted was git-fast-export
Date: Sat, 9 Feb 2008 18:04:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091803580.11591@racer.site>
References: <47ADE275.3060109@glidos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 19:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNu4I-0005kf-CS
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 19:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbYBISEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 13:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYBISEQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 13:04:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:38953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754229AbYBISEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 13:04:15 -0500
Received: (qmail invoked by alias); 09 Feb 2008 18:04:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 09 Feb 2008 19:04:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PYnVlq/JP2qJNgKBBjBvd+fVS8+McrpenFYQTLj
	IBbQA1SeIcM5UQ
X-X-Sender: gene099@racer.site
In-Reply-To: <47ADE275.3060109@glidos.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73251>

Hi,

On Sat, 9 Feb 2008, Paul Gardiner wrote:

> With your kind help, I've been able to convert a cvs repository
> to git, but the last several years commits start with a line
> saying "Summary;" :-(  I thought it might not be hard to put
> a filter between git-fast-export and git-fast-import to sort
> it out.

The better tool for this should be filter-branch.

Hth,
Dscho
