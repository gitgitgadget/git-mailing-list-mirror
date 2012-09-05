From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Renaming a remote is 'rename', but removing is 'rm'
Date: Wed, 05 Sep 2012 13:13:47 +0200
Message-ID: <vpqr4qg2044.fsf@bauges.imag.fr>
References: <1346831961-ner-2892@calvin>
	<CACsJy8Bi=b1Fuht8q5XcnGE3rFAVojj+MAXvKZAnrqseYnDy+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 13:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9DYY-0006LO-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab2IELN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:13:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43476 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab2IELNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 07:13:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q85B9goM014894
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2012 13:09:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1T9DYK-0001Y5-FC; Wed, 05 Sep 2012 13:13:48 +0200
In-Reply-To: <CACsJy8Bi=b1Fuht8q5XcnGE3rFAVojj+MAXvKZAnrqseYnDy+g@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 5 Sep 2012 15:49:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 05 Sep 2012 13:09:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q85B9goM014894
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347448183.93283@1KxDYKKAA1uX/7e3NBUClQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204812>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Looking at the remote command list, "rm" is the only abbreviation. I
> guess we should add "delete" (or "remove") as an alias for "rm".

I'd vote for "remove", to make it clear that "rm" is the abbreviation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
