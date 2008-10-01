From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/9] Docs: send-email: Man page option ordering
Date: Wed, 1 Oct 2008 13:36:51 -0700
Message-ID: <20081001203651.GO21310@spearce.org>
References: <20080929174445.GA6015@coredump.intra.peff.net> <1222779512-58936-1-git-send-email-mfwitten@mit.edu> <1222779512-58936-2-git-send-email-mfwitten@mit.edu> <1222779512-58936-3-git-send-email-mfwitten@mit.edu> <20081001032701.GC24513@coredump.intra.peff.net> <26288097-F87A-4F93-B030-40598D65BEEE@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 01 22:38:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8SQ-0004lM-8S
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 22:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbYJAUgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753682AbYJAUgw
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 16:36:52 -0400
Received: from george.spearce.org ([209.20.77.23]:37179 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbYJAUgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 16:36:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 297753835F; Wed,  1 Oct 2008 20:36:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <26288097-F87A-4F93-B030-40598D65BEEE@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97266>

Michael Witten <mfwitten@MIT.EDU> wrote:
> On 30 Sep 2008, at 10:27 PM, Jeff King wrote:
>>
>> I believe this particular patch is probably redundant, since
>> 8/9 just re-orders the manpage again later. So it could be
>> dropped if somebody feels like doing the work to rebase the
>> later patches.
>
> I would suggest just leaving it there; it fixes a genuine
> problem regardless of what the future patches do.

Not only that but the series is already merged into next.  I won't
be happy about having to revert it, rewrite history, and merge it
back into next.  :-)

-- 
Shawn.
