From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add --filedirstat diff option
Date: Wed, 3 Sep 2008 03:18:38 +0300
Message-ID: <20080903001838.GC1252@jolt.modeemi.cs.tut.fi>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org> <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> <7vwshuglq1.fsf@gitster.siamese.dyndns.org> <7v3akigl1g.fsf@gitster.siamese.dyndns.org> <20080903001254.GA12263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kag6j-0001Qi-2X
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbYICATR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbYICATR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:19:17 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:51386 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbYICATQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:19:16 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 8894EC577;
	Wed,  3 Sep 2008 03:19:15 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 17823-24; Wed,  3 Sep 2008 03:19:14 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 056ECC575;
	Wed,  3 Sep 2008 03:19:13 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 8B4D122209;
	Wed,  3 Sep 2008 03:18:38 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 71A7CA317C; Wed,  3 Sep 2008 03:18:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080903001254.GA12263@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94748>

On Tue, Sep 02, 2008 at 08:12:54PM -0400, Jeff King wrote:
> ...and I thought of --dirstat-byfile. So maybe:

I like --dirstat-byfile more than --dirstat=byfile as dirstat already 
takes a cut-off percent parameter.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
