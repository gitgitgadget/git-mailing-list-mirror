From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Thu, 12 Nov 2009 11:54:54 -0500
Message-ID: <4AFC3DDE.7000202@fastmail.fm>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm> <7vzl6soniu.fsf@alter.siamese.dyndns.org> <4AFB57A3.2020002@fastmail.fm> <200911120910.57091.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8d3V-0004Q0-P0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbZKLRBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbZKLRBh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:01:37 -0500
Received: from smtp111.rog.mail.re2.yahoo.com ([206.190.37.1]:42588 "HELO
	smtp111.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753593AbZKLRBg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 12:01:36 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Nov 2009 12:01:36 EST
Received: (qmail 71090 invoked from network); 12 Nov 2009 16:55:02 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp111.rog.mail.re2.yahoo.com with SMTP; 12 Nov 2009 08:55:02 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: b45p9m8VM1n6MxQNZv52DRohJGRw41ONSMOEYTcs2HhXYklY7FCfWPurMtnXOr1t_A--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 9750121C05CC;
	Thu, 12 Nov 2009 11:55:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g7HvdUfBVLUW; Thu, 12 Nov 2009 11:54:55 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 08A7521C05CB;
	Thu, 12 Nov 2009 11:54:55 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <200911120910.57091.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132784>

Thomas Rast wrote:
> Raman Gupta wrote:
>> Junio C Hamano wrote:
>>> Please set the tone straight.  If this is to suggest various possible
>>> workflows in general vague terms, "may use" would be good.  If this is to
>>> precisely describe what I do, then there won't be "you could do this, or
>>> you could do that."  Your "may use" suggests the former, but the commit
>>> log message claims the latter.  Which document are you writing?
>> Ok. The current document is inconsistent. In places it uses "the
>> maintainer" and in other places it uses "you". In any case, it seems
>> that the "maintainer" here is not "Junio Hamano" -- rather, it is the
>> reader.
>>
>> Let me create a separate (and first) cleanup patch to fix the existing
>> inconsistencies in this man page. I would prefer to use the pronoun
>> "you" consistently as also suggested by Thomas Rast.
> 
> Well, I'm not sure if this is also in reply to my comment

It was mostly, yes.

> } The current gitworkflows is mostly formulated in the imperative, [...]
> } or by directly describing the tools in the third person, [...]
> 
> but note that I do not consider the current form to be inconsistent
> (though you may of course convince me otherwise).  It addresses the
> presumed user with "you", which is not always the maintainer.  For
> example, when talking about patch submission we have

You're right, upon re-reading the original man page I realized it is
consistent.

Thanks,
Raman
