From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Wed, 21 Dec 2005 18:16:08 -0800
Message-ID: <43AA0C68.4030802@zytor.com>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>	<43A9E15F.1060808@zytor.com> <7vpsnqyqji.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 03:16:40 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpG0Q-0002VK-Na
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 03:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVLVCQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVLVCQR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 21:16:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:50643 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965034AbVLVCQQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 21:16:16 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBM2G8k1029434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Dec 2005 18:16:09 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsnqyqji.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13930>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>Junio C Hamano wrote:
>>
>>>I've pushed out a v1.0.0b maint release to fix a bug in HTTP
>>>fetch that was discovered today X-<.
>>>
>>
>>Wouldn't it make more sense for the maintenance release to be 1.0.1?
> 
> 
> Maybe.  Nobody mentioned this about 0.99.9a, 0.99.9b... though.

Yeah, well, the 0.99 bit in front kind of had made that hard to do.

> The series 1.0.0[a-z] is meant to parallel 2.6.14.[123...]
> "fixes only"; OTOH I'd like to allow 1.0.[123...] to contain
> enhancements.

Well, the Linux numbering scheme has gotten ridiculous, with the 2. in 
front having no meaning.

	-hpa
