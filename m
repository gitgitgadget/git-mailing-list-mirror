From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 02:32:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706190232550.4059@racer.site>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
 <Pine.LNX.4.64.0706190151160.4059@racer.site> <20070619011734.GD19725@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 03:33:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Saq-0004gl-Mi
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 03:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757653AbXFSBdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 21:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754242AbXFSBdG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 21:33:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:59030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757341AbXFSBdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 21:33:06 -0400
Received: (qmail invoked by alias); 19 Jun 2007 01:33:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 19 Jun 2007 03:33:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PBuwiur3PEvpzc9rjciji964ekQoPvXbbODsrhK
	xz9PMgSajjakzO
X-X-Sender: gene099@racer.site
In-Reply-To: <20070619011734.GD19725@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50437>

Hi,

On Tue, 19 Jun 2007, Frank Lichtenheld wrote:

> Instead we output something like
> 
> core.some\nwhere\0core.over\0core.the\ncore.rainbow\0

Ah, I missed that. Maybe because I expected "--null" not to be 
"--newline-and-null" ;-)

Ciao,
Dscho
