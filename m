From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 17:02:54 +0200
Message-ID: <vpq39fi9gf5.fsf@bauges.imag.fr>
References: <1316960136073-6829212.post@n2.nabble.com>
	<1316961212.4388.5.camel@centaur.lab.cmartin.tk>
	<7vaa9r2jii.fsf@alter.siamese.dyndns.org>
	<1317073309.5579.9.camel@centaur.lab.cmartin.tk>
	<e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 17:03:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ZCG-0006f2-QM
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 17:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab1I0PDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 11:03:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34675 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1I0PDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 11:03:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p8RF0tx8031283
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 27 Sep 2011 17:00:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R8ZBO-0005QO-Mz; Tue, 27 Sep 2011 17:02:54 +0200
In-Reply-To: <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> (Michael
	Witten's message of "Tue, 27 Sep 2011 14:43:55 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 27 Sep 2011 17:00:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8RF0tx8031283
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1317740457.44173@2e3OaQ6xPCxXZpTat6n5fA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182241>

Michael Witten <mfwitten@gmail.com> writes:

> +	Tell git to make the next commit you make a root commit

I'd even add 

  (just like the first commit after "git init")

at this point.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
