From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 0/6] Improve remote helper documentation
Date: Fri, 7 Dec 2012 23:38:45 +0100
Message-ID: <A82E2605-13FC-4B9A-B9F4-7D416054588D@quendi.de>
References: <1354038279-76475-1-git-send-email-max@quendi.de> <7v1uf1he6m.fsf@alter.siamese.dyndns.org> <A6FF9929-74F8-4F2F-BA0B-1B1086D4E7F5@quendi.de> <7vehj1fs3c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:39:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th6Zc-0002TI-IA
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 23:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab2LGWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 17:38:56 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:40650 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755338Ab2LGWi4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2012 17:38:56 -0500
Received: from drms-590edca7.pool.mediaways.net ([89.14.220.167] helo=[192.168.1.37]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Th6ZF-0001oo-4r; Fri, 07 Dec 2012 23:38:49 +0100
In-Reply-To: <7vehj1fs3c.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354919936;8b181eb2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211201>


On 07.12.2012, at 22:52, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>> On 07.12.2012, at 20:09, Junio C Hamano wrote:
>> 
>>> Except for a minor nit in 6/6; I think "defined options" should be
>>> "defined attributes".
>>> 
>>>   --- a/Documentation/git-remote-helpers.txt
>>>   +++ b/Documentation/git-remote-helpers.txt
>>>   @@ -227,6 +227,8 @@ Support for this command is mandatory.
>>>           the name; unrecognized attributes are ignored. The list ends
>>>           with a blank line.
>>>    +
>>>   +See REF LIST ATTRIBUTES for a list of currently defined options.
>>>   ++
>> 
>> Indeed, my mistake. Dumb question since I am still not completely
>> familiar with the procedures here: Would you just fix this
>> yourself as you apply this, or is it better (or even required)
>> that I reroll for this? (Of course if I ned to re-roll for other
>> reasons, I'd fix this one as well).
> 
> I didn't see any other issues myself, and I didn't see anybody
> raising issues on the series, either, so I could fix it up by
> amending what is already queued, as long as you are OK with it.

Sure, I'd appreciate if you could make that fix.

Thanks,
Max
