From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add arbitrary email headers
Date: Thu, 26 Mar 2009 13:29:34 -0700
Message-ID: <7viqlwm3ip.fsf@gitster.siamese.dyndns.org>
References: <1237996712-61859-1-git-send-email-michael@ndrix.org>
 <7v3ad11kqh.fsf@gitster.siamese.dyndns.org>
 <20090326164212.GF29569@ginosko.ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmwEL-0008Jr-Mb
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869AbZCZU3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758052AbZCZU3k
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:29:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757164AbZCZU3k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 16:29:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 96D4596ED;
	Thu, 26 Mar 2009 16:29:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0AB1496EC; Thu,
 26 Mar 2009 16:29:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4173082-1A44-11DE-89E7-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114815>

Michael Hendricks <michael@ndrix.org> writes:

> Perhaps --add-header is a better name for this argument.  That name at
> least makes it clear that headers specified on the command line are
> cumulative.  If someone has a use case for --no-extra-headers, they
> can add it later and --add-header retains the same meaning.

Sounds very sane.  Thanks.
