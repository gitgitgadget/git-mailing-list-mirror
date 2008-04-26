From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: add a new format.cc configuration
 variable
Date: Sat, 26 Apr 2008 23:31:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 00:32:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpsw1-0007QP-DP
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 00:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbYDZWbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 18:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbYDZWbI
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 18:31:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:48034 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756555AbYDZWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 18:31:07 -0400
Received: (qmail invoked by alias); 26 Apr 2008 22:31:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp045) with SMTP; 27 Apr 2008 00:31:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cKZBd3LEcHYceXw5jctSHS9+omFdP2S3BUp5awi
	RCaOa8NA7TyGKO
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80395>

Hi,

On Sat, 26 Apr 2008, Miklos Vajna wrote:

> Some projects prefer to always CC patches to a given mailing list. In
> these cases, it's handy to configure that address once.

I am wary... should this not be specific to send-email?  IOW should 
format-patch not be left alone?

Ciao,
Dscho
