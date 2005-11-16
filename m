From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] git email submissions
Date: Wed, 16 Nov 2005 09:53:23 -0800
Message-ID: <437B7213.2020406@zytor.com>
References: <437B4472.1080401@pobox.com> <Pine.LNX.4.64.0511160847250.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 18:54:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcRTh-0000KO-HO
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 18:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVKPRxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVKPRxr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 12:53:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52695 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030288AbVKPRxq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 12:53:46 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAGHrS2L003879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 09:53:28 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511160847250.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12033>

Linus Torvalds wrote:
> 
> On Wed, 16 Nov 2005, Jeff Garzik wrote:
> 
>>For people without _any_ hosting, it would be nice to give them a method to
>>submit some git changes via email.
> 
> Well, as long as you don't expect me to take those things..
> 
> BK had it with "bk send"/"bk receive", I used it a couple of times and 
> refuse to do it again.
> 

Personally I think it would be nice if you could do an augmented 
patchset so that the end result is the same (with the same SHA1 IDs) as 
if one had merged a pull, while still being a human-readable patchset. 
The advantage with that is that once merged it'll do the right thing on 
the author's end.  I think that's pretty much my answer to Jeff's 
question :)

	-hpa
