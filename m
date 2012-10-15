From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Planning to pass the baton to an interim maintainer
Date: Mon, 15 Oct 2012 09:58:05 -0700
Message-ID: <7v7gqry8o2.fsf@alter.siamese.dyndns.org>
References: <7vsj9gyktw.fsf@alter.siamese.dyndns.org>
 <20121015055654.GA10064@sigill.intra.peff.net>
 <507C3027.2030401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:58:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNnzg-0004lv-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 18:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab2JOQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 12:58:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab2JOQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 12:58:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16DDE947F;
	Mon, 15 Oct 2012 12:58:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0KaOrz91upzpnkceRscQpEFViI=; b=oBAuY6
	Au218H3iD0EOlOQpQvpDy4LjBb7mZOBhTirXWiFs6rgCS04LfMCaTQ83ZjPr9QmC
	0bOOsKkS25nX5KhJqgIQPPRMO5OaZMq3TsWhVKVMKXyXmaPTrWgWrrXG6uZEvknO
	vlWDdurz2xZ+0SIMW8befNa95oXxjl5R870qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PLzqvz5WtFFPKD4OrjaQkfXn5fQIhiaw
	eKBdX/joZimdn2lTlBE6VW6IlC7fdYbnMWv23ZWaUQ1a9YScI/IlNiRTgHP+GIDE
	Kyid3wGWh5TzbD0UeCmGKJYGRPNfbUlCQHBtQ1RONcGxuEZqW9mgqPylqu+/uU5t
	4jWI5bXT5YU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04FF8947E;
	Mon, 15 Oct 2012 12:58:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74A3B947D; Mon, 15 Oct 2012
 12:58:07 -0400 (EDT)
In-Reply-To: <507C3027.2030401@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 15 Oct 2012 17:47:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E30CB24-16E9-11E2-93F5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207762>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Jeff King venit, vidit, dixit 15.10.2012 07:56:
>> On Sun, Oct 14, 2012 at 11:23:07AM -0700, Junio C Hamano wrote:
>> 
>>> I am planning to
>>>
>>>  * tag 1.8.0 final on Oct 21st (Sun);
>>>  * go offline on Oct 22nd (Mon); and
>>>  * come back online on Nov 12th (Mon).
>>>
>>> Peff, could you be the interim maintainer as you've done in earlier
>>> years while I was away?
>> 
>> Sure, I look forward to ruling the list with an iron fist...er, helping
>> contributors review their patches.
>
> ...the ironing fist, yeah ;)

For the record, I do not iron every wrinkles out of everybody's
patches.  Anyhow, that is funny ;-)
