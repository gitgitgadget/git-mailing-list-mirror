From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-rm: Add a --force flag
Date: Fri, 08 Aug 2008 16:05:16 -0700
Message-ID: <7v8wv7az0z.fsf@gitster.siamese.dyndns.org>
References: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRb2c-0003UK-VH
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764310AbYHHXF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 19:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764254AbYHHXFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 19:05:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764111AbYHHXFY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 19:05:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E2D5D5188A;
	Fri,  8 Aug 2008 19:05:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 23E3C51888; Fri,  8 Aug 2008 19:05:18 -0400 (EDT)
In-Reply-To: <1218235022-33695-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sat, 9 Aug 2008 00:37:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A20B6EE-659E-11DD-BFB6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91725>

I think this makes sense even this late in -rc cycle.  Thanks.
