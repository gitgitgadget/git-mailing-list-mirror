From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/2] grep Added --blame so that grep can show result  tagged with blame entries
Date: Tue, 10 Mar 2009 12:46:55 +0100
Message-ID: <vpq8wnd7g7k.fsf@bauges.imag.fr>
References: <49B51791.4030801@gmail.com>
	<7v7i2xaewh.fsf@gitster.siamese.dyndns.org>
	<1b29507a0903100429v5b4a66d7sa9e3b32010fae2e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: pi.songs@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 10 12:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh0Ue-0001XL-CF
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZCJLuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 07:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZCJLuD
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:50:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:50412 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbZCJLuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:50:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n2ABktdl003107
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Mar 2009 12:46:55 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lh0QB-0002EF-FL; Tue, 10 Mar 2009 12:46:55 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lh0QB-000297-Ck; Tue, 10 Mar 2009 12:46:55 +0100
In-Reply-To: <1b29507a0903100429v5b4a66d7sa9e3b32010fae2e0@mail.gmail.com> (pi song's message of "Tue\, 10 Mar 2009 22\:29\:49 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 10 Mar 2009 12:46:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112808>

pi song <pi.songs@gmail.com> writes:

> OK, I'll move my work to "next" branch. BTW, can anyone tell me what
> the "next" and "pu" branch are for ?

git/Documentation/gitworkflows.txt

In short : next = things that _should_ enter master in the future.
           pu = proposed updates = things that _may_ enter master.

-- 
Matthieu
