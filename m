From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-format-patch patch
Date: Thu, 18 Dec 2008 00:42:43 -0800
Message-ID: <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
References: <877i5yy149.fsf@jidanni.org>
 <20081218083515.GB29356@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDEUM-0004Px-O4
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbYLRImv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbYLRImv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:42:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbYLRImu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:42:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 980F988541;
	Thu, 18 Dec 2008 03:42:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAB0F88540; Thu,
 18 Dec 2008 03:42:45 -0500 (EST)
In-Reply-To: <20081218083515.GB29356@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 18 Dec 2008 03:35:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9E01B08-CCDF-11DD-9262-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103448>

Jeff King <peff@peff.net> writes:

> ... Besides the format not being applicable by regular git tools:
>
>  - there is no commit message describing the changes, nor the reasoning
>    behind them
>
>  - it was not sent to the maintainer (who does read the list, but does
>    not always read every message).

Actually, it would probably be a good idea not to send your first patch to
me and instead to request for comments from the list ;-)n

The worst offence of the message was the choice of bad Subject that
strongly encouraged anyone to skip it.  Consider:

	Subject: [PATCH] document "format-patch --in-reply-to" better

or something like that.
