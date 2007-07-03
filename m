From: Theodore Tso <tytso@mit.edu>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 14:39:48 -0400
Message-ID: <20070703183947.GE5322@thunk.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org> <20070702142557.eba61ccd.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org> <20070702145601.a0dcef0f.akpm@linux-foundation.org> <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org> <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org> <Pine.LNX.4.64.0707031303130.4071@racer.site> <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:40:10 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5nIH-0000DN-EB
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 20:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbXGCSkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 14:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbXGCSkG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 14:40:06 -0400
Received: from THUNK.ORG ([69.25.196.29]:52472 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189AbXGCSkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 14:40:05 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5nPp-000351-UW; Tue, 03 Jul 2007 14:47:58 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5nHw-0003xx-7a; Tue, 03 Jul 2007 14:39:48 -0400
Content-Disposition: inline
In-Reply-To: <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51523>

On Tue, Jul 03, 2007 at 02:21:51PM +0200, Paolo Ciarrocchi wrote:
> >But maybe they would be willing to install git to get that wonderful
> >git-apply program, and that wonderful rename-and-mode-aware git-diff, and
> >the git-merge-file program, all of which can operate outside of a git
> >repository. (Take that, hg!)
> 
> How about shipping just these commands as a separate package?
> Is that a cray idea?

Or people could submit a bug report/feature request/patch to the
patch(1) maintainer.  :-)

						- Ted
