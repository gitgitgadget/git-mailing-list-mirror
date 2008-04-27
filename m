From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: add a new format.cc configuration
 variable
Date: Sun, 27 Apr 2008 12:53:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness> <20080426232737.GR4012@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 13:54:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5SS-0003w9-Tz
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762259AbYD0Lx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762229AbYD0Lx2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:53:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:40392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762047AbYD0Lx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:53:27 -0400
Received: (qmail invoked by alias); 27 Apr 2008 11:53:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 27 Apr 2008 13:53:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WPdRLWHaWeSccran4dCC3vB41kL7k4JkCUawsap
	pyk07ycqNxXNUk
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080426232737.GR4012@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80444>

Hi,

On Sun, 27 Apr 2008, Miklos Vajna wrote:

> On Sat, Apr 26, 2008 at 11:31:13PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I am wary... should this not be specific to send-email?  IOW should 
> > format-patch not be left alone?
> 
> Yes and no. :-) I first searched for a --cc option in send-email, then
> realized that only format-patch has one.

You are completely correct, sorry.  Hmm.  I would have preferred 
send-email inserting that header, oh well.

Ciao,
Dscho
