From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Modify description file to say what this file is
Date: Wed, 04 Mar 2009 02:01:54 -0800
Message-ID: <7v7i357gj1.fsf@gitster.siamese.dyndns.org>
References: <200902190736.00462.johnflux@gmail.com>
 <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
 <43d8ce650903032307i512268f4sa3240c517b51d0b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:03:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lenws-0003Ol-SJ
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZCDKCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbZCDKCD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:02:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63093 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZCDKCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:02:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C28623B2D;
	Wed,  4 Mar 2009 05:01:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 354A53B2C; Wed, 
 4 Mar 2009 05:01:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7FFE29D6-08A3-11DE-8D9A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112195>

John Tapsell <johnflux@gmail.com> writes:

> Hi Junio,
>   Did you commit my patches?  I don't see them yet in git.git ?

Please look for them in the 'next' branch.

Patches that came after -rc1 are at best queued in 'next' for post 1.6.2.
The only exceptions are critical and obvious fixes, and fixes to
regressions introduced since 1.6.1.
