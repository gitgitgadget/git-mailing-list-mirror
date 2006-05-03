From: David Lang <dlang@digitalinsight.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 12:46:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0605031243230.12716@qynat.qvtvafvgr.pbz>
References: <20060503090007.GM27689@pasky.or.cz> 
 <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com> 
 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain> 
 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se> 
 <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> 
 <4d8e3fd30605030839i2bb5de8dka8a4af27755051cf@mail.gmail.com> 
 <Pine.LNX.4.64.0605030856540.4086@g5.osdl.org> <e3al00$1dj$1@sea.gmane.org>
  <Pine.LNX.4.62.0605031218570.12716@qynat.qvtvafvgr.pbz>
 <20060503193013.GN27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 21:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbNJC-0004nR-RC
	for gcvg-git@gmane.org; Wed, 03 May 2006 21:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWECTql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 15:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWECTql
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 15:46:41 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:62953 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750763AbWECTql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 15:46:41 -0400
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 3 May 2006 12:46:41 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 03 May 2006 12:46:33 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060503193013.GN27689@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19515>

On Wed, 3 May 2006, Petr Baudis wrote:

> Dear diary, on Wed, May 03, 2006 at 09:21:54PM CEST, I got a letter
> where David Lang <dlang@digitalinsight.com> said that...
>> On Wed, 3 May 2006, Jakub Narebski wrote:
>>
>>> As to content, we could I think use material found at Wikipedia Git page,
>>> and on External Links in Wikipedia Git_(software) article, not repeating of
>>> course what is in official Git Documentation/
>>
>> please go ahead and put a lot of the info that is in the GIT
>> Documentation/ on the wiki. it's far easier to go to one site and browse
>> around to find things then to run into issues where you have to go
>> somewhere else (with different tools) to find the info.
>>
>> even if you just put all the documentation files there, as-is (as text
>> files even, no hyperlinks in them) they should still be there.
>
> Then who will keep it in sync (BOTH ways)? That would be quite a lot of
> work, I think.
>
> That said, having the documentation in a wiki is not a bad idea per se,
> but you need to keep things consistent and converging. And I believe
> (and hope) that killing Documentation/ directory is no option - I hate
> it when documentation of software I installed just tells me "look at
> this URI" (which documents a different version anyway, and it's all very
> useful when I'm sitting in a train with my notebook).

I agree with this completely.

as for keeping it in sync, the ideal situation would be for a 
documentation manager to take that job ;-) but lacking that just put the 
documentation in a non-editable page somewhere and link to it from the 
wiki (this could even be pages at kernel.org or wherever you have the raw 
source available outside of git itself)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
