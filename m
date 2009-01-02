From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Extracting a single commit or object
Date: Fri, 2 Jan 2009 18:37:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901021836430.30769@pacific.mpi-cbg.de>
References: <21223948.post@talk.nabble.com> <alpine.DEB.1.00.0901011747580.30769@pacific.mpi-cbg.de> <20090101180834.GJ21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: yitzhakbg <yitzhakbg@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 18:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LInyI-0000yR-TO
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 18:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbZABRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 12:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757281AbZABRgp
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 12:36:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:49024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757066AbZABRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 12:36:45 -0500
Received: (qmail invoked by alias); 02 Jan 2009 17:36:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 02 Jan 2009 18:36:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ylI5zEQjyLG7zn1u7ltKUEQYhXx7M64vUIU0MXh
	dH+WHk+tSDz1BD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090101180834.GJ21154@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104388>

Hi,

On Thu, 1 Jan 2009, Miklos Vajna wrote:

> On Thu, Jan 01, 2009 at 05:52:49PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > If you activated bash completion, you can even complete monsters like 
> > this:
> > 
> > 	git show \
> > v1.5.3:v1.5.3:t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master
> 
> Wow, that's really a monster. After removing the first leading v1.5.3:, 
> it works. (If this is a bash completion bug, I can't reproduce.)

Heh, it's just another proof that copy-n-paste ist just error-prone.

Thanks,
Dscho
