From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Tue, 19 Aug 2008 15:35:01 +0200
Message-ID: <vpqej4lcem2.fsf@bauges.imag.fr>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
	<20080819132803.GA26201@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVRT4-0006ls-Iy
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYHSNkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYHSNkq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:40:46 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:39088 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbYHSNkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:40:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7JDdbtG018387;
	Tue, 19 Aug 2008 15:39:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KVRMT-0000dy-TU; Tue, 19 Aug 2008 15:35:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KVRMT-0006bc-R4; Tue, 19 Aug 2008 15:35:01 +0200
In-Reply-To: <20080819132803.GA26201@laptop> (Nguyen Thai Ngoc Duy's message of "Tue\, 19 Aug 2008 20\:28\:03 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 19 Aug 2008 15:39:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92858>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Bash completion needs to know what strategies git supports. Maybe
> other similar tools have the same demand. So add 
> "git merge--show-strategies"
            ^^

Silly detail, but a space is missing here.

-- 
Matthieu
