From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] (short) documentation for the testgit remote helper
Date: Thu, 01 Sep 2011 17:52:50 +0200
Message-ID: <vpqd3fk1cq5.fsf@bauges.imag.fr>
References: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
	<1314814498-13699-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAGdFq_grmJLoTt7JMUuoXrd02Gx8JdcEL-wa7YQ=-FkurRqfWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 17:53:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9aK-0008T1-RL
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 17:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523Ab1IAPxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 11:53:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33189 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514Ab1IAPxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 11:53:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p81Fq9EK008218
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Sep 2011 17:52:09 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qz9ZS-0001mp-Nl; Thu, 01 Sep 2011 17:52:50 +0200
In-Reply-To: <CAGdFq_grmJLoTt7JMUuoXrd02Gx8JdcEL-wa7YQ=-FkurRqfWA@mail.gmail.com>
	(Sverre Rabbelier's message of "Thu, 1 Sep 2011 13:27:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 01 Sep 2011 17:52:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p81Fq9EK008218
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315497135.7141@o17xP8t7YqEBmqOJK+UZJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180535>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Wed, Aug 31, 2011 at 20:14, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> +# To understand better the way things work, one can set the variable
>> +# "static int debug" in transport-helper.c to 1, and/or the "DEBUG"
>> +# variable in git_remote_helpers/util.py to True, and try various
>> +# commands.
>
> Both are controlled by an environmental variable, it would be better
> to mention these directly.
>
> I think that for remote-testgit it is GIT_DEBUG_TESTGIT=1.

Oops, I had missed it. Will resend.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
