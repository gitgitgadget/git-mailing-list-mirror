From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge-ff: fast-forward only merge
Date: Sat, 30 Jun 2007 15:28:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706301523210.4438@racer.site>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 16:28:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4dwS-0003xZ-FE
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 16:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854AbXF3O2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 10:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755357AbXF3O2Y
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 10:28:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:48503 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756793AbXF3O2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 10:28:23 -0400
Received: (qmail invoked by alias); 30 Jun 2007 14:28:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 30 Jun 2007 16:28:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++GRhv6Lm+waseT3mXDPFX8PiMVWixZ7qncrTrIu
	3wCfLA3nCP+HXZ
X-X-Sender: gene099@racer.site
In-Reply-To: <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51217>

Hi,

On Sat, 30 Jun 2007, Sam Vilain wrote:

>  Documentation/merge-strategies.txt |    5 +++++
>  Makefile                           |    2 +-
>  git-merge-ff.sh                    |    8 ++++++++
>  git-merge.sh                       |    4 ++--

Still no test script that could tell you if it does what it is supposed to 
be...

Ciao,
Dscho
