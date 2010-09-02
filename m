From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH for next] insert missing newline in a diagnostic
Date: Thu, 02 Sep 2010 10:42:54 +0200
Message-ID: <vpq8w3klenl.fsf@bauges.imag.fr>
References: <87iq2s4ewn.fsf@meyering.net> <20100901001729.GG6747@burratino>
	<vpqeide0zkx.fsf@bauges.imag.fr> <87lj7kimjy.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:46:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5RP-0006jC-OW
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593Ab0IBIqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:46:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:41201 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab0IBIqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 04:46:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o828gtJs004296
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 2 Sep 2010 10:42:55 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Or5Nn-00033n-72; Thu, 02 Sep 2010 10:42:55 +0200
In-Reply-To: <87lj7kimjy.fsf@meyering.net> (Jim Meyering's message of "Thu\, 02 Sep 2010 10\:20\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 02 Sep 2010 10:42:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155112>

Jim Meyering <jim@meyering.net> writes:

>> Patch follows, untested. Jim, can you tell us whether it fixes the
>> problem? If not, can your give us a reproduction script (preferably as
>> a patch to t7609-merge-co-error-msgs.sh)?
>
> Matthieu, should your patch have gone to the mailing list?
> I do not see it there.

http://article.gmane.org/gmane.comp.version-control.git/155016

Junio replied to it, so it must have gone through ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
