From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On "git status"
Date: Fri, 24 Apr 2009 14:45:40 +0200
Message-ID: <vpq3abygqyz.fsf@bauges.imag.fr>
References: <49F1BD85.16747.5FBF6DC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<49F1A51C.40704@drmicha.warpmail.net>
	<49F1CF2F.16472.640F8D0@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Apr 24 14:50:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKqz-0005Ch-0K
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757123AbZDXMsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbZDXMsc
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:48:32 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:41220 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbZDXMsb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 08:48:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n3OCjm0m005762;
	Fri, 24 Apr 2009 14:45:48 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LxKmi-0004hK-Qp; Fri, 24 Apr 2009 14:45:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LxKmi-0003wu-PP; Fri, 24 Apr 2009 14:45:40 +0200
In-Reply-To: <49F1CF2F.16472.640F8D0@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Fri\, 24 Apr 2009 14\:39\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 24 Apr 2009 14:45:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117433>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> OK, so many commands to learn.... Still shouldn't "git status --help" be able to 
> display some help text (other than "man page not found")?

It is. You, or your distro, miss-installed it (maybe "make
install-doc" ?)

-- 
Matthieu
