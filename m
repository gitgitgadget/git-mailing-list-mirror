From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Fix a "pointer type missmatch" warning.
Date: Sat, 3 Mar 2007 19:41:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031941240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E9BE6F.9090400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZAz-0004dr-Pc
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbXCCSlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbXCCSlq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:41:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:39622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030371AbXCCSlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 13:41:45 -0500
Received: (qmail invoked by alias); 03 Mar 2007 18:41:44 -0000
X-Provags-ID: V01U2FsdGVkX18ak1s+Z0YaLzOrDhl0FgQGtHEo7J41YeqxecrRCP
	9XbXbJ1Zpd/w5P
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E9BE6F.9090400@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41314>

Hi,

On Sat, 3 Mar 2007, Ramsay Jones wrote:

> Note: set OLD_ICONV in your config.mak file on Cygwin.

Shouldn't you set it in Makefile instead?

Ciao,
Dscho
