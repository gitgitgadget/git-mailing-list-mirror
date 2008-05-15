From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use '-f' option to point to the .gitmodules file
Date: Thu, 15 May 2008 09:56:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805150956050.30431@racer>
References: <1210837378-25668-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu May 15 10:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZHA-0003OD-4h
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 10:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYEOI4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 04:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbYEOI4S
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 04:56:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:37721 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751613AbYEOI4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 04:56:18 -0400
Received: (qmail invoked by alias); 15 May 2008 08:56:16 -0000
Received: from R33f0.r.pppool.de (EHLO racer.local) [89.54.51.240]
  by mail.gmx.net (mp004) with SMTP; 15 May 2008 10:56:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lTrhTT6YlYu094pD8fdPorGXyvufnFrbjW2AmdU
	+sCSKS0wECH6XY
X-X-Sender: gene099@racer
In-Reply-To: <1210837378-25668-1-git-send-email-imyousuf@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82190>

Hi,

On Thu, 15 May 2008, imyousuf@gmail.com wrote:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> 
> 'git config' has a '-f' option that takes the file to parse.
> Using it rather than the environment variable seems more logical
> and simplified.

Definitely looks more readable.

Ciao,
Dscho
