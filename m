From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-archimport
Date: Sat, 07 Aug 2010 15:11:59 +0200
Message-ID: <vpqtyn6h8io.fsf@bauges.imag.fr>
References: <4B7D8358.1080108@gmail.com>
	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	<AANLkTi=a27OtQX-oNwPqmXDUmZHFyKo+fPZCRgSv04G3@mail.gmail.com>
	<m3iq3mo9t5.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Parker <conrad@metadecks.org>,
	Chris Packham <judge.packham@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 15:12:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhjCI-0000wE-MQ
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 15:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab0HGNMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 09:12:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46608 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab0HGNMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 09:12:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o77D9h2Z023430
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 7 Aug 2010 15:09:43 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OhjBw-0006mE-8S; Sat, 07 Aug 2010 15:12:00 +0200
In-Reply-To: <m3iq3mo9t5.fsf_-_@localhost.localdomain> (Jakub Narebski's message of "Sat\, 07 Aug 2010 06\:03\:27 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 07 Aug 2010 15:09:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o77D9h2Z023430
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281791384.34771@L4APjhmjW2YPIOPeoHE6+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152855>

Jakub Narebski <jnareb@gmail.com> writes:

> Conrad Parker <conrad@metadecks.org> writes:
>
>> Anyone interested in git-bzr might also want to look at some recent
>> rewrites; from the current git-bzr README:
>> 
>> The following are rewrites in Python and may offer better bzr integration:
>>   * http://github.com/termie/git-bzr-ng
>>   * http://github.com/matthew-brett/git-bzr
>> 
>> (... and I'd also be interested to know how well either of these work :)
>> 
>> cheers,
>
> By the way, perhaps it is time to finally retire git-archimport, or at
> least move it to contrib section.  Is there anyone using it?

Definitely not using it on a daily basis, but I still have a few GNU
Arch archives on my machine, and may need to import them into Git one
day.

If git-archimport causes a problem wrt maintainance, I'd understand
that it be deprecated, but if it doesn't cost to keep it around, I
don't think it'd be a good thing to drop it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
