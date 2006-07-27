From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: imitate git-update-ref when committing
Date: Thu, 27 Jul 2006 10:53:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271052070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607262249010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060727002130.GA32492@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 10:53:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G61cM-0003Z5-2k
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 10:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWG0IxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWG0IxN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 04:53:13 -0400
Received: from mail.gmx.net ([213.165.64.21]:35456 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932342AbWG0IxN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 04:53:13 -0400
Received: (qmail invoked by alias); 27 Jul 2006 08:53:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 27 Jul 2006 10:53:11 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060727002130.GA32492@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24270>

Hi,

On Wed, 26 Jul 2006, Shawn Pearce wrote:

> You might want to also consider appending to the reflog, if it exists/is 
> enabled.

Given that I do not use it, and do not really understand what it does, 
this would be a bad idea ;-)

Ciao,
Dscho

P.S.: How's your Java thing coming along?
