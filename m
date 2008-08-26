From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 14:28:18 -0700
Message-ID: <7vk5e38o0d.fsf@gitster.siamese.dyndns.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
 <1219664940.9583.42.camel@pmac.infradead.org>
 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
 <20080826145719.GB5046@coredump.intra.peff.net>
 <1219764860.4471.13.camel@gaara.bos.redhat.com>
 <1219766398.7107.87.camel@pmac.infradead.org>
 <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
 <20080826180926.GA25711@isilmar.linta.de>
 <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY66b-0000Gy-N9
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYHZV2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbYHZV2c
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:28:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbYHZV2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 07EA6680CB;
	Tue, 26 Aug 2008 17:28:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C12CE680BA; Tue, 26 Aug 2008 17:28:20 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Tue, 26 Aug 2008 11:19:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDFF6ED2-73B5-11DD-AF74-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93824>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> ... But the major problem is something else: it's that
>> doing PATH="$PATH:$(git --exec-path) is also deprecated, i.e. that workaround
>> is to go away in one of the next releases too.
>
> NO, IT IS NOT DEPRECATED.
>
> That was a plan. I think that plan got scuttled already. Stop whining!
>
> Can't you understand that people can change plans based on feedback?
>
> Effing whiners. 

I do not think "the plan got scuttled *already*" before you said so.  It
was the purpose for this thread to discuss it.

You effectively vetoed the plan with your statement just now, and that
settles it.  We can now officially declare the plan got scuttled and we
can all go back to our happy lives ;-).

Thanks.
