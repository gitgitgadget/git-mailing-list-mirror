From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Wed, 18 Apr 2007 20:58:13 +1200
Message-ID: <4625DDA5.60503@vilain.net>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625314E.2050103@vilain.net> <b0943d9e0704171702j1bced65cja7a1f2e55a5b96d9@mail.gmail.com> <7vlkgqlezn.fsf@assigned-by-dhcp.cox.net> <4625874E.5040505@vilain.net> <Pine.LNX.4.64.0704180840100.4684@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 10:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He5zi-00008A-JM
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 10:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161464AbXDRI6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbXDRI6V
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 04:58:21 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55070 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161464AbXDRI6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 04:58:19 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 47D2013A400; Wed, 18 Apr 2007 20:58:17 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 5DE3713A382;
	Wed, 18 Apr 2007 20:58:13 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <Pine.LNX.4.64.0704180840100.4684@beast.quantumfyre.co.uk>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44873>

Julian Phillips wrote:
>> Sure... and from my own perspective as a user, I didn't even realise
>> what float did until now, and was surprised that "bury" would mean that.
>> The metaphor is a stack, not a pool or a sandpit. I don't think those
>> terms really assist in understanding, however cute they are.
>>     
>
> I find that bury is more natural than float (thinking of a stack of 
> documents on a desk ...).  But then I don't use stg ...
>   

You demonstrate my point :) by apparently missing that "bury" and
"float" are supposed to be the *opposite* of each other.

Sam.
