From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git-merge-stupid
Date: Thu, 03 Jul 2008 16:54:31 -0700
Message-ID: <7v4p76y154.fsf@gitster.siamese.dyndns.org>
References: <20080703123314.GS4729@genesis.frugalware.org>
 <alpine.LFD.1.10.0807030947360.18105@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYeI-0002wB-4z
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbYGCXyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbYGCXyl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:54:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYGCXyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:54:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E19C612DBD;
	Thu,  3 Jul 2008 19:54:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4304812DBC; Thu,  3 Jul 2008 19:54:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 65C2F680-495B-11DD-8A5A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87339>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, see above. I think there's a reason why -stupid isn't even worth 
> documenting. It might be better off just removed.

It is called stupid for a reason ;-).

It has been sitting there as an example for a long time, and I do
not think anybody minds removing it.
