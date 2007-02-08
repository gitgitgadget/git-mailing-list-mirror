From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 01:25:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080125290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.27739.701406.722074@lisa.zopyra.com>
 <Pine.LNX.4.63.0702080121240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17866.28092.167065.520654@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEx6p-0001Gr-91
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbXBHAZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933346AbXBHAZv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:25:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:56789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933344AbXBHAZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:25:50 -0500
Received: (qmail invoked by alias); 08 Feb 2007 00:25:49 -0000
X-Provags-ID: V01U2FsdGVkX19ORHF8EINO5HzeyQ7mjowUy0Te2f6/jf1acd379s
	idFA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17866.28092.167065.520654@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39018>

Hi,

On Wed, 7 Feb 2007, Bill Lear wrote:

> On Thursday, February 8, 2007 at 01:22:24 (+0100) Johannes Schindelin writes:
> >Hi,
> >
> >On Wed, 7 Feb 2007, Bill Lear wrote:
> >
> >> So, 1) how do I get back to the status quo ante?  I have about 30 files 
> >> listed as "Updated but not checked in", then this:
> >
> >git reset --hard
> >
> >It's probably explained in the new user manual (I did not check).
> 
> Hmm ... from my topic branch:
> 
> % git reset -hard
> Usage: /usr/bin/git-reset [--mixed | --soft | --hard]  [<commit-ish>]

Please use two dashes: "--" instead of "-".

Ciao,
Dscho
