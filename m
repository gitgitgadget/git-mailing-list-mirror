From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] for-each-ref: utilize core.warnambiguousrefs for
	strict refname:short format
Date: Fri, 17 Oct 2008 18:50:10 -0700
Message-ID: <20081018015010.GA14786@spearce.org>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com> <7vod1ieptr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 03:51:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr0yV-0007WI-OF
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 03:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYJRBuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 21:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYJRBuM
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 21:50:12 -0400
Received: from george.spearce.org ([209.20.77.23]:39523 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYJRBuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 21:50:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C7B5D3835F; Sat, 18 Oct 2008 01:50:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vod1ieptr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98514>

Junio C Hamano <gitster@pobox.com> wrote:
> Shawn, was there any issue with this one?  The patch changes the function
> signature for no good reason (at least, it does not have anything to do
> with the stated purpose of the change), but other than that, I think what
> it attempts to do makes sense.

No, aside from the signature issue I think its reasonable.

-- 
Shawn.
