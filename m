From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: fix "cvs diff" in a subdirectory
Date: Wed, 11 Oct 2006 10:17:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610111017400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610110032560.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslhvy8bo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 11 10:18:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXZHp-0001Lp-6x
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 10:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJKIRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWJKIRy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 04:17:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:22217 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161026AbWJKIRx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 04:17:53 -0400
Received: (qmail invoked by alias); 11 Oct 2006 08:17:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 11 Oct 2006 10:17:51 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslhvy8bo.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28703>

Hi,

On Tue, 10 Oct 2006, Junio C Hamano wrote:

> Will park this and the "U for update, M for modified" patch in
> "pu", waiting for acks from actual git-cvsserver users.  It
> feels it is safe enough change, so with an Ack from Mart[yi]n
> it may be woth having it in 1.4.3

Thanks.

Ciao,
Dscho
