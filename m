From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 13:11:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131310290.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <7vr6ogh2w7.fsf@assigned-by-dhcp.pobox.com> <Pine.LNX.4.64.0706131214010.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:14:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRkK-0008CC-Rp
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbXFMMOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbXFMMOk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:14:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:60056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756591AbXFMMOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:14:39 -0400
Received: (qmail invoked by alias); 13 Jun 2007 12:14:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 13 Jun 2007 14:14:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XpNEl5RVX1PzQWHWx1XxGPRMDSjWFBCXnn8UBTf
	HRjBmQpGZt8mJa
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0706131214010.4059@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50051>

Hi,

I don't know what happened to my subject in the mail I'm replying to... 
Sorry.

Ciao,
Dscho
