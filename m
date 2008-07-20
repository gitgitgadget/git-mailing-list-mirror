From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 14:05:30 -0700
Message-ID: <7vsku44679.fsf@gitster.siamese.dyndns.org>
References: <20080720205125.GP10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKg8n-0002sw-Sp
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYGTVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYGTVFi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:05:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbYGTVFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:05:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C86DC34086;
	Sun, 20 Jul 2008 17:05:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8FD6A34083; Sun, 20 Jul 2008 17:05:32 -0400 (EDT)
In-Reply-To: <20080720205125.GP10347@genesis.frugalware.org> (Miklos Vajna's
 message of "Sun, 20 Jul 2008 22:51:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99067994-569F-11DD-B34F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89232>

Miklos Vajna <vmiklos@frugalware.org> writes:

> So here is what I thought about: What about if everyone (except Junio,
> of course) would change the subject _and_ remove the In-Reply-To: header
> when replying to those mails?
>
> If those large threads just annoys a few people and most people are
> happy with the current situation then sorry for the noise.

I could make "What's cooking" not a follow-up to the previous issue, or
perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.

But I think it is a good idea to change the subject when responding to one
part of the message to say which topic your response is about.

I do not know if stripping "In-reply-to" is a great idea, though.  They
are responses, aren't they?
