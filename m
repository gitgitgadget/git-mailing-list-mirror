From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Thu, 10 May 2012 10:28:25 +0200
Message-ID: <vpqy5p08mom.fsf@bauges.imag.fr>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Thu May 10 10:28:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSOjr-0006Sq-AB
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 10:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab2EJI2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 04:28:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55534 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757345Ab2EJI2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 04:28:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4A8L945012806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2012 10:21:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SSOjZ-0002xI-Tb; Thu, 10 May 2012 10:28:25 +0200
In-Reply-To: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	(Antonio Ospite's message of "Sat, 5 May 2012 13:26:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 May 2012 10:21:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4A8L945012806
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1337242873.51746@soJV0ifHrawUpOOa728SDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197553>

Antonio Ospite <ospite@studenti.unina.it> writes:

> I find the x/exec function in "git rebase -i" very useful, [...]
> Can this functionality be exposed from the command line as well?

I've added this idea here:

  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_rebase_-i_--exec_CMD

maybe I'll get on of my students to code it soon :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
