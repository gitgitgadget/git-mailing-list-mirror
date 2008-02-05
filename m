From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from glibc
Date: Tue, 5 Feb 2008 15:07:29 -0600
Message-ID: <20080205210728.GO26392@lavos.net>
References: <20080204024644.GM26392@lavos.net> <1202209509-13760-1-git-send-email-bdowning@lavos.net> <20080205141139.GN26392@lavos.net> <7v3as7b29q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Edgar Toernig <froese@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMV1a-0006O1-PH
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 22:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760086AbYBEVHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759692AbYBEVHl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 16:07:41 -0500
Received: from mxsf08.insightbb.com ([74.128.0.78]:59255 "EHLO
	mxsf08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759509AbYBEVHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 16:07:40 -0500
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000"; 
   d="scan'208";a="234522185"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf08.insightbb.com with ESMTP; 05 Feb 2008 16:07:40 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAHhfqEdKhvkY/2dsb2JhbACBWKwZ
X-IronPort-AV: E=Sophos;i="4.25,309,1199682000"; 
   d="scan'208";a="114315944"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 05 Feb 2008 16:07:32 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 1AE33309F21; Tue,  5 Feb 2008 15:07:30 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <7v3as7b29q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72698>

On Tue, Feb 05, 2008 at 12:02:09PM -0800, Junio C Hamano wrote:
> If you have more polished one, please send it in.  I'll discard
> the one in 'pu' and replace.

The "more polished" one is the great-grandparent of this post.

Except now I notice that it didn't make it to the vger list, at least
according to gmane's view of things.  I've had other problems with
git-send-email in the past.

I'll resend it (replying to this message) through my normal mailer.

-bcd
