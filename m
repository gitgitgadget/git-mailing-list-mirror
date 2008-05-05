From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Better error message for git svn dcommit on empty repository.
Date: Mon, 05 May 2008 11:13:47 +0200
Message-ID: <vpqve1txgdw.fsf@bauges.imag.fr>
References: <20080429071552.GH24171@muzzle>
	<1209975508-9998-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswwy-0000br-55
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbYEEJYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755887AbYEEJYr
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:24:47 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:51539 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332AbYEEJYq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:24:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m459NDbA028654;
	Mon, 5 May 2008 11:23:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JswlX-0002ZO-4l; Mon, 05 May 2008 11:13:47 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JswlX-0002vT-2d; Mon, 05 May 2008 11:13:47 +0200
In-Reply-To: <1209975508-9998-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Mon\,  5 May 2008 10\:18\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 05 May 2008 11:23:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81261>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Ideally, git-svn should be able to do the initial commit, but since it
> isn't, this patch makes it give an accurate error message.

Oops, I just noticed that the patch had already been applied.

Sorry for the noise.

-- 
Matthieu
