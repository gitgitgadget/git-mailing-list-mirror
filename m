From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 05/10] Change "tracking branch" to "remote-tracking branch" in C code
Date: Wed, 27 Oct 2010 00:15:30 +0200
Message-ID: <vpqr5fc38jh.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-6-git-send-email-Matthieu.Moy@imag.fr>
	<20101023185112.GI21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 00:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PArnw-0006I9-Rc
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 00:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760468Ab0JZWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 18:15:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59368 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab0JZWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 18:15:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9QM0pGN012702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Oct 2010 00:00:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PArnm-0003XD-VA; Wed, 27 Oct 2010 00:15:31 +0200
In-Reply-To: <20101023185112.GI21040@burratino> (Jonathan Nieder's message of "Sat\, 23 Oct 2010 13\:51\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Oct 2010 00:00:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9QM0pGN012702
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288735252.33438@zIM8lNjGrRAbP4DixS9PrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160009>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> [Subject: [PATCH 05/10] Change "tracking branch" to "remote-tracking branch" in C code]
>>
>> (Just like we did for documentation already)
>
> Could be squashed with the previous in my opinion.  Comments
> especially but also usage strings still feel like documentation.

Oups, I had missed this one.

Yes, why not. I'll do that in the next round.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
