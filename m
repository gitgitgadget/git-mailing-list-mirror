From: Paul Mackerras <paulus@samba.org>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 14:28:06 +1000
Message-ID: <17985.19926.347089.878721@cargo.ozlabs.ibm.com>
References: <loom.20070502T111026-882@post.gmane.org>
	<20070503200013.GG4489@pasky.or.cz>
	<loom.20070504T143538-533@post.gmane.org>
	<87y7k4lahq.wl%cworth@cworth.org>
	<20070505133543.GC3379@diana.vm.bytemark.co.uk>
	<alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	<alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	<17983.6136.147062.346626@cargo.ozlabs.ibm.com>
	<81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
	<e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 06:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hldml-0007bH-Fp
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934833AbXEIE2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934941AbXEIE2N
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:28:13 -0400
Received: from ozlabs.org ([203.10.76.45]:45979 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934833AbXEIE2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:28:12 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 98E03DDE36; Wed,  9 May 2007 14:28:11 +1000 (EST)
In-Reply-To: <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46656>

Marco Costalba writes:

> Language to use is C++, not C (much more powerful IMHO)

Sorry, C++ is not an option because I dislike it so much.  The main
reason for changing languages would be to enable people like Linus to
hack on it more easily, and I don't think C++ would achieve that.

> P.S: If you choose Qt/C++ (the best technically speaking ;-)  please
> you could consider starting from an already laid out code base instead
> of starting from scratch.
> As example, hmmmm, I think there is one called 'qgit', if I remember
> correctly. It's nice and very very very fast.

Yes, but isn't there already a talented hacker working on that? :)

Paul.
