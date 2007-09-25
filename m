From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move convert-objects to contrib.
Date: Tue, 25 Sep 2007 11:01:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251100560.28395@racer.site>
References: <1190690061-6720-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7G4-0000vv-UG
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXIYKDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbXIYKDF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:03:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:33322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751670AbXIYKDC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:03:02 -0400
Received: (qmail invoked by alias); 25 Sep 2007 10:03:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 25 Sep 2007 12:03:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lQ9ZPeLYl6we2hkHt7htOSdqhOGEwBataOO6qj2
	SwOB8gQWu5ujMO
X-X-Sender: gene099@racer.site
In-Reply-To: <1190690061-6720-1-git-send-email-kraai@ftbfs.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59106>

Hi,

the commit message looks a little bit empty to me.  I'd at least mention 
why convert-objects was needed, why it is no longer needed, and that 
Linus, the original author, is okay with it.

And you might want to use the "-M" flag to format-patch next time (detect 
renames).

Ciao,
Dscho
