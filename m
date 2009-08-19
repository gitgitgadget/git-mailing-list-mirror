From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 10:25:30 +0200
Message-ID: <vpqvdkkus5h.fsf@bauges.imag.fr>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
	<alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: D Sundstrom <sunds@peapod.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdgUM-0000dj-6J
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 10:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbZHSIZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 04:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZHSIZi
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 04:25:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54979 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbZHSIZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 04:25:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7J8Mi8r012823
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Aug 2009 10:22:44 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdgU6-0002Wr-2G; Wed, 19 Aug 2009 10:25:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdgU6-0000nf-0w; Wed, 19 Aug 2009 10:25:30 +0200
In-Reply-To: <alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302> (Johannes Schindelin's message of "Wed\, 19 Aug 2009 09\:49\:50 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2009 10:22:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7J8Mi8r012823
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251274966.6389@K1qTDvC8wZCPYt1mi/X3cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126517>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Then you have a bunch of people who do not want to care about learning 
> proper version control.

OTOH, my experience with non-technical people and revision control is:
they send you an email with the file attached, saying they promise
they will learn the tool one day, but not right now because they don't
have time, and then you have to find out how to merge and commit
yourself.

And unfortunately (also from my experience), this is not limited to
non-technical people ...

For this category of people, a simple web-based commit tool will not
teach them anything (which is bad), but at least reduces the work of
the technical guys (which is somehow good).

-- 
Matthieu
