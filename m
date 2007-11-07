From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 23:11:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072309380.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site>
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 00:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipu4K-0003fH-Ji
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 00:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758560AbXKGXLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757712AbXKGXLa
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 18:11:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:35957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757285AbXKGXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 18:11:30 -0500
Received: (qmail invoked by alias); 07 Nov 2007 23:11:28 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp024) with SMTP; 08 Nov 2007 00:11:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vqldofzyvJiA14ftvhi48BDW9JraZ3YPvyvHBeL
	uDyE3y9tBONFB3
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63889>

Hi,

On Wed, 7 Nov 2007, Jon Smirl wrote:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > We also tend to take the approach of viewing the history as that of 
> > the whole project.
> 
> But if you type 'git log' while cd'd into a subdirectory the whole log 
> is almost never what you want. It's this kind of thing that makes git 
> harder to use.

When I am working in a subdirectory, I often want the whole history.  For 
example, when I am working on the documentation, sometimes I need to look 
up a commit real quick, that touched other parts.

Besides, adding a space and a dot is not what qualifies for "harder to 
use" with this developer.

Ciao,
Dscho
