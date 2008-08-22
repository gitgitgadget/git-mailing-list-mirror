From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "Convert output messages in merge-recursive to
 past tense."
Date: Fri, 22 Aug 2008 15:37:29 -0700
Message-ID: <7v7ia87k2e.fsf@gitster.siamese.dyndns.org>
References: <1219425524-77545-1-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfHE-0005bB-9q
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 00:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYHVWhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 18:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYHVWhg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 18:37:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbYHVWhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 18:37:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5BC2B64465;
	Fri, 22 Aug 2008 18:37:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 796ED64464; Fri, 22 Aug 2008 18:37:31 -0400 (EDT)
In-Reply-To: <1219425524-77545-1-git-send-email-maillist@steelskies.com>
 (Jonathan del Strother's message of "Fri, 22 Aug 2008 18:18:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA90714C-709A-11DD-8011-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93384>

Jonathan del Strother <maillist@steelskies.com> writes:

> Now that the progress meter is gone, merge messages make more sense when presented in present tense
>
> This reverts commit 89f40be294363ce4d14ed6931a65561a4e8e9140.
>
> Conflicts:
>
> 	builtin-merge-recursive.c
> ---

"Conflicts:"?  Please either remove it or describe how you resolved the
conflicts.

Sign-off?

The patch looked Ok to me.  Shawn?
