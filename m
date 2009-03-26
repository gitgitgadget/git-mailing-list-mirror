From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Documentation: XSLT/asciidoc.conf cleanup; tty
 literals
Date: Thu, 26 Mar 2009 01:59:18 -0700
Message-ID: <7vvdpwpsm1.fsf@gitster.siamese.dyndns.org>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmlSS-0001xT-8p
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbZCZI73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 04:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757310AbZCZI72
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 04:59:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbZCZI70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 04:59:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4700D9F53;
	Thu, 26 Mar 2009 04:59:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D0FB9F51; Thu,
 26 Mar 2009 04:59:20 -0400 (EDT)
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
 (Chris Johnsen's message of "Tue, 24 Mar 2009 03:04:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 673A6A84-19E4-11DE-9E2A-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114752>

Chris Johnsen <chris_johnsen@pobox.com> writes:

> I had a go at wrangling with the documentation generation tools
> to fix a couple of issues that I had noticed.

Thanks.  I noticed that between you and Jeff there were some more
improvements discussed, but I tried this round (queued in 'pu') and the
results lost those infamous ".ft", which is very good ;-)

I also noticed you have a two-patch series to quiet the documentation
building procedure, but didn't queue after seeing you had "oops".

I am looking forward to seeing v2 of both series.  Thanks.

And thanks, Jeff, for helping to get these series into shape.
