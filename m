From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC/WIP 1/2] Documentation: fix minor inconsistency
Date: Mon, 23 Mar 2009 15:44:09 +0100
Message-ID: <vpq7i2g9u4m.fsf@bauges.imag.fr>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
	<1237818533-31577-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllSz-0004VP-Nu
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbZCWOry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbZCWOrx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:47:53 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:45823 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756655AbZCWOrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:47:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2NEiEr6005990;
	Mon, 23 Mar 2009 15:44:14 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LllNp-00059t-H9; Mon, 23 Mar 2009 15:44:09 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LllNp-0004OV-Em; Mon, 23 Mar 2009 15:44:09 +0100
In-Reply-To: <1237818533-31577-2-git-send-email-git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 23 Mar 2009 15\:28\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 23 Mar 2009 15:44:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114321>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> While we don't always write out commands in full (`git command`) we
> should do it consistently in adjacent paragraphs.

> -	If set to true or "refuse", receive-pack will deny a ref update
> +	If set to true or "refuse", git-receive-pack will deny a ref update

Then, shouldn't this be `git receive-pack` ?

-- 
Matthieu
