From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Sat, 10 Nov 2012 18:33:38 +0000
Message-ID: <509E9E02.3000500@ramsay1.demon.co.uk>
References: <20121029102114.GA14497@sigill.intra.peff.net> <5092C234.9000307@ramsay1.demon.co.uk> <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com> <20121102094259.GA28414@sigill.intra.peff.net> <20121102095632.GA30221@sigill.intra.peff.net> <50943C1A.4090706@ramsay1.demon.co.uk> <20121104122926.GD336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 19:36:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXFuV-00032R-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 19:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab2KJSft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 13:35:49 -0500
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:54999 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823Ab2KJSfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 13:35:48 -0500
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 5B2C112833E;
	Sat, 10 Nov 2012 18:35:46 +0000 (GMT)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9355E12833A;	Sat, 10 Nov 2012 18:35:45 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat, 10 Nov 2012 18:35:44 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121104122926.GD336@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209289>

Jeff King wrote:
> On Fri, Nov 02, 2012 at 09:33:14PM +0000, Ramsay Jones wrote:
> 
>> (Linux is my main platform, but I like to keep cygwin working because it has
>> kept me sane on Windows ever since (about) 1995 ...)
>> "Stranger in a strange land" ;-)
> 
> I used a different trick around the same time to keep me sane from
> Windows, but I think it involved "dd" and "/dev/zero"...

;-) That's a solution I would have been keen to try, but my employer
at the time would not have liked that idea ...

>>
>> This patch fixes the test for me.
> 
> Great. I was guessing blindly when I wrote it, but having seen the perl
> bug above, it all makes sense.
> 
> We should probably wrap it. I'm planning to queue this on top of Chris's
> patch:

Unfortunately, I haven't had time yet to test this patch. (Early this week, I
went into hospital for a "minor" surgical procedure - I have not yet fully
recovered). The patch looks good and I don't anticipate any problems. I will
hopefully test it soon (I see it's in pu now) and let you know.

[snip patch]

ATB,
Ramsay Jones
