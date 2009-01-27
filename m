From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Tue, 27 Jan 2009 14:37:16 -0800
Message-ID: <7vk58g1ilf.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
 <20090121170434.GA21727@hashpling.org>
 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
 <20090122142258.GA2316@hashpling.org>
 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
 <7vwscmue5z.fsf@gitster.siamese.dyndns.org> <20090126225835.GB10118@mit.edu>
 <20090127220947.GA21319@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 23:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwa1-0003mF-1X
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbZA0WhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZA0WhY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:37:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbZA0WhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:37:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D611E94918;
	Tue, 27 Jan 2009 17:37:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 859A194912; Tue,
 27 Jan 2009 17:37:18 -0500 (EST)
In-Reply-To: <20090127220947.GA21319@hashpling.org> (Charles Bailey's message
 of "Tue, 27 Jan 2009 22:09:47 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10624C34-ECC3-11DD-ACB0-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107407>

Charles Bailey <charles@hashpling.org> writes:

> On Mon, Jan 26, 2009 at 05:58:35PM -0500, Theodore Tso wrote:
> ...
> A quick blame session has shown that after Ted I've probably touched
> the next most number of lines of mergetool. It's a crude measure and
> not necessarily a sign of competence, I admit.
>
> Although not rolling in spare time, I feel I'd be able review
> mergetool patches at roughly the rate that they tend to appear at the
> moment.
>
> Given the above, if I pass the "good taste" and "Junio trust" tests I
> feel that I should offer my services as mergetool patch wrangler.

Competence certainly counts to a certain extent, but volunteerism,
willingness, and enthusiasm count too.

Taste is sometimes a relative thing and we can make sure where we agree to
disagree on the list case by case basis.

Most importantly, anybody who will suffer when the tool breaks will be
much better person than I to look after it.  That is one of the largest
ingredient in the "trust" factor.

Thanks.
