From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Tue, 09 Sep 2008 09:02:42 -0700
Message-ID: <7vtzcp71el.fsf@gitster.siamese.dyndns.org>
References: <20080908135244.GB27550@josefsipek.net>
 <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com>
 <20080908184322.GE27550@josefsipek.net>
 <36ca99e90809081150v4ad6e7a0n72b5cca39e02b1bc@mail.gmail.com>
 <7vmyiifnwa.fsf@gitster.siamese.dyndns.org> <48C64B8B.5000606@fastmail.fm>
 <48C673CF.2000107@fastmail.fm> <7vd4jd8i9b.fsf@gitster.siamese.dyndns.org>
 <48C698DF.7010401@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Josef 'Jeff' Sipek <jeffpc@josefsipek.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, Brandon Philips <brandon@ifup.org>
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd5hN-0003Eq-Ts
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 18:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbYIIQDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 12:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbYIIQDE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 12:03:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbYIIQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 12:03:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A126D5A742;
	Tue,  9 Sep 2008 12:03:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C8E65A72F; Tue,  9 Sep 2008 12:02:45 -0400 (EDT)
In-Reply-To: <48C698DF.7010401@fastmail.fm> (Michael J. Gruber's message of
 "Tue, 09 Sep 2008 17:40:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6C59D54-7E88-11DD-AE70-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95402>

Michael J Gruber <michaeljgruber+gmane@fastmail.fm> writes:

> I keep hearing this argument, and I'm even more surprised to hear it
> right after a major release. If not now then when's a good time for
> cleaning up confusing inconsistencies?

Actually, after a major release is the worst time to push for such an
agenda.

Especially when that release burned the maintainer with numerous complains
against a major change in it, that has been advertised for a long time,
which was pushed by other people for no good reason other than "such a
clean-up would make things much tidier".

Grrr ;-).
