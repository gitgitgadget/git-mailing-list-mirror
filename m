From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 5 Feb 2008 23:04:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052303060.8543@racer.site>
References: <ve53xwob.fsf@blue.sea.net> <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net> <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org> <alpine.LSU.1.00.0802052236220.8543@racer.site> <ejbrxbid.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWri-0000Pt-U5
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 00:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbYBEXFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 18:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYBEXFh
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 18:05:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:46861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753515AbYBEXFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 18:05:36 -0500
Received: (qmail invoked by alias); 05 Feb 2008 23:05:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 06 Feb 2008 00:05:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YxkBbNV1Yerl8TenmsNjaZI2PP3JtoVgYSTmslL
	12f3FXkIxf0gXY
X-X-Sender: gene099@racer.site
In-Reply-To: <ejbrxbid.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72719>

Hi,

On Wed, 6 Feb 2008, Jari Aalto wrote:

> Sloppy scripts are best left to script writers headache.

I see no sloppy behaviour when somebody sees that git-am (which uses 
the same directory!) has no way of handling a non-applying patch, and then 
writes a script that accesses .dotest/patch.

But I _see_ some sloppy behaviour of somebody not following netiquette, 
responding to a certain mail, but not to the original poster!

Ciao,
Dscho "who is annoyed"
