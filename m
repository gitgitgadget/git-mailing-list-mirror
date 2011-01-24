From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: First time gitr - have some questions
Date: Mon, 24 Jan 2011 21:55:14 +0100
Message-ID: <vpq39oit425.fsf@bauges.imag.fr>
References: <1295893245907-5956101.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: toltmanns <toltmanns@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 21:55:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhTRe-0003mI-CR
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 21:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1AXUzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 15:55:20 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52769 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671Ab1AXUzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 15:55:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p0OKtCac020557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jan 2011 21:55:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PhTRS-0005p7-D6; Mon, 24 Jan 2011 21:55:14 +0100
In-Reply-To: <1295893245907-5956101.post@n2.nabble.com> (toltmanns@gmail.com's message of "Mon\, 24 Jan 2011 10\:20\:45 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Jan 2011 21:55:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0OKtCac020557
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296507315.17426@cU3Qo+TdIkgVAvcRKSdy2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165458>

toltmanns <toltmanns@gmail.com> writes:

> First off, I may be in the wrong place, but I need a sanity check here.
>
> I've downloaded and am attempting to use the git bash app, trying to issue
> the following command and am getting fatal: Not a git repository
>
> git submodule add git@github.com:toltmanns/steal.git public/steal

> I went through directions here -
> http://www.javascriptmvc.com/docs/getstarted.html#&who=install

That page says, just above the command you're trying:

  "You want to fork each project and add it as a submodule to your
   project"

which you should read as

  "At this point, you should have a Git project (i.e. repository) of
  your own, and you can add our projects as subprojects of yours"

which probably implies that you should read some Git tutorial to learn
how to deal with your own project before trying to understand
submodules ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
