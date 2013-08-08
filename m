From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 17:24:18 +0200
Message-ID: <vpqvc3gcijh.fsf@anie.imag.fr>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr>
	<CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7S6k-00059L-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898Ab3HHP0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:26:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47197 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965894Ab3HHPZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:25:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r78FOHDU032407
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 8 Aug 2013 17:24:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V7S4Z-00073y-8N; Thu, 08 Aug 2013 17:24:19 +0200
In-Reply-To: <CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 8 Aug 2013 20:43:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 08 Aug 2013 17:24:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r78FOHDU032407
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376580258.92422@4PqkINULTazM2W6W9Ch8EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231896>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> ... but I do agree that the doc is really confusing. It would be much
>> better if the doc could be reduced to:
>>
>> "This is a synonym for linkgit:git-log[1] --raw --some --other ---options.
>> Please refer to the documentation of that command."
>
> I don't think there's an exact correspondence with any combination of
> command-line options. Perhaps we can describe it in words, and ask
> people to use log instead?

I'd say either this, or add the missing features to "git log" to make my
suggestion possible (after all, if some people like "git whatchanged",
then maybe the feature would be of interest to "git log" users ?).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
