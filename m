X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Wed, 25 Oct 2006 10:12:45 -0700
Message-ID: <453F9B0D.1050409@zytor.com>
References: <yq0d58g92u0.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0610250746000.3962@g5.osdl.org> <453F8630.2000608@zytor.com> <20061025161323.GF11916@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 17:13:37 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Jes Sorensen <jes@sgi.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061025161323.GF11916@pasky.or.cz>
X-Virus-Scanned: ClamAV 0.88.5/2098/Wed Oct 25 06:14:20 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30077>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcmJi-00006a-Be for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965170AbWJYRNM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWJYRNM
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:13:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:47826 "EHLO
 terminus.zytor.com") by vger.kernel.org with ESMTP id S965170AbWJYRNM (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:13:12 -0400
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.7/8.13.7) with ESMTP id
 k9PHCmsW016776 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 25 Oct 2006 10:12:49 -0700
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Wed, Oct 25, 2006 at 05:43:44PM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> said that...
>> HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we 
>> got a neverending stream of segfaults in the logs.
> 
> Could you provide some details, please? Ideally a backtrace or
> something? Also, it might be a good idea to use 1.4.3.2 since it fixes a
> problem with compatibility of git-daemon and older git clients.
> 

I'm afraid I can't anymore since I've flushed those binaries.  1.4.3.2 
works fine, it seems, but we hadn't gotten that update until yesterday.

