From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Tue, 4 Mar 2008 14:09:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041409070.22527@racer.site>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWXqw-0004KH-1u
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbYCDOKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYCDOKH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:10:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:48275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751377AbYCDOKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:10:06 -0500
Received: (qmail invoked by alias); 04 Mar 2008 14:10:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 04 Mar 2008 15:10:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LhZBbS5pLTW5hK1vQn0zzjb78TAA5hVyN04LGLR
	0JV7Ma1jhPfZZR
X-X-Sender: gene099@racer.site
In-Reply-To: <200803041459.29000.michal.rokos@nextsoft.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76086>

Hi,

On Tue, 4 Mar 2008, Michal Rokos wrote:

> This PATCH is NOT intended to be merged (yet).

See also

http://article.gmane.org/gmane.comp.version-control.git/75280/match=vsnprintf

Ciao,
Dscho
