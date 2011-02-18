From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: an error when using 'git send-email'
Date: Fri, 18 Feb 2011 14:51:08 +0100
Message-ID: <vpq7hcxsb77.fsf@bauges.imag.fr>
References: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yongqiang Yang <xiaoqiangnk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 14:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqQmR-0001H1-6T
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 14:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab1BRNxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 08:53:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:50194 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab1BRNxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 08:53:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1IDp8Hl015785
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 Feb 2011 14:51:09 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PqQjk-0003wh-SC; Fri, 18 Feb 2011 14:51:08 +0100
In-Reply-To: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com> (Yongqiang Yang's message of "Fri\, 18 Feb 2011 19\:45\:32 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 18 Feb 2011 14:51:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167209>

Yongqiang Yang <xiaoqiangnk@gmail.com> writes:

> Hello All,
>
> When I use git 'send-email', I get an error "Command unknown:  'AUTH'
> at /usr/bin/git-send-email line 775, <STDIN> line 1".
> Is there anyone meet the same error?

Not me.

Can you give the exact command you're using? Which OS? Which Git
version? If possible, tell us what's on line 775 of
/usr/bin/git-send-email

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
