From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] git-format-patch: Number patches when there are more than one
Date: Sat, 03 Nov 2007 19:56:23 +0100
Message-ID: <87hck3cg4o.fsf@willow.rfc1149.net>
References: <Pine.LNX.4.64.0710221044080.25221@racer.site> <1194104694-12530-1-git-send-email-mh@glandium.org> <472C9AFC.3000509@op5.se> <20071103160323.GA13284@glandium.org> <472CA29F.3090701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 20:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoOJB-0004yb-Nr
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbXKCTFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbXKCTFK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:05:10 -0400
Received: from main.gmane.org ([80.91.229.2]:48562 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbXKCTFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:05:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IoOIo-0005Uq-W8
	for git@vger.kernel.org; Sat, 03 Nov 2007 19:05:03 +0000
Received: from zaphod.rfc1149.net ([88.191.14.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 19:05:02 +0000
Received: from sam by zaphod.rfc1149.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 19:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:wGqqVkeqmQfUt4cK0ouQ0lRuI6E=
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63300>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

>> Does it make sense to turn it off ?

Andreas> Sometimes, yes. I frequently gather several small fixes on a
Andreas> branch and then send all of them at once. They rarely depend
Andreas> on each other, and apply order is usually not important, so
Andreas> it doesn't make sense to order them.

So do I. I prefer the auto-numbering to be off by default as it is now.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
