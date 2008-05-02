From: Junio C Hamano <gitster@pobox.com>
Subject: Re: To page or not to page
Date: Thu, 01 May 2008 23:08:00 -0700
Message-ID: <7vhcdhxmpr.fsf@gitster.siamese.dyndns.org>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org>
 <20080502054508.GA28506@sigill.intra.peff.net>
 <7vlk2txn8n.fsf@gitster.siamese.dyndns.org>
 <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri May 02 08:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JroS4-0007g8-5A
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 08:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYEBGIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 02:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYEBGIM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 02:08:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbYEBGIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 02:08:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96DD14F0A;
	Fri,  2 May 2008 02:08:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E3C0C4F08; Fri,  2 May 2008 02:08:04 -0400 (EDT)
In-Reply-To: <8C3474E2-3A4F-44E8-B301-C36939C7BA11@sb.org> (Kevin Ballard's
 message of "Fri, 2 May 2008 02:04:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2425F3C2-180E-11DD-B912-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80961>

Kevin Ballard <kevin@sb.org> writes:

> Is there any good reason to make git-status use the pager? The output
> is very rarely long enough to warrant it, and if I need a pager I can
> always just pipe it to less myself.

I have no motivation to defend that change.  I'll leave that to the
original submitter and list archive ;-)
