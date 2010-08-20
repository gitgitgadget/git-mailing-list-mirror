From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git commands
Date: Fri, 20 Aug 2010 09:57:18 +0200
Message-ID: <vpq39u97m3l.fsf@bauges.imag.fr>
References: <1282288658094-5443370.post@n2.nabble.com>
	<5F6739C3-B537-4694-BC63-F3F74962A47C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sandy2010 <sandeeptt@yahoo.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 10:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmMWo-0001QJ-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 10:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab0HTIAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 04:00:37 -0400
Received: from imag.imag.fr ([129.88.30.1]:34940 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935Ab0HTIAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 04:00:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7K7vJ1g017155
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Aug 2010 09:57:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OmMTX-0000zJ-7y; Fri, 20 Aug 2010 09:57:19 +0200
In-Reply-To: <5F6739C3-B537-4694-BC63-F3F74962A47C@gmail.com> (Joshua Juran's message of "Fri\, 20 Aug 2010 00\:32\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Aug 2010 09:57:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153983>

Joshua Juran <jjuran@gmail.com> writes:

> On Aug 20, 2010, at 12:17 AM, sandy2010 wrote:
>
>> I'm new to git and I wonder what is the difference between two
>> commands:
>>
>> "git clone" and "git-clone" and which one should be use?
>
> They're the same command.

Except that "git-clone" doesn't work with Git >= 1.6. If you ask the
question, I suspect you have a rather old version of Git and you're a
beginner.

Git's user-friendlyness to newbies greatly improved over the last
versions, so I'd suggest upgrading.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
