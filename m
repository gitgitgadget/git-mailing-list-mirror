From: Mark Burton <markb@ordern.com>
Subject: Re: How to list versioned files with modification status
Date: Sun, 5 Oct 2008 09:04:12 +0000 (UTC)
Message-ID: <loom.20081005T090050-722@post.gmane.org>
References: <20081004131256.586a5fbf@smartavionics.com> <81b0412b0810041440w131647aeo9c14f55cd38da635@mail.gmail.com> <loom.20081004T215458-15@post.gmane.org> <alpine.LFD.2.00.0810041608150.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 11:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPYu-0002OK-6j
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbYJEJEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYJEJEa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:04:30 -0400
Received: from main.gmane.org ([80.91.229.2]:47504 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbYJEJE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:04:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KmPXM-0005Di-Ah
	for git@vger.kernel.org; Sun, 05 Oct 2008 09:04:24 +0000
Received: from host86-128-74-78.range86-128.btcentralplus.com ([86.128.74.78])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 09:04:24 +0000
Received: from markb by host86-128-74-78.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 09:04:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.74.78 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97500>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> Nobody has ever asked for such a crazy thing, but here's a test-patch to 
> teach 'git ls-files' the '--unmodified' flag.
> 
> ...

Many thanks for the patch, it does exactly what I wanted. Thanks also to the
other people who contributed suggestions.

Mark
