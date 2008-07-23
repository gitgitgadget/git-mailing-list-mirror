From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: When an 'edit' stops, mention the commit
Date: Wed, 23 Jul 2008 11:10:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231110000.2830@eeepc-johanness>
References: <4886E1DB.7020308@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLaMr-0002XM-Hz
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYGWJJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbYGWJJm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:09:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750709AbYGWJJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:09:41 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:09:39 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp056) with SMTP; 23 Jul 2008 11:09:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fQH0Wjo8fVFonrHzm5w+BpBZSWQg6BCYjLJDGQm
	X40dez4t9Dgff7
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4886E1DB.7020308@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89614>

Hi,

On Wed, 23 Jul 2008, Johannes Sixt wrote:

> In a rebase session where more than one commit is to be 'edit'ed, and 
> the user spends considerable time to 'edit' a commit, it is easy to 
> forget what one wanted to 'edit' at the individual commits. It would be 
> helpful to see at which commit the rebase stopped.

"... So mention it."

ACK.

Ciao,
Dscho
