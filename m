From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 10:34:59 +0200
Message-ID: <vpqbpomey8c.fsf@bauges.imag.fr>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHD5m-0007Dd-Fl
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZFRIfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZFRIfT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:35:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35705 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816AbZFRIfS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:35:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n5I8TkNx019377
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2009 10:29:46 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MHD5H-0001Uo-IT; Thu, 18 Jun 2009 10:34:59 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MHD5H-000392-G0; Thu, 18 Jun 2009 10:34:59 +0200
In-Reply-To: <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> (Johannes Schindelin's message of "Thu\, 18 Jun 2009 10\:06\:07 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 18 Jun 2009 10:29:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n5I8TkNx019377
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1245918587.53827@mHq2K06Uo7Xj/45k606TJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121816>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd really rather stay with "fixup".

I like fixup. I'd say "fixup: <message>" so that the thing actually
looks like a program directive rather than natural language.

(I disliked this at first, but I may actually like it if it gets into
Git!)

-- 
Matthieu
