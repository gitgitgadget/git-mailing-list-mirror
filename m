From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show decoration
Date: Wed, 20 Aug 2008 12:01:39 -0700
Message-ID: <7vljyrqzn0.fsf@gitster.siamese.dyndns.org>
References: <20080820175325.GD27773@sigill.intra.peff.net>
 <20080820180034.GB32005@sigill.intra.peff.net>
 <alpine.DEB.1.00.0808202042260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVsxJ-0004vr-Su
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbYHTTBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYHTTBu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:01:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbYHTTBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:01:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D7E660A2E;
	Wed, 20 Aug 2008 15:01:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E62AE60A2A; Wed, 20 Aug 2008 15:01:41 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808202042260.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Wed, 20 Aug 2008 20:43:29 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FF71988-6EEA-11DD-A0C3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93015>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 20 Aug 2008, Jeff King wrote:
>
>> There is a lot of room for discussion here.
>
> Indeed.  When I posted a similar patch, there was some discussion, too.  
> But no resolution, as it seemed nobody was really interested.

Why being so negative?  Got up on the wrong side of the bed?

People drop off of a discussion for different reasons, and it is not
necessarily from total lack of interest (unless nobody responded to the
initial call-for-discussion, obviously).  Perhaps there were more
interesting and/or pressing thing for them to think about than interaction
between decorate and pretty=format at the same time.

This time around, the original requestor may be more motivated and/or have
time for this topic than you were motivated and/or you had time back then,
and can carry the discussion forward.  Let's see what happens.
