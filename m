From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: problem with import-tars?
Date: Mon, 21 May 2007 14:43:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705211441310.6410@racer.site>
References: <20070521084846.GN11652@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joshua N Pritikin <jpritikin@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 15:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq8BU-0004k9-Nc
	for gcvg-git@gmane.org; Mon, 21 May 2007 15:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758164AbXEUNoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757812AbXEUNoO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 09:44:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:40845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756865AbXEUNoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 09:44:13 -0400
Received: (qmail invoked by alias); 21 May 2007 13:44:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 21 May 2007 15:44:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SbNAGRmTSAFh4O/rN3oecr88aT0BjNkZr/4IgTx
	Qhb9diIuCzMn1S
X-X-Sender: gene099@racer.site
In-Reply-To: <20070521084846.GN11652@always.joy.eth.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48019>

Hi,

On Mon, 21 May 2007, Joshua N Pritikin wrote:

> I ran the import-tars which comes with 1:1.5.1.1-1 (Debian). I checked 
> out the import-tars branch but now I can't commit:
>
> [...]

I think that the bug you experienced is solved in 1.5.2. You can download 
import-tars.perl separately, as it should work with the 1.5.1.1 plumbing:

http://repo.or.cz/w/git.git?a=blob;f=contrib/fast-import/import-tars.perl;h=23aeb257b9557cb146586868084ce1b20d7e7ac8;hb=HEAD

Hth,
Dscho
