From: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>
Subject: Re: [PATCH] Make git status usage say git status instead of git commit
Date: Mon, 3 Dec 2007 13:04:08 +0100
Message-ID: <116ABC64-B936-4EA3-9E8A-12FD71DDC1EA@orakel.ntnu.no>
References: <1196658129-16708-1-git-send-email-shawn.bohrer@gmail.com> <7vir3gqr3d.fsf@gitster.siamese.dyndns.org> <854pf0hyy3.fsf@lola.goethe.zz> <877ijww0d3.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 13:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzA34-0007td-1Y
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 13:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbXLCMEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbXLCMEh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 07:04:37 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:62857 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbXLCMEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 07:04:37 -0500
Received: from [192.168.2.243] (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 87EB262B872;
	Mon,  3 Dec 2007 13:04:34 +0100 (CET)
In-Reply-To: <877ijww0d3.fsf@mid.deneb.enyo.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66914>

On 3. des. 2007, at 11.15, Florian Weimer wrote:

> * David Kastrup:
>
>> Deprecating the dash form will probably mean that we need to think up
>> (and document) a rationale for
>>
>>   man git-commit
>>
>> I actually have typed something like
>>
>>   man git commit
>>
>> a number of times already with obvious results.  Finger memory.
>
> It's also a bit strange to have a git-commit(1) manpage when there  
> is no
> git-commit on the path.

No stranger than having a perlfunc(1) manpage.  bash-builtins is in  
section 7, maybe git-* should be moved there?  Of course, then git  
wouldn't have any manpages in section 1 at all.

Eyvind
