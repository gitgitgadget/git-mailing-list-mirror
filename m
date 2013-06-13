From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Wed, 12 Jun 2013 21:22:40 -0700
Message-ID: <7v38smy6zz.fsf@alter.siamese.dyndns.org>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
	<7vehc72j46.fsf@alter.siamese.dyndns.org>
	<51B9406E.30104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 13 06:23:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umz3s-0004X2-1v
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 06:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab3FMEWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 00:22:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3FMEWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 00:22:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA3F1FD10;
	Thu, 13 Jun 2013 04:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0zid8K4cAXpHEOHn42HQ6T2ZeI=; b=RnqFCZ
	1/2VYFTcsEurwM/7Svo0gJOmP8wauBwV5Ybs9ICh0YYQODL0CjhFG3gvIJJFj1eZ
	X0KGBS9wu2BIcybkJsiRpmoV2A9JWv6zDPZege7Dx0k03wG/rl0IfFjVqJgjqKGQ
	S5sXFoY094/w9eyFSRXZBT4b1QdNDcjY1OxFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K+wJWu+if93zEoUibj3GHDPa7zLd6FHU
	V4MpWZfgrlTrdNUfSBIPkmwqFQAbYEhnRkosPF7Htm2cCgOXxPuc9K/OR7n0ZdCj
	I5b96FzR/sQ97BESw8Uq2EtHKYYMqv8qA/xHD3U5z4yxhtQkbzh/9YffYGS2sY0M
	vb8QdVy3rRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A04FA1FD0E;
	Thu, 13 Jun 2013 04:22:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 122531FD0B;
	Thu, 13 Jun 2013 04:22:42 +0000 (UTC)
In-Reply-To: <51B9406E.30104@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 13 Jun 2013 05:45:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3BF6E96-D3E0-11E2-BD16-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227697>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 06/12/2013 10:02 PM, Junio C Hamano wrote:
>> Coaching new contributors, like mentoring GSoC students, is often
>> more time consuming than scratching the same itch yourself for any
>> reviewer, but it is an investment, which hopefully yields dividend
>> in the longer term.
>
> Thanks for these concrete examples / suggestions for reviewers.  I
> remember especially that during my first contacts with the Git community
> I was very impressed by these very things in your code reviews and in
> those of other reviewers.
>
> Are you proposing that your text should find its way into the
> CommunityGuidelines in some form?

It actually was the other way around ;-).

After reading your message, I tried to think aloud by listing what I
try to do, and I was impressed that your three-line advice was a
very concise and very well written summary of that.  I agree that a
guideline should be kept as concise and clear as possible.

The main point of my message was that reviewing and coaching may be
costly, but we have to do them as an investment.
