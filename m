From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
 branch
Date: Mon, 18 Feb 2008 17:35:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181735230.30505@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <20080218164423.GA8832@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR9us-0004xu-Mv
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620AbYBRRfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbYBRRfw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:35:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:56434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751889AbYBRRfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:35:51 -0500
Received: (qmail invoked by alias); 18 Feb 2008 17:35:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 18 Feb 2008 18:35:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/omE1XzfLofMrQFxx/Ic7hvQRgop//36LoCRXcGe
	qQsOwHxtrEGmJ+
X-X-Sender: gene099@racer.site
In-Reply-To: <20080218164423.GA8832@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74318>

Hi,

On Mon, 18 Feb 2008, Clemens Buchacher wrote:

> This mirrors current ssh/git push syntax.
> ---
> 
> The previous patch gives the wrong branch name in the failure message.

Oh?  ref->peer_ref is not the remote side?

Ciao,
Dscho
