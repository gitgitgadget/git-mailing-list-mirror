From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 00/11] More consistant terminology ("remote-tracking branch", "not updated")
Date: Mon, 25 Oct 2010 19:30:08 +0200
Message-ID: <vpqsjzu5gf3.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<m3fwvwkadi.fsf@localhost.localdomain>
	<20101023191104.GM21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 19:33:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAQvV-0002Vv-9j
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759225Ab0JYRda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 13:33:30 -0400
Received: from imag.imag.fr ([129.88.30.1]:51989 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759216Ab0JYRda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 13:33:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9PHU8xC022893
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 25 Oct 2010 19:30:08 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PAQs4-0007xu-9s; Mon, 25 Oct 2010 19:30:08 +0200
In-Reply-To: <20101023191104.GM21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 14\:11\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 25 Oct 2010 19:30:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159962>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jakub Narebski wrote:
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>>> this is an attempt to be more consistant in the terminology used in Git.
>>
>> Thank you very much for your work!
>
> Yes, seconded!  

Actually, I did the easy part ;-) (easy grep-able patterns, and
uncontroversal solution).

There's still a mess about the "upstream/downstream" Vs
"remote-tracking" terminology, both in the UI (--track options here
and there) and the doc.

And I'd really like the "index/cache/stage" thing to be fixed too. I
like "stage/staging area" best, but it seems this part does not make a
consensus (yet?).

I'm just hoping I gave the right example and someone else will now
take care of these two ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
