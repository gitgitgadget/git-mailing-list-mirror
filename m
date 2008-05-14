From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Documentation/git-gc.txt: change --aggressive description
Date: Wed, 14 May 2008 09:48:35 +0200
Message-ID: <vpqd4npz5po.fsf@bauges.imag.fr>
References: <1210672413-8761-1-git-send-email-pdebie@ai.rug.nl>
	<alpine.DEB.1.00.0805131251320.30431@racer>
	<FCA89971-FDBB-4E44-82CE-C0AA854A4667@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed May 14 09:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwBlU-0002cp-HA
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 09:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYENHuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 03:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYENHuS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 03:50:18 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:54969 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbYENHuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 03:50:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m4E7nP5b022226;
	Wed, 14 May 2008 09:49:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JwBj1-0008Bq-Gt; Wed, 14 May 2008 09:48:35 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JwBj1-0001ME-D7; Wed, 14 May 2008 09:48:35 +0200
In-Reply-To: <FCA89971-FDBB-4E44-82CE-C0AA854A4667@ai.rug.nl> (Pieter de Bie's message of "Wed\, 14 May 2008 08\:48\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 14 May 2008 09:49:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82083>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> How about dropping the last sentence ("Using --aggressive only makes
> sense if you have a badly packed repository, such as created by git- 
> fast-import.") then?

I think informing the user that git-fast-import may require
--aggressive is good. Actually, I like the sentence as it is (the
"such as" makes it clear that it's not the /only/ case where it can be
required).

My 2cts,

-- 
Matthieu
