From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 13:45:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702051344160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 13:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE3Dk-0004rr-SM
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 13:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbXBEMpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 07:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbXBEMpR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 07:45:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:57794 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932289AbXBEMpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 07:45:16 -0500
Received: (qmail invoked by alias); 05 Feb 2007 12:45:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 05 Feb 2007 13:45:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38750>

Hi,

On Sun, 4 Feb 2007, Junio C Hamano wrote:

> * git-whatchanged
> 
>   This has been identical to git-log with different default
>   options.

Would it really be so bad if we just kept this alias indefinitely? We can 
stop advertising it, but it is not expensive to carry that small part of 
the code around.

Same goes for repo-config, fsck-objects, init-db.

Ciao,
Dscho
