From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: a problem with the gitconfig file for user.email
Date: Sun, 13 Mar 2011 23:29:20 +0100
Message-ID: <vpqy64iy7r3.fsf@bauges.imag.fr>
References: <loom.20110313T182907-610@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Guy Maurel <guy-kde@maurel.de>
X-From: git-owner@vger.kernel.org Sun Mar 13 23:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PytnH-0002UE-RA
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 23:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1CMW3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 18:29:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43029 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab1CMW3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 18:29:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2DMTIU5030560
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 13 Mar 2011 23:29:18 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pytmr-0001Vm-5c; Sun, 13 Mar 2011 23:29:21 +0100
In-Reply-To: <loom.20110313T182907-610@post.gmane.org> (Guy Maurel's message
	of "Sun, 13 Mar 2011 17:32:52 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 13 Mar 2011 23:29:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2DMTIU5030560
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300660160.67294@UYLDJq82Txw4WcbShTp35w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168979>

Guy Maurel <guy-kde@maurel.de> writes:

> why is it necessary to have a <TAB> before the email keyword in the [user]
> section?

It isn't. I've just checked with email right at the beginning of the
line, without tab or space, and it works (with the latest git.git).

> If not, one get the error message:
>   fatal: bad config file line 2 in /home/guy-kde/.gitconfig

Please, give a short and reproducible senario (eg. the full content of
.gitconfig, and the command you've typed to get this).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
