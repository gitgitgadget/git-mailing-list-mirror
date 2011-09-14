From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 17:42:25 +0200
Message-ID: <vpqhb4f5dwe.fsf@bauges.imag.fr>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
	<CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
	<CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
	<4E7085E6.3060509@alum.mit.edu> <vpqfwjzxu6i.fsf@bauges.imag.fr>
	<CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 17:42:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3rbq-0000cx-E0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 17:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756817Ab1INPml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 11:42:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49790 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004Ab1INPml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 11:42:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8EFewEr031182
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2011 17:40:58 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R3rbV-0002Vv-MD; Wed, 14 Sep 2011 17:42:25 +0200
In-Reply-To: <CA+55aFyGRM132OzoJR7wZ8wETvxrFWSmSMjMJnVOKP+6vys-Sw@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 14 Sep 2011 08:27:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Sep 2011 17:40:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8EFewEr031182
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316619659.71027@7Oaz20vrL4GU3eRh2CRymA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181364>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Sep 14, 2011 at 4:03 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>> Would the notes mechanism be able to annotate ref names instead of
>> commit sha1?
>
> That would be a horrible, horrible notion.
>
> It's quite common to have multiple branches with the same SHA1. 

That's why my question was about annotating ref _names_, yes. As Johan
Herland pointed out, this would be possible in theory, but not really in
practice.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
