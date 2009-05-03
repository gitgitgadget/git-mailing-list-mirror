From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 3 May 2009 16:30:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905031629290.18521@pacific.mpi-cbg.de>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	markus.heidelberg@web.de, git@vger.kernel.org,
	charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 16:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0chq-0004i9-Gu
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 16:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZECOaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbZECOaG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 10:30:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:51162 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753145AbZECOaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 10:30:05 -0400
Received: (qmail invoked by alias); 03 May 2009 14:30:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 03 May 2009 16:30:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19AD2dnO/ZAdymF6XxM78X6EwPD1KRoLu/waLG0dt
	R/ZaXsJVDk9wXC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1241313481-17923-1-git-send-email-davvid@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118177>

Hi,

On Sat, 2 May 2009, David Aguilar wrote:

> Araxis merge is now a built-in diff/merge tool.
> This adds araxis to git-completion and updates
> the documentation as well.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> This patch is a result of the discussion on the msysgit list:
> 
> http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7
> 
> 'compare' is the command-line utility that is provided
> on MacOS.  Users on other platforms may have to manually
> set their mergetool.araxis.path.

The only reason I did not merge that patch sent to msysgit@googlegroups 
was that I did not have _any_ confirmation that it works.

Do you have any?  As Araxis is not free software, I refuse to touch it.

Ciao,
Dscho
