From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Fri, 23 Jan 2009 09:26:32 -0800
Message-ID: <7vwscmue5z.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
 <20090121170434.GA21727@hashpling.org>
 <81bfc67a0901220617l22b5a8e4ma48bb069d67cae91@mail.gmail.com>
 <20090122142258.GA2316@hashpling.org>
 <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:28:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPp7-0005Vd-6r
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZAWR0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754672AbZAWR0j
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:26:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbZAWR0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:26:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26AC51D1E5;
	Fri, 23 Jan 2009 12:26:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3C3DD1D15E; Fri,
 23 Jan 2009 12:26:33 -0500 (EST)
In-Reply-To: <81bfc67a0901230716i166bfc4chd9a5c0990b0cd3b6@mail.gmail.com>
 (Caleb Cushing's message of "Fri, 23 Jan 2009 10:16:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD9CEAD0-E972-11DD-A0ED-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106893>

Caleb Cushing <xenoterracide@gmail.com> writes:

> so does my patch satisfy now? what's it take to get it included in the
> next version of git?

I do not use mergetool myself so I generally do not pay attention to
patches on this tool, but I would want to pick up ones that people
involved in mergetool discussion can agree to be good patches.

There are a few mergetool updates in flight from various authors.  How
does your submission compare with others' in both form/presentation and
clarity of logic (remember, I am not keeping track)?
