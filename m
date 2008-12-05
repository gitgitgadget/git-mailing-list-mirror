From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git weekly news: 2008-49
Date: Fri, 05 Dec 2008 12:54:58 -0800
Message-ID: <7v3ah2z6jh.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530812041643r784ae8b1x242e3b2f9c9f41@mail.gmail.com>
 <m3d4g6ipah.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	"git list" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 21:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8hj8-00070q-3l
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 21:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbYLEUzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 15:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYLEUzJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 15:55:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYLEUzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 15:55:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFADD182F8;
	Fri,  5 Dec 2008 15:55:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83960182F6; Fri, 
 5 Dec 2008 15:54:59 -0500 (EST)
In-Reply-To: <m3d4g6ipah.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 05 Dec 2008 08:02:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE89BEA8-C30E-11DD-880B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102411>

Jakub Narebski <jnareb@gmail.com> writes:

> [1] It would be nice if somebody resurrected GitTraffic, offshot of
> now defunct KernelTraffic, or at least helped to write Git articles
> for KernelTrap (which currently is in a bit of hiatus).

While I 100% agree with you that "Git Traffic" was a terrific attempt, I
do not think expecting or asking Felipe to duplicate it is realistic.

I searched for Felipe's proposal on the list archive, and its title was
"Planet Git".  That shows why the focus could be different.

"Git Traffic" was great because it attempted to directly address the issue
that the traffic on the mailing list was simply too high (and still is) to
follow for casual observers.  It did so by giving a comprehensive summary
of what important topics were discussed recently on the list from the
viewpoint of one dedicated person who followed many, perhaps not all,
important threads carefully, who very well knew what was going on, and who
had a good taste on what is important and what is not.

But "Planet Git" is quite different from "Git Traffic".  For the latter,
somebody needs to do a real work, continuously.  But more importantly, I
think they would serve different purposes.  A "Planet" could be valuable
to have with or without "Traffic".

I think what was presented as "Official Git blog", however, is also
different from what people expect a "Planet" to be.  I do not think it is
unreasonable to expect or ask Felipe to improve on making his service more
"Planet" like.

A "Planet", as I understand it, is an aggregator of (selected) people's
blogs, and even though I am not currently involved in any Planet nor
follow any Planet myself, I can imagine that it could be a valuable
resource to have a "Planet Git" that subscribes to and aggregates what
influential figures write on git in their blogs.

Felipe's page currently is a random collection of links, and other than
their titles, there is no indication for readers to judge which link is
worth clicking and reading.  It does not even mention who wrote each
piece, let alone editorial comments (e.g. "This is worth reading") like
you added.  When you click one of them in order to read it, you leave the
"list of links".  That is not how navigation (the click and thought flow
for the readers) usually works in a "Planet".

If this wants to be a "Planet Git", I do not think there is any need for
Felipe to ask "who wants accounts?"  It would go the other way.  Instead,
Felipe, as the coordinator of the "Planet", would find people who writes
noteworthy things on git on their own blogs, would ask for permission to
slurp and aggregate what they wrote, and produce the page by aggregating
their writings.  That would make a good "Planet Git".

Expecting people to apply for an account and write for that page would not
fly.  As Felipe said himself, many people already have their own blog.

Having said all that, I am not sure "Planet" would work for the git
community as well as it would for others.  I do not know of many core-ish
people write on git on their blogs (and I know at least two core-ish
people who flatly say "blogging is a waste of time").
