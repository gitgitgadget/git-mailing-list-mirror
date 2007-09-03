From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all examples
Date: Mon, 03 Sep 2007 11:03:54 +0900
Message-ID: <buolkbofqt1.fsf@dhapc248.dev.necel.com>
References: <tzqfsijk.fsf@cante.net>
	<7vy7frzfzg.fsf@gitster.siamese.dyndns.org> <hcmesrse.fsf@cante.net>
	<7vabs6u3jt.fsf@gitster.siamese.dyndns.org>
	<20070901150153.GD7422@mediacenter.austin.rr.com>
	<veauqfu0.fsf@cante.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Sep 03 04:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS1Ib-0005tB-UM
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 04:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbXICCEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbXICCEE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 22:04:04 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:34488 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbXICCEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 22:04:01 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l8323gGd014870;
	Mon, 3 Sep 2007 11:03:43 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Mon, 3 Sep 2007 11:03:43 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Mon, 3 Sep 2007 11:03:43 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 8E8A0476; Mon,  3 Sep 2007 11:03:54 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <veauqfu0.fsf@cante.net> (Jari Aalto's message of "Sat\, 01 Sep 2007 23\:40\:55 +0300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57424>

Jari Aalto <jari.aalto@cante.net> writes:
> After all, the ^ very differento to what other SCM/VCSs use.

It's something I _constantly_ wished other SCM/VCSs had, as it's far,
far, more usable than the typical absolute rev numbers.  It really
should be introduced as early as possible.

-Miles

-- 
Fast, small, soon; pick any 2.
