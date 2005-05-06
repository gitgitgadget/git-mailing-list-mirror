From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel nightly snapshots..
Date: Thu, 05 May 2005 17:28:53 -0700
Message-ID: <427ABA45.3050803@zytor.com>
References: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>	 <42797F9F.9030002@zytor.com>	 <1115303933.16187.135.camel@hades.cambridge.redhat.com>	 <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org>	 <1115305813.16187.143.camel@hades.cambridge.redhat.com> <1115307033.16187.146.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 02:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTqcJ-0002V1-EJ
	for gcvg-git@gmane.org; Fri, 06 May 2005 02:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEFA3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 20:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVEFA3U
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 20:29:20 -0400
Received: from terminus.zytor.com ([209.128.68.124]:61157 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261790AbVEFA3R
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 May 2005 20:29:17 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j460Sxr6002197
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 May 2005 17:28:59 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1115307033.16187.146.camel@hades.cambridge.redhat.com>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse wrote:
> On Thu, 2005-05-05 at 16:10 +0100, David Woodhouse wrote:
> 
>>2.6.12-rc3-git1 is in the process of being built; if the attached
>>script works and continues working when invoked from cron, we might
>>even see nightly snapshots again as requested...
> 
> Eep. That'll be a whole lot more useful if I do
> 	cg-diff -r $RELTREE:$CURTREE
> instead of 
> 	cg-diff -r $CURTREE:$RELTREE
> ... but it should be OK now. This is the md5sum of the correct one:
> 
> 21a0ee13c539e8b016682c1542bb9167  patch-2.6.12-rc3-git1.gz
> 

Hi David,

Could you add that to 2.4 as well, too?

	-hpa
