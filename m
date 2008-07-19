From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sat, 19 Jul 2008 15:00:20 -0700
Message-ID: <7v8wvxzg97.fsf@gitster.siamese.dyndns.org>
References: <20080719174742.GA4253@2ka.mipt.ru>
 <7vfxq521ab.fsf@gitster.siamese.dyndns.org>
 <7v8wvx211n.fsf@gitster.siamese.dyndns.org>
 <20080719195909.GA5093@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-From: git-owner@vger.kernel.org Sun Jul 20 00:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKKUd-00013T-8j
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 00:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYGSWAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbYGSWAc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 18:00:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYGSWAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 18:00:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92B6837B66;
	Sat, 19 Jul 2008 18:00:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1822A37B64; Sat, 19 Jul 2008 18:00:27 -0400 (EDT)
In-Reply-To: <20080719195909.GA5093@2ka.mipt.ru> (Evgeniy Polyakov's message
 of "Sat, 19 Jul 2008 23:59:09 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A73D5F2-55DE-11DD-9E14-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89137>

Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:

> I posted it so it would be stored in archive, that old enough git
> version does not work with recent trees, so one should upgrade if this
> error occures.

Thanks, but you are about 5 days too late ;-)

    http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=88402
