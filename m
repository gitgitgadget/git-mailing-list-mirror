From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Fri, 8 Jun 2007 22:51:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706082249040.4059@racer.site>
References: <1181338730800-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-621654847-1181339475=:4059"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwmPv-00077Y-4O
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938078AbXFHVyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937752AbXFHVyd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:56525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933269AbXFHVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:54:32 -0400
Received: (qmail invoked by alias); 08 Jun 2007 21:54:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 08 Jun 2007 23:54:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yp88wekbyOybSfbNH6BjHuWDxFGMVCrp6KMKbyK
	36S8mTUs8kEPJO
X-X-Sender: gene099@racer.site
In-Reply-To: <1181338730800-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49508>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-621654847-1181339475=:4059
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Jun 2007, Kristian Høgsberg wrote:

> A more or less straight-forward port of git-tag.sh to C.

It is somewhat unfortunate that you did not say that you were working on 
this stuff; we have a Google Summer of Code project going on, which tries 
to port many scripts to builtins.

As it happens, I am working with jasam on exactly the same script.

Pity,
Dscho

--8323584-621654847-1181339475=:4059--
