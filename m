From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: User manual: "You cannot check out these remote-tracking branches"
Date: Tue, 19 Oct 2010 22:52:53 +0200
Message-ID: <vpqy69trjkq.fsf@bauges.imag.fr>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
	<20101019175103.GA28847@kytes> <20101019182845.GE25139@burratino>
	<AANLkTi=DXH1WwGJ-h6s3dFfWZZ3tpu_jQgV1Y9O7c6Xf@mail.gmail.com>
	<0B20EFC4-E613-4D4A-B4F8-8B1750AA8AFD@gmail.com>
	<20101019190416.GH25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 22:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8JBI-0001e9-IG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 22:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab0JSUxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 16:53:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42242 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757486Ab0JSUxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 16:53:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9JKkoRs026805
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Oct 2010 22:46:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P8JB0-0006ds-2e; Tue, 19 Oct 2010 22:52:54 +0200
In-Reply-To: <20101019190416.GH25139@burratino> (Jonathan Nieder's message of "Tue\, 19 Oct 2010 14\:04\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 19 Oct 2010 22:46:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9JKkoRs026805
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288126015.76229@7tz4pA72Dyoa96fWErdQ1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159363>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -You cannot check out these remote-tracking branches, but you can
> -examine them on a branch of your own, just as you would a tag:
> +You might want to build on one of these remote-tracking branches
> +on a branch of your own, just as you would a tag:

Shouldn't this be "just as you would _for_ a tag"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
