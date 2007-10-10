From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [FEATURE REQUEST] git clone, just clone selected branches?
Date: Wed, 10 Oct 2007 22:56:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102254340.4174@racer.site>
References: <011b01c80b84$222d1e70$04ac10ac@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjYM-0005zu-3x
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbXJJV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755568AbXJJV4v
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:56:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:36671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755439AbXJJV4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:56:50 -0400
Received: (qmail invoked by alias); 10 Oct 2007 21:56:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 10 Oct 2007 23:56:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XzlFS/2pXFl8L+N/eUvz0w33ySdULT0WXmUlQG2
	86cfVsFa3ykvVS
X-X-Sender: gene099@racer.site
In-Reply-To: <011b01c80b84$222d1e70$04ac10ac@Jocke>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60558>

Hi,

On Wed, 10 Oct 2007, Joakim Tjernlund wrote:

> I should know better than to throw out ideas like this. Next time I have 
> an suggestion I will think long and hard about it before posting again.

Hey, it was just a try.

Personally, I am not interested in the feature _you_ asked for, but I 
thought it might be pretty easy for you to rewrite git-clone.sh to take 
advantage of git-fetch and git-remote, and that your desired feature would 
be easier to add then.  So easy that the whole thing would have taken you 
all of an hour or so.

But maybe somebody else is interested enough to scratch your itch.

Ciao,
Dscho
