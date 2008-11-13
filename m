From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the period after the git-check-attr summary
Date: Wed, 12 Nov 2008 18:15:22 -0800
Message-ID: <7vprl0jrr9.fsf@gitster.siamese.dyndns.org>
References: <1226060815-7548-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 03:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Rlf-0004aT-6O
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 03:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYKMCPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 21:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYKMCPv
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 21:15:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYKMCPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 21:15:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B4407C8A6;
	Wed, 12 Nov 2008 21:15:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 518EB7C89E; Wed,
 12 Nov 2008 21:15:29 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA87B708-B128-11DD-A333-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100842>

Matt Kraai <kraai@ftbfs.org> writes:

> The period at the end of the git-check-attr summary causes there to be
> two periods after the summary in the git(1) manual page.
>
> Signed-off-by: Matt Kraai <kraai@ftbfs.org>

Thanks.  I think what you wrote after the --- marker is a perfect
justification of this change, so I lifted them up.
