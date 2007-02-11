From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 17:39:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111738240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070211084030.GE2082@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHk5-0003hJ-GH
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbXBKQjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXBKQjy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:39:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:42691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750723AbXBKQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:39:54 -0500
Received: (qmail invoked by alias); 11 Feb 2007 16:39:52 -0000
X-Provags-ID: V01U2FsdGVkX18Punw+l94P0gyS5HiW7Dbw17h7Nx4e6zqZ/lMjeV
	TxyA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211084030.GE2082@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39292>

Hi,

On Sun, 11 Feb 2007, Shawn O. Pearce wrote:

> I'm wondering, should that start to occur as part of 1.5.0? Its one .sh 
> script, like gitk.  :)

It really does not touch a core part of git, but adds value. Given that we 
already include gitk, and that git-gui apparently got quite some testing, 
I am all for it.

Ciao,
Dscho
