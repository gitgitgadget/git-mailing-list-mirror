From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Feature request - Subtree checkouts
Date: Sat, 14 Apr 2007 10:59:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704141039270.18846@racer.site>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 11:00:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hce7U-0004Oh-FY
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 11:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbXDNJA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 05:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbXDNJA3
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 05:00:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:53567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753812AbXDNJA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 05:00:28 -0400
Received: (qmail invoked by alias); 14 Apr 2007 09:00:25 -0000
Received: from mail.superfast.com (EHLO [10.0.0.38]) [194.30.223.1]
  by mail.gmx.net (mp052) with SMTP; 14 Apr 2007 11:00:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/S1zov3NjS9+8pe6JMKwjPrig4i0qn6/1JrIrfVd
	vO6qjViEOFNkDk
X-X-Sender: gene099@racer.site
In-Reply-To: <20070410074444.GA18541@curie-int.orbis-terrarum.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44453>

Hi,

On Tue, 10 Apr 2007, Robin H. Johnson wrote:

> Since shallow checkouts are now available, there's just one more thing 
> that's missing: subtree checkouts. Not to be confused with sub-projects.

It should not be _that_ difficult. If I'm correct, it should touch exactly 
the same code as the commit v1.3.0~263^2~6 ("Assume unchanged" git).

ATM I have no time to do anything about it, so feel free to give it a try.

Ciao,
Dscho
