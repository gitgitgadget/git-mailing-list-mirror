From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH 1/2] rebase -i: support --root without --onto
Date: Tue, 26 Jun 2012 22:27:11 +0100
Message-ID: <20120626212711.GB11498@arachsys.com>
References: <20120626133339.GT9682@arachsys.com>
 <bdb45972685db8899a46ebc62213e56c9a3d0c94.1340717793.git.chris@arachsys.com>
 <7vtxxxc22x.fsf@alter.siamese.dyndns.org>
 <20120626193817.GD30779@arachsys.com>
 <7vfw9hbzz5.fsf@alter.siamese.dyndns.org>
 <20120626201155.GE5864@arachsys.com>
 <7vwr2tahs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:27:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjdIC-0001bu-AL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 23:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab2FZV1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 17:27:18 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:43660 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab2FZV1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 17:27:17 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjdI4-0004Z8-K8; Tue, 26 Jun 2012 22:27:16 +0100
Content-Disposition: inline
In-Reply-To: <7vwr2tahs8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200685>

Junio C Hamano <gitster@pobox.com> writes:

> Chris Webb <chris@arachsys.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Very understandable.  Perhaps in-code comments would have helped.
> >
> > Shall I re-spin this with a comment to explain what's going on, and to
> > mention the implicit -i with rebase --root without -i, or would you prefer
> > to queue the existing version with any clarifications you think appropriate?
> 
> A reroll would be preferred, as it would be less work for me ;-)

No problem, I'll do that now. Thanks for the feedback and all your help with
this patch series.

Best wishes,

Chris.
