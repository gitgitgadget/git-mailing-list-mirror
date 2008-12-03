From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Wed, 03 Dec 2008 12:06:05 -0800
Message-ID: <7v1vwpdnwy.fsf@gitster.siamese.dyndns.org>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu>
 <20081202215157.GB9650@hand.yhbt.net>
 <7vbpvtj4kl.fsf@gitster.siamese.dyndns.org>
 <49365259.5090803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Deskin Miller <deskinm@umich.edu>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7y0t-0006uG-Iz
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 21:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbYLCUGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 15:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757378AbYLCUGQ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 15:06:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757556AbYLCUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 15:06:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3790883615;
	Wed,  3 Dec 2008 15:06:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EFEDD83612; Wed,
  3 Dec 2008 15:06:07 -0500 (EST)
In-Reply-To: <49365259.5090803@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 03 Dec 2008 10:33:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5BB72A4-C175-11DD-BE22-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102282>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Patch coming. (Sorry I always forget the ccs with send-email.)

Thanks, indeed my environment has svn 1.4.2 installed and Deskin's patch
with your patch squashed in makes everything happy again.
