From: Stephen Kelly <steveire@gmail.com>
Subject: Re: git interactive rebase 'consume' command
Date: Mon, 21 Jan 2013 09:40:34 +0100
Message-ID: <kdiuu0$bvt$1@ger.gmane.org>
References: <kdgtir$apt$1@ger.gmane.org> <7vk3r7llod.fsf@alter.siamese.dyndns.org> <kdhfk6$von$1@ger.gmane.org> <7v8v7nli2a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwJ-0002t2-7n
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab3AUIkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 03:40:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:54710 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab3AUIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TxCw8-0002ni-LR
	for git@vger.kernel.org; Mon, 21 Jan 2013 09:41:00 +0100
Received: from e178124029.adsl.alicedsl.de ([85.178.124.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 09:41:00 +0100
Received: from steveire by e178124029.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 09:41:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: e178124029.adsl.alicedsl.de
User-Agent: KNode/4.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214096>

Junio C Hamano wrote:

> Stephen Kelly <steveire@gmail.com> writes:

>> One scenario is something like this:
>>
>>  Start with a clean HEAD (always a good idea :) )
>>  hack hack hack
>>  make multiple commits
>>  realize that a hunk you committed in an early patch belongs in a later
>>  one. use git rebase -i to fix it.
>>
>> Is that more clear?
> 
> Not really.

I think there are other scenarios, but I guess this won't happen anyway.

Thanks,

Steve.
