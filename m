From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git checkout preserve timestamp?
Date: Thu, 1 Mar 2007 23:32:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012330480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17895.18265.710811.536526@lisa.zopyra.com>
 <Pine.LNX.4.64.0703011409220.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtov-0005ul-Qv
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbXCAWcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbXCAWcO
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:32:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:46138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161041AbXCAWcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:32:14 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:32:12 -0000
X-Provags-ID: V01U2FsdGVkX19OegNsOyhOLp+dghcFKCvNykxDiORAC3suGnKHD5
	H+wa4pccsOsu+V
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703011409220.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41139>

Hi,

On Thu, 1 Mar 2007, Linus Torvalds wrote:

>  - and in the extreme example of that "virtual directory" thing, there 
>    was at least somebody working on a git plugin for FUSE, ie you could
>    literally just have virtual directories showing *all* your branches.

You mean http://www.sfgoth.com/~mitch/linux/gitfs/? Funny, it came up on 
IRC a few days ago. gitster said he'd issue "mkdir" instead of "git 
checkout -b" by mistake somtimes...

Ciao,
Dscho
