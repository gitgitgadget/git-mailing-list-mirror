From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 10:19:41 -0800
Message-ID: <7vskzn5w3m.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802091307160.11591@racer.site>
 <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site>
 <20080210101756.GB26568@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101219280.11591@racer.site>
 <20080210122321.GA31009@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101303140.11591@racer.site>
 <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
 <20080220140306.GA6928@sigill.intra.peff.net>
 <7vk5kz7btw.fsf@gitster.siamese.dyndns.org>
 <20080220181513.GA16289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:20:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtYo-0001Ap-Cz
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838AbYBTSUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYBTSUF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:20:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbYBTSUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:20:03 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 55573334F;
	Wed, 20 Feb 2008 13:20:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 3FDCE3346; Wed, 20 Feb 2008 13:19:49 -0500 (EST)
In-Reply-To: <20080220181513.GA16289@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Feb 2008 13:15:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74531>

Jeff King <peff@peff.net> writes:

> Meaning you will take this patch? (And yes, I think the "+HEAD" patch
> you sent is a good fix, regardless of everything else we've talked
> about).

Yes I would, except that I think Daniel's is much better and is
to the point.  Doesn't it cover all the issues we discussed so
far?

> ... Once the behavior is configurable at all, we
> can see how people adopt it into their workflows and if there is really
> any desire for detection at all.

Yup.
