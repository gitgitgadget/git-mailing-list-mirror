From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 11:18:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
References: <200807231544.23472.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:18:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLaUE-0004n4-He
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbYGWJRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYGWJRT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:17:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:54962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbYGWJRS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:17:18 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:17:16 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp061) with SMTP; 23 Jul 2008 11:17:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VWJ5Gq26VtBHUu4XhdWvO5lmtU/91cHJ+00/tqm
	RnVyV7aUyMXPKz
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807231544.23472.litvinov2004@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89616>

Hi,

On Wed, 23 Jul 2008, Alexander Litvinov wrote:

> In short: I can't clone svn repo into git when crlf convertion is 
> activated.

This is a known issue, but since nobody with that itch seems to care 
enough to fix it, I doubt it will ever be fixed.

Ciao,
Dscho
