From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor glitch in git-gui: changes to global options aren't taken
 into account immediately
Date: Tue, 6 Nov 2007 03:19:49 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711060319140.4362@racer.site>
References: <93FD01F4-71F8-4025-BA7F-A642E2B7CAD6@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Nov 06 04:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpEzn-0006W4-RI
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 04:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbXKFDUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 22:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbXKFDUm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 22:20:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:56761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754008AbXKFDUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 22:20:41 -0500
Received: (qmail invoked by alias); 06 Nov 2007 03:20:40 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp018) with SMTP; 06 Nov 2007 04:20:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zRQdBB6nzTccx17ujh7x1rAlrZlEZ7OXzTJZg0t
	R5Rt7MHWKxiCk2
X-X-Sender: gene099@racer.site
In-Reply-To: <93FD01F4-71F8-4025-BA7F-A642E2B7CAD6@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63618>

Hi,

On Tue, 6 Nov 2007, Benoit SIGOURE wrote:

> I've just realized that git-gui wasn't only using 3 lines of context in the
> diffs so I changed the setting under the menu Wish>Options... under the
> section `Global'.  I had to restart git-gui so that the new setting is taken
> into account.

Would not clicking on another file have done the trick, too?

Ciao,
Dscho
