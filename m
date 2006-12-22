From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 13:14:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221312540.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:14:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjHy-0005Re-Fo
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbWLVMOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWLVMOI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:14:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:47818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422881AbWLVMOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:14:07 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:14:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 22 Dec 2006 13:14:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35165>

Hi,

On Thu, 21 Dec 2006, Junio C Hamano wrote:

> (1) Why is this needed?

It was asked recently. It also serves well when you want to show the 
index.

> (2) What does this do when the index is unmerged?

I have no idea, and ATM no time to test. Will do later.

Ciao,
Dscho
