From: Paul Mackerras <paulus@samba.org>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Mon, 13 Aug 2007 20:31:22 +1000
Message-ID: <18112.13050.666058.28505@cargo.ozlabs.ibm.com>
References: <20070810154108.GA779@ruiner>
	<20070810173242.GA23628@coredump.intra.peff.net>
	<alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
	<18109.21984.26228.849806@cargo.ozlabs.ibm.com>
	<20070811134927.GA2411@coredump.intra.peff.net>
	<18110.63328.644861.651934@cargo.ozlabs.ibm.com>
	<7veji8k6rg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 12:32:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKXDZ-00089Q-KK
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 12:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761015AbXHMKbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 06:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759253AbXHMKbd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 06:31:33 -0400
Received: from ozlabs.org ([203.10.76.45]:55878 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760832AbXHMKbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 06:31:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D0916DDE18; Mon, 13 Aug 2007 20:31:28 +1000 (EST)
In-Reply-To: <7veji8k6rg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55758>

Junio C Hamano writes:

> Thanks; pulled.

Unfortunately the fix I pushed out had a bug.  Please do another pull
to get a better fix.

Paul.
