From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 10:24:11 +0200
Message-ID: <200807241024.11900.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <20080723145455.GS2925@dpotapov.dyndns.org> <20080723170120.GC17648@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLw8W-00025o-Dw
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbYGXIYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYGXIYT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:24:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:58182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYGXIYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:24:18 -0400
Received: by ug-out-1314.google.com with SMTP id h2so572396ugf.16
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f9LQ5KoTjMYxEQfPy07na+ZnBDYeZdTBy+4FFeF1ArM=;
        b=YGt6szVfsmx7gBDlAOyxyX0IxDoQG+O5dC7B9nTVVGXOOZJeqiQ1fdTOsi6HIx0w9z
         1EegD343XrQ34lDpitxxBR/P7xhk/wDc+W1M3ehwBBRZsfaJORGnlLLCnNvtB8LUor4Q
         b/IwYQ5RYZqwMR7QyJMRBkVMTIMpOQIYIjFJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q66AxXhpSt4mjiUMkAqJduUZBx22a9dju/W8i5Lq/oznf2yaS17tK31C82TpXtHX8j
         RmiLHuEp90/3Me4ubnmRyaKEiKrTH/lt1syA+F64R2GMO8nSxVjCFFf0kC0ciT3KcXN7
         Ja5JxT8anKRkzuRwLUMDbknhiT06Jm//fUUAQ=
Received: by 10.66.236.13 with SMTP id j13mr690054ugh.7.1216887856855;
        Thu, 24 Jul 2008 01:24:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id m1sm3731406ugc.9.2008.07.24.01.24.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 01:24:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723170120.GC17648@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89848>

On Wed, 23 July 2008, Stephan Beyer wrote:
> Dmitry Potapov wrote:
>> On Wed, Jul 23, 2008 at 11:53:27AM +0200, Johannes Schindelin wrote:
>>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>>>>
>>>>    11. Why did you choose Git? (if you use Git)
>>>>        What do you like about using Git?
>>>>        (free form, not to be tabulated)
>>> 
>>> Again, to avoid hassles with free-form:
>>> 
>>> 	Mandatory: work, mandatory: open source project I am participating 
>>> 	in, speed, scalability, It's What Linus Uses, Other.
>> 
>> If we move away from free-form, it should be much more choices here.
>> 
>> - Ability to work offline
>> - Cryptographic authentication of history.
>> - Distributed development (pull/push from/to more than one remote repo)
>> - Easy to extend functionality through scripting
>> - Efficient storage model
>> - Elegant design
>> - Fast
>> - Good community support
>> - Rewriting patches before publishing (git rebase, commit --amend)
>> - Scalability (Efficient handling of large projects)
>> - Strong support for non-linear development
>> - Support of wide range of protocols for synchronization.
>> ...
> 
> Heh, I can imagine git users reading that survey and thinking
>  "What? Git allows me to rewrite patches before publishing?
>   And it provides cryptographic integrity? Sounds good. *click*"
> 
> Nevertheless, the list is fine ;)
> Perhaps also: "Good reputation".

Perhaps also: "Because it is popular (hype)", and I hope that
"Ability to track code movement" would have any takers.  Although
it is hard to distinguish between 'reasons to choose' and 'favourite
features' list; let's make it more 'reasons to choose' (like "feature
rich").

"Good documentation", perhaps, too?
-- 
Jakub Narebski
Poland
