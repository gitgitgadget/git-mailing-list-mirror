From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 13:03:17 +0200
Message-ID: <vpqfwjzxu6i.fsf@bauges.imag.fr>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
	<CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
	<CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
	<4E7085E6.3060509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 14 13:03:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3nFk-0008Oh-IK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 13:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486Ab1INLDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 07:03:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46121 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756428Ab1INLDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 07:03:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8EB1p9l010358
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2011 13:01:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R3nFN-0003UU-Hh; Wed, 14 Sep 2011 13:03:17 +0200
In-Reply-To: <4E7085E6.3060509@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 14 Sep 2011 12:45:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Sep 2011 13:01:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8EB1p9l010358
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316602914.54273@r1fpmpUMatIKi0FMtpRKSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181351>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I wish that one could annotate a branch (e.g., at creation) and have the
> annotation follow the branch around.  This would be a useful place to
> record *why* you created the branch, your plans for it, etc.  The
> annotation should be modifiable, because often a branch evolves in
> unforeseen ways during its lifetime.  Anybody could read the annotation
> to get a quick idea of what kind of work is in progress.

Would the notes mechanism be able to annotate ref names instead of
commit sha1?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
