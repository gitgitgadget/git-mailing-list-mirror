From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 01:22:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080121240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.27739.701406.722074@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:22:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEx3n-00004w-3i
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933342AbXBHAW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933346AbXBHAW3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:22:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:50056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933342AbXBHAW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:22:27 -0500
Received: (qmail invoked by alias); 08 Feb 2007 00:22:26 -0000
X-Provags-ID: V01U2FsdGVkX1+ZgGV4id+ZAN6DcE/fINotLE7g/E+nIbtONTi13P
	i3uQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17866.27739.701406.722074@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39016>

Hi,

On Wed, 7 Feb 2007, Bill Lear wrote:

> So, 1) how do I get back to the status quo ante?  I have about 30 files 
> listed as "Updated but not checked in", then this:

git reset --hard

It's probably explained in the new user manual (I did not check).

Ciao,
Dscho
