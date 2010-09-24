From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Fri, 24 Sep 2010 02:32:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1009240230420.4461@bonsai2>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com> <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 02:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OywD6-0004Qw-D5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 02:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab0IXAcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 20:32:15 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:41993 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753032Ab0IXAcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 20:32:14 -0400
Received: (qmail invoked by alias); 24 Sep 2010 00:32:12 -0000
Received: from pD9EB2339.dip0.t-ipconnect.de (EHLO noname) [217.235.35.57]
  by mail.gmx.net (mp045) with SMTP; 24 Sep 2010 02:32:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18E4GYE278ESFWiWD8ka/w9ft8BMkbaSTZy/QmdEw
	xuwxSv0d2jz5T/
X-X-Sender: gene099@bonsai2
In-Reply-To: <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156927>

Hi,

On Thu, 23 Sep 2010, Erik Faye-Lund wrote:

> The code in mingw_open was introduced in commit 3e4a1ba (by Johannes 
> Sixt), and the lack of a NULL-check looks like a simple oversight.

Erik, you have all the information at your finger tips. So why not Cc: 
Johannes Sixt, who you blame so openly, so that he has a chance to react 
(and less of a chance to miss your criticism)?

Ciao,
Dscho
