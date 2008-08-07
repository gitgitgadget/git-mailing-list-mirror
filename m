From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: clarify that git-commit only works with
 tracked files
Date: Thu, 7 Aug 2008 02:39:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu> <20080806214747.GY32057@genesis.frugalware.org> <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu> <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Thu Aug 07 02:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQtUZ-0005og-Nb
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 02:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYHGAfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYHGAf3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 20:35:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752915AbYHGAf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 20:35:28 -0400
Received: (qmail invoked by alias); 07 Aug 2008 00:35:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 07 Aug 2008 02:35:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Z6ktoBQaZIqA9YHXDW/WV2b5nDN05Gr0OhPCkMp
	blIIElrTsPEX+r
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91555>

Hi,

On Wed, 6 Aug 2008, Jonathan Nieder wrote:

> A user unfamiliar with CVS might not realize that a git-add is
> needed before commiting new files.

Funny.  I haven't used CVS for a while now, but I seem to remember that 
"cvs commit newfile.c" without a prior "cvs add newfile.c" is not allowed.

Ciao,
Dscho
