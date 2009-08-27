From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jh/cvs-helper 0/2] Fix building when python is not
 available
Date: Thu, 27 Aug 2009 14:46:13 -0700
Message-ID: <7v3a7dorq2.fsf@alter.siamese.dyndns.org>
References: <Rxz2NOwzg1UZ0TgAtOhrA7e8wE02XwcSzNC9cc1EL_W_oN1BjtZn8ClmG5zKB_DKmTgVP0PlMYI@cipher.nrlssc.navy.mil> <200908271857.47035.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgmne-0005Zt-Ht
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbZH0VqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbZH0VqV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:46:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbZH0VqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:46:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20C4B39B87;
	Thu, 27 Aug 2009 17:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PsNeSaQQ1lIWfSBwffMNqoEZ/P0=; b=XT2Vro
	P0UV0rOrz7r+XEjPxuJxYkotcnYtFqFx91rmOA5TuOlgDPPjgtnKzp73t+6Jm1VE
	g3hC2QH3se3EA9ZopMum56mnRm7xMuD/qpxfHh5hXQrkVoSxyAPGralFy3H+ph0R
	+Do4KSCDAJNq/huHYaWYXts/+u3vLB/+7ZGXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NrQo+iztFAl+6yV3CmlcYYKGmNU3gYI5
	09SrMB+9it4CMzv24l2fPamxBKWan4gQJtg6F1D6Jb+CqORSd5PxNZfHTW7jbi2Y
	ssRa+8VX6zrnTB+IcE8Eut5d1VlrJb5A9sIkdWg6tMgzUBB1Iup0XEu+KSmIpRdc
	7uwrPD2YCDQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E753C39B86;
	Thu, 27 Aug 2009 17:46:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74A2A39B85; Thu, 27 Aug 2009
 17:46:15 -0400 (EDT)
In-Reply-To: <200908271857.47035.johan@herland.net> (Johan Herland's message
 of "Thu\, 27 Aug 2009 18\:57\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0E49E1C8-9353-11DE-9297-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127219>

Johan Herland <johan@herland.net> writes:

> Thanks. Both are
>
> Acked-by: Johan Herland <johan@herland.net>
>
> I'll fold these into the next iteration of jh/cvs-helper.

Thanks, both.  Then I'll ignore this thread and simply wait for the next
round from you.
