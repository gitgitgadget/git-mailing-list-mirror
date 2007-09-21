From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 12:11:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709211208440.28395@racer.site>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 13:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYgR9-00005D-7u
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 13:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbXIULMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 07:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbXIULMi
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 07:12:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752907AbXIULMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 07:12:37 -0400
Received: (qmail invoked by alias); 21 Sep 2007 11:12:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 21 Sep 2007 13:12:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e8Nkrngce3Eg8s0DbsYqwyZKDueknA+IOHKU7g5
	bOFKhS4yA8IrBo
X-X-Sender: gene099@racer.site
In-Reply-To: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58845>

Hi,

On Fri, 21 Sep 2007, Peter Stahlir wrote:

> Is it possible/feasible to use git as a filesystem?
> Like having git on top of ext3.

I haven't looked at it closely, but there is a GitFS:

http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-f354b40618742b976c13700fe1fea28387ad5c89

(I am pointing you to the Git Wiki, so that you can find more pointers 
should you not be happy with this one.)

Ciao,
Dscho
