From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Sun, 11 Mar 2007 20:08:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112008020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87d53fsjiz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 20:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQTPX-00052T-1A
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 20:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934007AbXCKTIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934009AbXCKTIs
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 15:08:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:49145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934007AbXCKTIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 15:08:47 -0400
Received: (qmail invoked by alias); 11 Mar 2007 19:08:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 11 Mar 2007 20:08:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LMZw7gCiL7e2XrHP7LKEXQm/KMAb+lWTrG2U6hV
	vupBi4BFF08K3C
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87d53fsjiz.fsf@rho.meyering.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41963>

Hi,

On Sun, 11 Mar 2007, Jim Meyering wrote:

> I like the idea of the new ':/<oneline prefix>' notation, and gave it a 
> try, but all I could get was a segfault.

Thanks. I did not realize that it did not work correctly, since the pager 
hid the segfault.

Ciao,
Dscho
