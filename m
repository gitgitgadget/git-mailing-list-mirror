From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Mon, 11 Aug 2008 13:39:19 -0700
Message-ID: <7vljz3wako.fsf@gitster.siamese.dyndns.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch>
 <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
 <200808102331.55385.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:40:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeC3-0000AQ-VV
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbYHKUj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYHKUj1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:39:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbYHKUj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:39:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 52EAB5569A;
	Mon, 11 Aug 2008 16:39:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D94655699; Mon, 11 Aug 2008 16:39:21 -0400 (EDT)
In-Reply-To: <200808102331.55385.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun, 10 Aug 2008 23:31:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9608436A-67E5-11DD-8E05-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91994>

Thomas Rast <trast@student.ethz.ch> writes:

> [1] I still think "touching" was a pretty neat idea ;-)

Actually, I felt it was a horrible wording, because the first association
I got from the word was with "emotionally moved", and not about !TREESAME
which is "Does the commit modify the specified paths?" at all.
