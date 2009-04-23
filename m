From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Documentation: git-svn: fix spurious bolding that
 mangles the output
Date: Wed, 22 Apr 2009 21:21:12 -0700
Message-ID: <7vy6tsxao7.fsf@gitster.siamese.dyndns.org>
References: <20090422151515.GA12370@coredump.intra.peff.net>
 <1240415338-18076-1-git-send-email-wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Jeff King <peff@peff.net>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 06:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwqSX-0005xN-PL
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 06:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbZDWEVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 00:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbZDWEVU
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 00:21:20 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZDWEVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 00:21:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A5BE114F5;
	Thu, 23 Apr 2009 00:21:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 45E31114F0; Thu,
 23 Apr 2009 00:21:14 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 319C9434-2FBE-11DE-8DAB-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117292>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> Without this fix, the output looks like:
>
> "Keep in mind that the  (asterisk) wildcard of the local ref (right of
> the :) *must be the ..." -- with half the sentence spuriously bold.
>
> This fixes the problem by simply escaping asciidoc syntax as suggested
> by Jeff King <peff@peff.net>.
>
> Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>

Thanks, both.
