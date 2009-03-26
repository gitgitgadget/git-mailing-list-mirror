From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 20:34:44 -0700
Message-ID: <7v3ad1ufcb.fsf@gitster.siamese.dyndns.org>
References: <49CA78BF.2020101@fastmail.fm>
 <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
 <20090326022757.GC5835@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:37:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgP0-0005Sc-H5
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbZCZDew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZCZDev
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:34:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbZCZDev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:34:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DDC5901E;
	Wed, 25 Mar 2009 23:34:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7A629901D; Wed,
 25 Mar 2009 23:34:45 -0400 (EDT)
In-Reply-To: <20090326022757.GC5835@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 25 Mar 2009 22:27:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F3D7A06-19B7-11DE-A83F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114715>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 25, 2009 at 12:30:31PM -0700, Junio C Hamano wrote:
>
>> I do not answer "generally" part, but in git.git, I do not publish heads
>> of individual topic branches.  I could, but simply I don't, because that
>> has been the way I've operated so far, and I am too lazy to change my
>> configuration.
>
> I don't think it is a big problem in practice.

Both times Shawn took over the maintainership from me in October for the
past few years (and I will ask him to this year, too, although I do not
know if he is willing to take it again yet), it would have made his life
(and possibly everybody who had his topic in flight) much easier if they
were public.  Last year I sent him for-each-ref output offline before I
took off to make it a bit easier on him (my disappearance two years ago
was unscheduled and I couldn't do that).
