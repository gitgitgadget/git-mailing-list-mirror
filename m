From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 18:54:06 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804201853150.5084@eeepc-johanness>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>  <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness> <449c10960804201049o1c8f0be4m36dc5ce2afec2de6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 19:54:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JndkF-0001Wi-SN
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbYDTRxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYDTRxt
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:53:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:56968 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755099AbYDTRxs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:53:48 -0400
Received: (qmail invoked by alias); 20 Apr 2008 17:53:46 -0000
Received: from R16f8.r.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [89.54.22.248]
  by mail.gmx.net (mp036) with SMTP; 20 Apr 2008 19:53:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8Qpg1kbz8Ft/6kU5OxZm/gO2Hzmz1KhKAZ3c09D
	m6n1KLBc7YSb+v
X-X-Sender: user@eeepc-johanness
In-Reply-To: <449c10960804201049o1c8f0be4m36dc5ce2afec2de6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79972>

Hi,

On Sun, 20 Apr 2008, Dan McGee wrote:

> On Sun, Apr 20, 2008 at 12:43 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Sun, 20 Apr 2008, Dan McGee wrote:
> >
> >  > [no commit message]
> >
> >  I would like to deprecate dashed form _officially_ first (as in 
> >  ReleaseNotes), before doing something that could lead to quite some 
> >  surprised users.
> 
> Now you've confused me. From Documentation/RelNotes-1.5.4.txt, it
> seems fairly clear that dashed command forms are deprecated.

Oh, I must have missed that.  Nevertheless, I think it should be 
synchronised with when the dashed commands vanish from the default 
installation.

Ciao,
Dscho
