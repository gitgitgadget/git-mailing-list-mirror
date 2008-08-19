From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 12:43:23 -0700
Message-ID: <7v1w0k3i5g.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org>
 <20080819175220.GA10142@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVX8l-00015a-Hw
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415AbYHSTnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbYHSTnf
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:43:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbYHSTne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:43:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 627D360E7C;
	Tue, 19 Aug 2008 15:43:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2EAF60E7B; Tue, 19 Aug 2008 15:43:25 -0400 (EDT)
In-Reply-To: <20080819175220.GA10142@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 19 Aug 2008 13:52:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1AD51FB8-6E27-11DD-AFBB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92915>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 18, 2008 at 08:22:19PM -0700, Junio C Hamano wrote:
>
>> I do not know if I like the end result, but here is a patch to make the
>> traditional a/ and b/ prefix more mnemonic.
>
> Hmm. Something deep in my gut doesn't like this, just because I like the
> fact that no matter how I prepare a diff (and I do tend to do it
> different ways and post to the mailing list) it always ends up the same.

I had the exact same reaction when I prepared and sent the patch with i/
and w/ prefixes.  I'm trying to see if that "deep in my gut" feeling is
merely coming from my being very used to see a/ vs b/ or something more
fundamental, even though my working hypothesis is that I'll get used to
it.
