From: Phil Hord <hordp@cisco.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Tue, 26 Jul 2011 08:14:30 -0400
Message-ID: <4E2EAFA6.90803@cisco.com>
References: <201107252233.02088.jnareb@gmail.com> <4E2DE708.8050805@cisco.com> <201107261237.43140.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 14:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlgX0-00082V-GA
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 14:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab1GZMOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 08:14:35 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:52183 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1GZMOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 08:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=710; q=dns/txt;
  s=iport; t=1311682473; x=1312892073;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=Z7cTCG6b1hUx8ZY2OQnGSH/witn5xGswYMOa9O8Lk0w=;
  b=HjYprQxbU0NhAQ6Z5LCOtS066rILCcLsPzSefqNfpbaH1M1kJUZKu2hg
   GEqabsy+j1KraS17DLAFCwlWtnJ7XbwhwptRBO1jZJSZohUrruzqpLOgA
   Zq7G9b1QdrKI8gBPivlRFQs8MVqTGUcF9mJW+j7IEWFbAZqkLB/7+xXZe
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EACqvLk6rRDoH/2dsb2JhbAA1AQEBAQIBFAEIaBEMDgoJMQ8CA1EHDgEOAQEfpzV3iHyjWp5khkAEknKFB4t1
X-IronPort-AV: E=Sophos;i="4.67,269,1309737600"; 
   d="scan'208";a="6453257"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by rcdn-iport-8.cisco.com with ESMTP; 26 Jul 2011 12:14:32 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p6QCEVCq011806;
	Tue, 26 Jul 2011 12:14:31 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <201107261237.43140.jnareb@gmail.com>
X-TagToolbar-Keys: D20110726081430042
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177862>

On 07/26/2011 06:37 AM, Jakub Narebski wrote:
> On Mon, 25 Jul 2011, Phil Hord wrote:
>
> bridges (git-svn, hg-git, git-p4, etc.)
> I think they are included in "two-way interaction with other SCMs",
> but perhaps that should be made more clear.

I think I just overlooked that one.

>> IDE integration (Eclipse, Netbeans, etc.)
> This isn't strictly _git_ feature, and is in "12. What kind of Git tools
> do you use?" anyway.
>
Yes, it's not a git feature.  But I'm curious how successful any IDE
integration is (as opposed to a GUI, for example).  I haven't seen any
that use enough of the power of git yet, so I have been disappointed.  I
suspect others have also, but I'm hopeful.

Phil
