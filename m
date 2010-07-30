From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Fri, 30 Jul 2010 13:26:11 -0500
Message-ID: <i2v5hc$6ep$4@dough.gmane.org>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr><4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 30 20:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuIm-0000tB-0f
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933072Ab0G3S1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:27:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:35475 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759994Ab0G3S1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:27:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OeuIQ-0000fw-DQ
	for git@vger.kernel.org; Fri, 30 Jul 2010 20:27:02 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:27:02 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:27:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152255>


"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr> wrote in message 
news:vpqd3u53sd2.fsf@bauges.imag.fr...
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>>> The name of the command may be subject to discussions. I've chosen
>>> "run", but maybe "shell" would be OK too. In both cases, it doesn't
>>> allow the one-letter version since both "r" and "s" are already used.
>>
>> "exec" with one-letter "x"?
>
> Thanks, that sounds good, yes. Any other thought?

"call" with one-letter "c"?

v/r,
Neal 
