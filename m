From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Sat, 23 Nov 2013 00:04:22 +0100
Message-ID: <87vbzkghs9.fsf@linux-k42r.v.cablecom.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
	<20131122102345.GC12042@sigill.intra.peff.net>
	<87d2lsjs4q.fsf@linux-k42r.v.cablecom.net>
	<20131122172626.GA4881@sigill.intra.peff.net>
	<87vbzkiahs.fsf@linux-k42r.v.cablecom.net>
	<20131122223654.GB7538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 00:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjzmE-0002y8-Cz
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 00:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab3KVXEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 18:04:38 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:50781 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577Ab3KVXEh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 18:04:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 322C44D6580;
	Sat, 23 Nov 2013 00:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8Ki2etL6tbJT; Sat, 23 Nov 2013 00:04:25 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [89.204.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D5B504D6414;
	Sat, 23 Nov 2013 00:04:24 +0100 (CET)
In-Reply-To: <20131122223654.GB7538@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Nov 2013 17:36:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238220>

Jeff King <peff@peff.net> writes:

> Re-rolling such a big chunk of code _is_ a pain for both me and for
> reviewers, so I wouldn't mind switching to "fixes on top" instead of
> re-rolling at some point. But we can do another round or two of re-roll
> first.

No, actually I think the plan that you sketched in the other side thread
sounded nice: give it some exposure in next.  I'll still try and read
the rest, but that way it hopefully gets (much) more testing.

-- 
Thomas Rast
tr@thomasrast.ch
