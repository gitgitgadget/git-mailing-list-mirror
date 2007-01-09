From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Tue, 9 Jan 2007 15:08:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091505500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147452362.2794.452.camel@pmac.infradead.org>
 <1168351405.14763.347.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dave Jones <davej@redhat.com>,
	Junio C Hamano <junkio@cox.net>, chrisw@redhat.com
X-From: git-owner@vger.kernel.org Tue Jan 09 15:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4HeB-0004sk-8L
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbXAIOIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 09:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXAIOIL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:08:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:56718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932106AbXAIOIK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 09:08:10 -0500
Received: (qmail invoked by alias); 09 Jan 2007 14:08:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 09 Jan 2007 15:08:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1168351405.14763.347.camel@shinybook.infradead.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36361>

Hi,

On Tue, 9 Jan 2007, David Woodhouse wrote:

in the Documentation,

>  -u::

needs to be replaced by "-n::", and

> +	If the i18n.commitencoding configuration option is set
> +	set incorrectly (or unset when the UTF-8 default is not

needs only one "set", not two.

Ciao,
Dscho
