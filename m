From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The big git command renaming..
Date: Fri, 29 Apr 2005 16:42:59 -0700
Message-ID: <4272C683.4050704@zytor.com>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org> <20050429213540.GA1691@redhat.com> <4272AE05.2070202@zytor.com> <Pine.LNX.4.58.0504291511410.18901@ppc970.osdl.org> <4272BE9C.7090906@zytor.com> <Pine.LNX.4.58.0504291638260.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRf3K-0000bk-20
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 01:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVD2XnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVD2XnZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 19:43:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:59070 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263072AbVD2XnU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 19:43:20 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3TNh4wc017305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 16:43:04 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291638260.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 29 Apr 2005, H. Peter Anvin wrote:
> 
>>If you have any other non-kernel git projects, just let me know and I'll 
>>make directories for them.
> 
> 
> The others are small and specialized (sparse, and the "git-tools" thing,
> and the latter is so much smaler than my BK tools used to be that I
> suspect I should just move it into git as the "apply mbox" import thing it
> is)
> 

I created /pub/scm/devel/sparse to go along with 
/pub/software/devel/sparse.  I agree with git-tools; just put it in the 
git directory (after all, you can have more than one dir.git underneath it.)

	-hpa
