From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] git-submodule: New subcommand 'summary' (2) -
 show commit summary
Date: Wed, 05 Mar 2008 20:10:24 -0800
Message-ID: <7v3ar4lcgf.fsf@gitster.siamese.dyndns.org>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
 <1204481710-29791-2-git-send-email-pkufranky@gmail.com>
 <7vk5kgiv0v.fsf@gitster.siamese.dyndns.org>
 <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 05:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7S2-0006u6-Nl
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbYCFEKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYCFEKn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:10:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbYCFEKm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 23:10:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CF0BD1C82;
	Wed,  5 Mar 2008 23:10:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 35AC11C81; Wed,  5 Mar 2008 23:10:34 -0500 (EST)
In-Reply-To: <46dff0320803051816x5b957da0m6396d31cad8b4116@mail.gmail.com>
 (Ping Yin's message of "Thu, 6 Mar 2008 10:16:23 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76316>

"Ping Yin" <pkufranky@gmail.com> writes:

> ... I think showing 2 (the head and tail one) should make more sense
> since the head one would be "Initial add ..." in many cases which
> doesn't make much sense for the user.

Why would you want to see the bottom one?  I still don't understand.

And I do not mean this as a rhetorical question.  I am here to learn and
I would like to make sure that I do not make a suggestion based on wrong
understanding of what the user wants to see.

I probably am lacking imagination to think of a good use scenario that
showing the bottom one would be useful to the user, and you as the author
of this patch must thought about what the user want much more than me.


