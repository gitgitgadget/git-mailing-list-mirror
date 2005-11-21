From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Mon, 21 Nov 2005 01:28:47 -0800
Message-ID: <4381934F.3030307@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511181926.10357.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <Pine.LNX.4.63.0511190101590.28126@wbgn013.biozentrum.uni-wuerzburg.de> <4380C03B.9090603@zytor.com> <Pine.LNX.4.63.0511210937500.3931@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 10:29:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee7z2-0005eR-Oa
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 10:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVKUJ3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 04:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVKUJ3G
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 04:29:06 -0500
Received: from terminus.zytor.com ([192.83.249.54]:23738 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932244AbVKUJ3E
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 04:29:04 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAL9Sl7t013164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 01:28:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511210937500.3931@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12433>

Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 20 Nov 2005, H. Peter Anvin wrote:
> 
> 
>>Johannes Schindelin wrote:
>>
>>>BTW, utf-8 was designed on purpose to be easily distinguishable from 
>>>other encodings so that you don't have to rely on every document 
>>>obeying a certain encoding.
>>>
>>
>>No, it wasn't.  It was designated on purpose to be ASCII-compatible,
>>substring-safe, and minimally stateful.
> 
> 
> For the record, my information stems from
> 
> http://en.wikipedia.org/wiki/Utf-8#Rationale_behind_UTF-8.27s_mechanics
> 

That article is a bit confusing, as it mixes rationale with commentary.

	-hpa
