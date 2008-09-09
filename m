From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 10:34:10 +0200
Message-ID: <vpq4p4p1zwd.fsf@bauges.imag.fr>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyiV-0007hL-73
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbYIIIfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYIIIfs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:35:48 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:36865 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbYIIIfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:35:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m898YNEk007954;
	Tue, 9 Sep 2008 10:34:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kcyfq-000886-AJ; Tue, 09 Sep 2008 10:34:10 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kcyfq-0001YL-7x; Tue, 09 Sep 2008 10:34:10 +0200
In-Reply-To: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> (Peter Krefting's message of "Tue\, 9 Sep 2008 07\:19\:55 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 09 Sep 2008 10:34:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95356>

Peter Krefting <peter@softwolves.pp.se> writes:

> I find myself tracking OpenOffice files every now and then.

[...]

> I notice, however, that the Git history tend to grow quite a bit,

<shameless ad>
Slightly off-topic answer, since it doesn't solve the disk space
problem, but you can have a look at

  http://www-verimag.imag.fr/~moy/opendocument/

(which lets you use "git diff" on OpenOffice files)
</shameless ad>

-- 
Matthieu
