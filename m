From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tags and patches
Date: Wed, 13 Jun 2007 13:14:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131313550.4059@racer.site>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 14:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyRnk-0000Se-LF
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 14:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbXFMMSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 08:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbXFMMSP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 08:18:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:56344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752012AbXFMMSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 08:18:14 -0400
Received: (qmail invoked by alias); 13 Jun 2007 12:18:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 13 Jun 2007 14:18:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w5Zt+6JHwvS5lVG1NK34DjmtFe2iChz1C/DYmjA
	0GwatekboDcEOb
X-X-Sender: gene099@racer.site
In-Reply-To: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50052>

Hi,

On Wed, 13 Jun 2007, Geoff Russell wrote:

> Dear gits,

;-)

> [...]
>
>        git tag v1.1
>        git format-patch v1.0
>        cd /tmp/newmyrepo
>        git am ~/myrepo/THEPATCHNAME
> 
> Where is tag v1.1 ?

Tags are not propagated with patches. Sorry.

Ciao,
Dscho
