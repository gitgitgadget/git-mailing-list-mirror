From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Thu, 18 Sep 2008 08:50:38 +0200
Message-ID: <48D1FA3E.6020102@op5.se>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>	 <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>	 <48D11C3C.5070707@op5.se>	 <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>	 <20080917155505.GH4829@genesis.frugalware.org> <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:51:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDMk-0003Ih-87
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYIRGum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYIRGum
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:50:42 -0400
Received: from mail.op5.se ([193.201.96.20]:60254 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbYIRGum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:50:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8BFB11B800A6;
	Thu, 18 Sep 2008 08:40:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.585
X-Spam-Level: 
X-Spam-Status: No, score=-3.585 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.814, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FG6BAG5V+Cyx; Thu, 18 Sep 2008 08:40:37 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.171])
	by mail.op5.se (Postfix) with ESMTP id DC74A1B80005;
	Thu, 18 Sep 2008 08:40:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96171>

Jonathan del Strother wrote:
> On Wed, Sep 17, 2008 at 4:55 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> On Wed, Sep 17, 2008 at 04:31:17PM +0100, Jonathan del Strother <maillist@steelskies.com> wrote:
>>> I was changing it to match the style in the existing java pattern (and
>>> my objc pattern).  You think the java one should be changed to match
>>> the pascal one, then?
>> The point is that it's unrelated, so you should not change that part in
>> the same patch. Send a separate patch if you want to do something
>> unrelated to Objective-C.
> 
> Johannes already convinced me to do it as a separate patch.  Andreas
> seems to think that even if that change were in a separate patch, it
> is pure nonsense.  I think it's pretty subjective - I was just making
> things consistent.

My apologies. I started writing that reply before Dscho's one got to the
list. Then it was lunch-time, so I didn't send it until Dscho's reply
was already answered by you.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
