From: Wink Saville <wink@saville.com>
Subject: Re: README rewrite
Date: Sun, 15 May 2005 08:30:56 -0700
Message-ID: <42876B30.1070404@saville.com>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, zbrown@tumblerings.org
X-From: git-owner@vger.kernel.org Sun May 15 17:22:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXKwX-0006Uf-QG
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVEOPWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVEOPWI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:22:08 -0400
Received: from adsl-66-218-52-146.dslextreme.com ([66.218.52.146]:64783 "EHLO
	saville.com") by vger.kernel.org with ESMTP id S261656AbVEOPWB
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 11:22:01 -0400
Received: from [192.168.0.18] (unknown [192.168.0.18])
	by saville.com (Postfix) with ESMTP id B1F23F1B07;
	Sun, 15 May 2005 08:16:18 -0400 (EDT)
Received: from 127.0.0.1 (AVG SMTP 7.0.308 [266.11.10]); Sun, 15 May 2005 08:30:57 -0700
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <4286F146.2090302@saville.com>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wink Saville wrote:
> Zack Brown wrote:
> 
>  > Hi Petr,
>  >

<snip>

> Actually looking in the repository I see that "origin" appears to be a 
> "branch" not a revision, what is the relationship between a branch, tag 
> and revision's? I have some experience with subversion and in subversion 
> they are actually all the same, simply the state of a "sub-tree" within 
> the repository at a particular "time". That time is defined by the 
> repositories current revison number which is incremented after each 
> succesful commit to the repository.
> 


Zack,

I patched the README by hand this morning and read the explanation on cg-tag and it 
appears branches, tags and revisions are synonymous, please correct me if I'm wrong.

Is there a way to use time or relative values (HEAD-1) as "revision" parameters, it would 
be nice if its not already there.

Again, thanks for the update adds very useful information!

Wink




-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.308 / Virus Database: 266.11.10 - Release Date: 5/13/2005

