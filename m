From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Thu, 13 Dec 2007 23:57:09 -0800
Message-ID: <7vr6hpu2sq.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-2-git-send-email-win@wincent.com>
	<1197575138-58070-1-git-send-email-win@wincent.com>
	<20071214045127.GC10169@sigill.intra.peff.net>
	<7vmysdx3la.fsf@gitster.siamese.dyndns.org>
	<7vy7bxu3w5.fsf@gitster.siamese.dyndns.org>
	<5A086A2E-16DB-4A3C-92E6-F879189A87FE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:58:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35Qp-0006FY-JC
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbXLNH5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 02:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbXLNH5Y
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:57:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbXLNH5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 02:57:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1645A50C2;
	Fri, 14 Dec 2007 02:57:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 936B750C0;
	Fri, 14 Dec 2007 02:57:11 -0500 (EST)
In-Reply-To: <5A086A2E-16DB-4A3C-92E6-F879189A87FE@wincent.com> (Wincent
	Colaiuta's message of "Fri, 14 Dec 2007 08:51:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68260>

Wincent Colaiuta <win@wincent.com> writes:

> I'll integrate these (and the other suggestions) some time this  
> morning and post a new version of the series that incorporates all the  
> feedback and patch suggestions.

Heh, I am about to push out fixed-up results, so it might save both of
us some time if you looked at it first and then complained on my
screwups.
