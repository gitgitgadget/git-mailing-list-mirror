From: Robert Pollak <robert.pollak@jku.at>
Subject: Re: [PATCH] Docs gitk: Explicitly mention -d, --date-order option
Date: Fri, 01 Apr 2011 10:05:31 +0200
Message-ID: <4D95874B.9040209@jku.at>
References: <1f748ec60804180616i311571eftbabcd3133ff83302@mail.gmail.com> <7v1w52ib5d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clifford Caoile <piyo@users.sourceforge.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 10:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ZMm-0006ty-MU
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 10:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab1DAIFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 04:05:39 -0400
Received: from email.edvz.uni-linz.ac.at ([140.78.3.58]:56046 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab1DAIFg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 04:05:36 -0400
Received: from [192.168.168.60] (unknown [140.78.223.2])
	by email.uni-linz.ac.at (Postfix) with ESMTP id 3BC9CB8C6;
	Fri,  1 Apr 2011 10:05:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7v1w52ib5d.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
OpenPGP: id=ADDE9E08;
	url=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170558>

Hello Junio,

you wrote on 2008-04-18:
> "Clifford Caoile" <piyo@users.sourceforge.net> writes:
[...]
>> Regarding the documentation patch "[PATCH] Docs gitk: Explicitly
>> mention -d, --date-order option" [1] (2008-04-12), it has not been
>> accepted. Is there problem with this patch?
>>
>> References:
>> [1] http://marc.info/?l=git&m=120799377618677&w=2
> 
> There isn't anything _wrong_ with the patch per se, but the current
> documentation refers you to rev-list page and limits itself to the most
> often used options.
> 
> I was waiting to see that many people jumping up and down saying that the
> omission of --date-order from the "most often used" set was a grave bug
> before applying it.  It hasn't happened.

This thread has helped me finding "-d" (which is gitk-specific). So
here's my vote for the patch, FWIW.

Robert
