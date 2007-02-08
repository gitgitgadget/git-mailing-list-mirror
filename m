From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Thu, 8 Feb 2007 01:07:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080106200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070207201511.GF12140@mellanox.co.il> <7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702080049330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqdos9$4up$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwop-0002m7-QW
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbXBHAHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161482AbXBHAHQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:07:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:38981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161494AbXBHAHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:07:15 -0500
Received: (qmail invoked by alias); 08 Feb 2007 00:07:14 -0000
X-Provags-ID: V01U2FsdGVkX1+paPhQuZqpQMYMZ5s6YqbxTCxS26gZfe+dFzvN8p
	dsnw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eqdos9$4up$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39011>

Hi,

[please Cc me when replying]

On Thu, 8 Feb 2007, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Wed, 7 Feb 2007, Junio C Hamano wrote:
> > 
> >>  - we will be keeping applymbox after all.
> > 
> > Why? Does -am not do strictly more than applymbox?
> 
> From documentation, it looks like applymbox can get signoff from a file, 
> and am not.

Seems like just another low-hanging fruit. But I cannot believe that this 
is the only reason to keep applymbox.

Ciao,
Dscho
