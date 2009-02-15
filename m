From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] send-email: --suppress-cc improvements
Date: Sun, 15 Feb 2009 02:47:16 -0800
Message-ID: <7vprhkm0y3.fsf@gitster.siamese.dyndns.org>
References: <7vzlgpzfru.fsf@gitster.siamese.dyndns.org>
 <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
 <200902142321.22904.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 15 11:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYeYN-0007vE-0c
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 11:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbZBOKrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbZBOKrX
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 05:47:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZBOKrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 05:47:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 34BC22B2C8;
	Sun, 15 Feb 2009 05:47:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B24E2B2C2; Sun,
 15 Feb 2009 05:47:18 -0500 (EST)
In-Reply-To: <200902142321.22904.trast@student.ethz.ch> (Thomas Rast's
 message of "Sat, 14 Feb 2009 23:21:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 06421D3A-FB4E-11DD-BA22-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109991>

Thomas Rast <trast@student.ethz.ch> writes:

> I just noticed that I lost the comments after '---' due to repeated
> format-patch'ing, so here goes:

Thanks; Jay did another round of updates based on this one, which
I think is the one I took, if I did things correctly ;-)
