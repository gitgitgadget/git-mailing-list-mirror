From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: from local to github
Date: Tue, 01 Sep 2009 08:14:46 +0200
Message-ID: <vpq1vmr5gyx.fsf@bauges.imag.fr>
References: <48b054040908311346y853b917l44a7e5d4310501b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sigbackup <sigbackup@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiMe2-0005Q3-JT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 08:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZIAGOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 02:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbZIAGOw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 02:14:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37507 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbZIAGOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 02:14:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n816BND6001553
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Sep 2009 08:11:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MiMdi-00027Q-Hv; Tue, 01 Sep 2009 08:14:46 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MiMdi-0001Qh-Fk; Tue, 01 Sep 2009 08:14:46 +0200
In-Reply-To: <48b054040908311346y853b917l44a7e5d4310501b@mail.gmail.com> (sigbackup@gmail.com's message of "Mon\, 31 Aug 2009 13\:46\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Sep 2009 08:11:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n816BND6001553
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252390284.87586@jLj0fARPEAaf8YDJotccRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127523>

sigbackup <sigbackup@gmail.com> writes:

> Hello guys,
> I'm a git newbie and I'm looking for some good references about using
> git locally (on Mac) and synchronize my repositories to my github
> account and from there to a Win2003 production server.

github probably told you how to clone your github repo on your local
machine. Then, use "git pull" and "git push" to get changes from
github and to send your changes there.

This is very much the standard way to use Git, so I guess reading the
doc can help ;-).

-- 
Matthieu
