From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Sat, 14 Apr 2007 10:56:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704141019290.18655@racer.site>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hce4R-0003Rg-F1
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 10:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618AbXDNI5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 04:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXDNI5T
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 04:57:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:32947 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753618AbXDNI5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 04:57:18 -0400
Received: (qmail invoked by alias); 14 Apr 2007 08:57:15 -0000
Received: from mail.superfast.com (EHLO [10.0.0.38]) [194.30.223.1]
  by mail.gmx.net (mp046) with SMTP; 14 Apr 2007 10:57:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AGlgchsqAmuLMnVeOkBlaHZsalKlvBJa0YOP2vS
	mZ7oWt+wP9/RVV
X-X-Sender: gene099@racer.site
In-Reply-To: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44451>

Hi,

On Wed, 11 Apr 2007, Robin H. Johnson wrote:

> I was doing some random tests with shallow trees, and ran into two 
> issues - the first is a shallow tree that doesn't extend anymore when it 
> should, and the second is some branched shallow tree trouble.

Ah! Seems we finally have a user for shallow clones! ;-)

Seriously again: I am at fault for putting the shallow support into Git, 
failing to provide sensible test cases. This was partly due to my 
laziness, and partly due to the overwhelming lack of demand.

I am in the middle of moving (haven't reached my destination yet), so I 
will take a couple more days until I can look into your problems. If you 
find out in the meantime what is happening, please share the information 
with us.

Ciao,
Dscho
