From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Fri, 26 Jan 2007 00:46:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701260045580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701231101040.3011@xanadu.home> <7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:46:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEIZ-0005nz-97
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXAYXq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbXAYXq2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:46:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:51988 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030501AbXAYXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:46:27 -0500
Received: (qmail invoked by alias); 25 Jan 2007 23:46:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 26 Jan 2007 00:46:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37783>

Hi,

On Thu, 25 Jan 2007, Junio C Hamano wrote:

> > Why do you need setup_ident()?
> 
> Because presumably you would be updating the reflog that records
> who did the fetch?

Ah yes, that makes sense!

Thank you,
Dscho
