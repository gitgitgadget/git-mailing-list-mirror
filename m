From: Mike Hommey <mh@glandium.org>
Subject: Re: New features in gitk
Date: Sun, 28 Oct 2007 19:38:19 +0100
Organization: glandium.org
Message-ID: <20071028183819.GA20541@glandium.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <20071028183216.GA4310@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 19:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImD3d-00058r-2o
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 19:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbXJ1Sjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 14:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbXJ1Sjx
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 14:39:53 -0400
Received: from vawad.err.no ([85.19.200.177]:48382 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbXJ1Sjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 14:39:52 -0400
Received: from aputeaux-153-1-93-248.w86-217.abo.wanadoo.fr ([86.217.55.248] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ImD2p-0006DN-A5; Sun, 28 Oct 2007 19:39:33 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1ImD1g-0005Mw-14; Sun, 28 Oct 2007 19:38:20 +0100
Content-Disposition: inline
In-Reply-To: <20071028183216.GA4310@artemis.corp>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62589>

On Sun, Oct 28, 2007 at 07:32:16PM +0100, Pierre Habouzit wrote:
> On dim, oct 28, 2007 at 01:39:34 +0000, Paul Mackerras wrote:
> > I just pulled the dev branch of gitk into the master branch, so the
> > master branch now has the new features and improvements that I have
> > been working on, namely: [...]
> 
> As you seem to be the guy to ask for, I've a couple of requests wrt
> gitk.
(...)
    * When running gitk --all, it would be nice if the current branch
      was selected, instead of the topmost commit.

Mike
