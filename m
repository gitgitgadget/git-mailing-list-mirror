From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 01:17:11 -0700
Message-ID: <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
 <20080827001705.GG23698@parisc-linux.org>
 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
 <1219907659.7107.230.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, users@kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 10:19:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYci6-00013h-OA
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYH1IRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbYH1IRY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:17:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYH1IRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:17:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 479816B55D;
	Thu, 28 Aug 2008 04:17:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 87B566B55B; Thu, 28 Aug 2008 04:17:14 -0400 (EDT)
In-Reply-To: <1219907659.7107.230.camel@pmac.infradead.org> (David
 Woodhouse's message of "Thu, 28 Aug 2008 08:14:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD2CF156-74D9-11DD-ADCB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> Excellent. All we need to do is make sure the distributions all set
> $(gitexecdir) to /usr/bin when they upgrade to 1.6.0 -- and could you
> also fix it on master.kernel.org please?

Are you trying to irritate me even more?

Although I personally did not particularly like the "out of /usr/bin" move,
this was done by user request.  I now am hated for doing something I was
dragged into doing, not because I wanted the change, but only because many
others wanted it, and you are dreaming that another pointless change will
be made in the other direction?

Get a clue already.
