From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use standard -t option for touch.
Date: Thu, 18 Jan 2007 11:49:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181147500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070118102814.0C32FA914@diphong.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 11:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7UpW-00042a-8P
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 11:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXARKtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 05:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbXARKtM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 05:49:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:53978 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751990AbXARKtL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 05:49:11 -0500
Received: (qmail invoked by alias); 18 Jan 2007 10:49:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 18 Jan 2007 11:49:10 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
In-Reply-To: <20070118102814.0C32FA914@diphong.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37077>

Hi,

Simon, please don't use "undisclosed recipients". After all, this is 
_open_ source, and you make it really inconvenient to reply.

On Thu, 18 Jan 2007, Simon 'corecode' Schubert wrote:

> Non-GNU touch do not have the -d option to take free form
> date strings.  The POSIX -t option should be more widespread.
> For this to work, date needs to output YYYYMMDDHHMM.SS date strings.

I just checked on an SGI machine, and it has "-t". In related news, it 
also has /usr/bin/printf.

Ciao,
Dscho
