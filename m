From: Peter Shenkin <shenkin@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 05:51:12 +0000 (UTC)
Message-ID: <loom.20111001T074143-595@post.gmane.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com> <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org> <7vwrcpoozk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 07:51:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9sUA-00034g-L1
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 07:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab1JAFvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 01:51:33 -0400
Received: from lo.gmane.org ([80.91.229.12]:52431 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab1JAFvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 01:51:31 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R9sTv-000332-GW
	for git@vger.kernel.org; Sat, 01 Oct 2011 07:51:27 +0200
Received: from h-67-101-25-249.nycmny83.dynamic.covad.net ([67.101.25.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:51:27 +0200
Received: from shenkin by h-67-101-25-249.nycmny83.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:51:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.101.25.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182538>

Junio C Hamano <gitster <at> pobox.com> writes:
> I think in general our documentation aims to spell out _all_ that happens,
...
 
> I am wondering if there is a systemic failure...
> ,,,If so are there things that we could
> do better without going through individual description?


Yes, I would say that there is one obvious 
systemic failure. 

Nowhere is it documented (as far as I am aware) that
this is the  way the git documentation should be read.

Since, in this regard, it differs from most software
documentation, it ought itself to be documented,
perhaps on the top-level git man page.

-P.
