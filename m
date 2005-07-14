From: James Cloos <cloos+vger-git@jhcloos.com>
Subject: cg update failing
Date: Thu, 14 Jul 2005 14:04:35 -0400
Message-ID: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 14 20:07:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt86M-0006RD-TH
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 20:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbVGNSFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVGNSE7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 14:04:59 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:48914 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S263064AbVGNSEr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 14:04:47 -0400
Received: from lugabout.jhcloos.org (host-69-48-10-3.roc.choiceone.net [69.48.10.3])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id 3E2791D02F
	for <git@vger.kernel.org>; Thu, 14 Jul 2005 13:04:43 -0500 (CDT)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 1C775AC505; Thu, 14 Jul 2005 18:04:36 +0000 (GMT)
To: git@vger.kernel.org
X-Hashcash: 1:21:050714:git@vger.kernel.org::MNxSVNEdkswgoq7v:0000000000000000000000000000000000000000008T93
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'm getting this on my clone of linus' tree:

,----
| cg-merge: merge blocked: seeked from master
`----

I've not found a way past it.

Is there an easy way, or do I have still yet another borked lk clone?

(Borked clones would be much less of an issue if I had more bandwidth
than disk space, but at the moment I'm stuck behind a straw.  Cloning
something like lk takes hours.)

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
