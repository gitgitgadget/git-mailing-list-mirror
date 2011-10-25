From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 18:27:06 +0200
Message-ID: <vpqpqhlox45.fsf@bauges.imag.fr>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjqO-00014Z-2u
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab1JYQ1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 12:27:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58144 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab1JYQ1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 12:27:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9PGNRu3014972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 25 Oct 2011 18:23:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RIjqE-00010k-J7; Tue, 25 Oct 2011 18:27:06 +0200
In-Reply-To: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
	(Eugene Sajine's message of "Tue, 25 Oct 2011 11:58:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 25 Oct 2011 18:23:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9PGNRu3014972
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1320164608.59937@1Bnh38/r5Ij3g9KggeOYBw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184218>

Eugene Sajine <euguess@gmail.com> writes:

> Hi,
>
>
> We have built git 1.7.6.4 and we have a following problem with it:

Which command did you use to compile it? What does

  git --exec-path

say?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
