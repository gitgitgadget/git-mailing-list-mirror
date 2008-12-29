From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/diff-options.txt: unify options
Date: Mon, 29 Dec 2008 01:10:15 -0800
Message-ID: <7vwsdjcpoo.fsf@gitster.siamese.dyndns.org>
References: <7vvdt4aj0e.fsf@gitster.siamese.dyndns.org>
 <8763l331l6.fsf@jidanni.org> <7vabafe5ai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 29 10:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHE9z-0004Tn-Rx
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbYL2JKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 04:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbYL2JKV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:10:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYL2JKU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 04:10:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BE6C1B48A;
	Mon, 29 Dec 2008 04:10:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1852F1B489; Mon,
 29 Dec 2008 04:10:16 -0500 (EST)
In-Reply-To: <7vabafe5ai.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 29 Dec 2008 00:47:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84307412-D588-11DD-9C0E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104088>

Junio C Hamano <gitster@pobox.com> writes:

> That commentary above your S-o-b is not a proper commit log message, but
> I'll come up with something and apply.

Here is what I came up with and applied.

    Documentation/diff-options.txt: unify options
    
    Instead of listing short option (e.g. "-U<n>") as a shorthand for its
    longer counterpart (e.g. "--unified=<n>"), list the synonyms together.  It
    saves one indirection to find what the reader wants.
    
    Signed-off-by: jidanni <jidanni@jidanni.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
