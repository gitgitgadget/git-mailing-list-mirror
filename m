From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Mon, 26 Feb 2007 17:38:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261736570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070226121557.GA18114@coredump.intra.peff.net>
 <20070226143142.GA1390@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 17:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLiru-0008I8-Dy
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 17:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbXBZQi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 11:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbXBZQi1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 11:38:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:34524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752454AbXBZQi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 11:38:26 -0500
Received: (qmail invoked by alias); 26 Feb 2007 16:38:24 -0000
X-Provags-ID: V01U2FsdGVkX18YOyda31gYJ0vdlLthIIs6mNT/kglUVJNlGOFTuj
	8JXA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070226143142.GA1390@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40628>

Hi,

On Mon, 26 Feb 2007, Shawn O. Pearce wrote:

> My recollection is that only git-commit-tree and git-gui knew about this 
> 16 parent limit.

AFAIRC git-show-branch has a limit of 28 parents or so... But that is 
purely viewing porcelain...

Ciao,
Dscho
