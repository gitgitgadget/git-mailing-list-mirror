From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] object name: introduce ':::<oneline prefix>' notation
Date: Sat, 24 Feb 2007 02:49:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240248210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702231930290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0702232347310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224011214.GA8369@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702240220300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070224013015.GA9021@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKm2Z-0001Pd-Na
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbXBXBtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933325AbXBXBtd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:49:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:55343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932759AbXBXBtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:49:32 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:49:31 -0000
X-Provags-ID: V01U2FsdGVkX19044xkxmF0y9DuDGYDhlQVwQ87tYIdRmJmMf91Hx
	wg3g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070224013015.GA9021@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40487>

Hi,

On Fri, 23 Feb 2007, Jeff King wrote:

> I think :/ is slightly easier on the eyes than :::. Plus it opens the 
> door for :? to find the oldest such match (though I'm not sure if it 
> would be by topology or date).

By topology makes no sense with more than one root.

> Of course it's starting to look a bit like line noise...maybe we just 
> need :-/ and :-).

That was also a suggestion in IRC :-)

Ciao,
Dscho
