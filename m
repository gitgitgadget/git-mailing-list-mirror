From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jun 2009, #03; Sat, 27)
Date: Sun, 28 Jun 2009 16:04:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906281603580.4773@pacific.mpi-cbg.de>
References: <7vy6rcg7hc.fsf@alter.siamese.dyndns.org> <200906281550.39051.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 16:03:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKuyN-0002hI-RF
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZF1ODC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 10:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbZF1ODA
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 10:03:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:34154 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751509AbZF1ODA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 10:03:00 -0400
Received: (qmail invoked by alias); 28 Jun 2009 14:03:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 28 Jun 2009 16:03:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196Vp1gbTd6SjyXPpkwnqb8ZTCZ6lGoEXPSwrmR7h
	krkPprwwX4BhhS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200906281550.39051.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122405>

Hi,

On Sun, 28 Jun 2009, Christian Couder wrote:

> On Sunday 28 June 2009, Junio C Hamano wrote:
> > Here are the topics that have been cooking.  Commits prefixed with '-'
> > are only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> > marked with '.' do not appear in any of the branches, but I am still
> > holding onto them.
> 
> Is there a reason why the following patches have been removed from pu:
> 
> commit 6dcab5fbeb56a8fdd908d54ae7154308bfa5f74b
> Author: Christian Couder <chriscool@tuxfamily.org>
> Date:   Sun Jun 21 07:08:45 2009 +0200
> 
>     rebase -i: use config file format to save author information
> [...]

The reason might be that I did not see how this could help 
builtinification.

Ciao,
Dscho
