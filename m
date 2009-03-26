From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 20:28:15 -0700
Message-ID: <7v8wmtufn4.fsf@gitster.siamese.dyndns.org>
References: <49CA78BF.2020101@fastmail.fm>
 <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
 <20090326022757.GC5835@coredump.intra.peff.net>
 <7vtz5hugc6.fsf@gitster.siamese.dyndns.org>
 <20090326031521.GA7984@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raman Gupta <rocketraman@fastmail.fm>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:29:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgHy-00045B-Lt
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbZCZD2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZCZD2Y
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:28:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZCZD2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:28:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C3A19FA3;
	Wed, 25 Mar 2009 23:28:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 502B19FA2; Wed,
 25 Mar 2009 23:28:17 -0400 (EDT)
In-Reply-To: <20090326031521.GA7984@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 25 Mar 2009 23:15:21 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27EE22EA-19B6-11DE-86B4-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114714>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 25, 2009 at 08:13:13PM -0700, Junio C Hamano wrote:
>
>> Incidentally, that is why I usually favor the current 'matching' default.
>> If I decide to push something to the other repository, the other
>> repository remembers my wish, so I do not have to keep track (of course,
>> for that to work effectively, you have to _own_ the other side; it does
>> not work well for a shared public repository and that is why we had a
>> lengthy discussion on push.default).
>
> So if I understand correctly, you would actually like "push matching,
> delete missing" behavior?

Hmm, that would be good.  That would allow me to start publishing the
individual topics with ease.

I never thought of that.
