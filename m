From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Problems with git-svnimport
Date: Tue, 3 Jul 2007 19:45:12 +0000 (UTC)
Message-ID: <loom.20070703T214211-88@post.gmane.org>
References: <Pine.LNX.4.64.0706071639190.12111@www.mintpixels.com> <Pine.LNX.4.64.0706072329020.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 21:45:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5oJQ-000658-Nv
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbXGCTpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbXGCTpW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:45:22 -0400
Received: from main.gmane.org ([80.91.229.2]:33190 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbXGCTpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:45:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I5oJL-0002T0-Ib
	for git@vger.kernel.org; Tue, 03 Jul 2007 21:45:19 +0200
Received: from smurf.noris.de ([192.109.102.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 21:45:19 +0200
Received: from smurf by smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 21:45:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.109.102.42 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.3) Gecko/20061201 Firefox/2.0.0.3 (Ubuntu-feisty))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51528>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> Let's deprecate git-svnimport, once for all.
> 
> git-svn should work much better.
> 
In other words, you volunteer to fold everything that git-svnimport can do into
git-svn? The last time I checked, neither was a feature-complete subset of the
other...

If so: don't let me hold you back. ;-)

-- 
Matthias Urlichs
