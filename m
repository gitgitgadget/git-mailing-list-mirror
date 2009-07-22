From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How has learning the advanced features of git helped you to
 write  software more effectively?
Date: Wed, 22 Jul 2009 14:55:22 -0700
Message-ID: <7v1vo8e62d.fsf@alter.siamese.dyndns.org>
References: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjmg-0001AD-Lh
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZGVVz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbZGVVz1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:55:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbZGVVz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:55:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41C031004A;
	Wed, 22 Jul 2009 17:55:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F22510049; Wed,
 22 Jul 2009 17:55:23 -0400 (EDT)
In-Reply-To: <e1a5e9a00907221421m27f0f836t98d361dffc7bd87f@mail.gmail.com>
 (Tim Harper's message of "Wed\, 22 Jul 2009 15\:21\:26 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DAB6350-770A-11DE-B79F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123792>

Tim Harper <timcharper@gmail.com> writes:

> Out of the shoot, you get a lot of value learning the basic features
> of git: easy branching, merging, etc.  How has learning the advanced
> features of git (bisect, rebase, rebase -i, add -p, etc.) helped you
> to write software more effectively?

Git does not have much if anything to do with writing software more
effectively.  Crappy programmers can create (and have created I am sure)
clean history that is easy to understand how tons of bugs have been
carried forward, and you can side port the bugs with ease across branches
in such a history.
