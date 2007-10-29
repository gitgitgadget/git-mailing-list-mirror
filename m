From: Miles Bader <miles.bader@necel.com>
Subject: Re: How to remove a specific hunk
Date: Mon, 29 Oct 2007 16:03:23 +0900
Message-ID: <buor6jeo11g.fsf@dhapc248.dev.necel.com>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se>
	<20071026164207.GB19673@coredump.intra.peff.net>
	<20071026164926.GA21160@coredump.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Pascal Obry <pascal.obry@wanadoo.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 08:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImOfW-0007Ns-RM
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 08:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXJ2HEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 03:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbXJ2HEA
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 03:04:00 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51189 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbXJ2HEA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 03:04:00 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9T73NN8002857;
	Mon, 29 Oct 2007 16:03:25 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Mon, 29 Oct 2007 16:03:25 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Mon, 29 Oct 2007 16:03:24 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 92B034E0; Mon, 29 Oct 2007 16:03:23 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20071026164926.GA21160@coredump.intra.peff.net> (Jeff King's message of "Fri\, 26 Oct 2007 12\:49\:26 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62606>

Jeff King <peff@peff.net> writes:
> BTW, since this is inherently a non-git operation, there are other tools
> that some may find friendlier than an editor. Kompare will let you
> unapply differences, for example, and I would be shocked if emacs didn't
> have some tool for this.

M-x diff-mode
<move to bad hunk>
C-u C-c C-a

-Miles

-- 
Next to fried food, the South has suffered most from oratory.
  			-- Walter Hines Page
