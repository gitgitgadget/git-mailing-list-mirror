From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: using-topic-branches.txt
Date: Mon, 19 Dec 2005 14:25:15 -0800
Message-ID: <43A7334B.9020905@zytor.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com> <7vfyoplk0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512182225310.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 23:27:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoTS1-00089G-9b
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 23:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVLSWZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 17:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVLSWZq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 17:25:46 -0500
Received: from terminus.zytor.com ([192.83.249.54]:34526 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965009AbVLSWZq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 17:25:46 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBJMPKii012531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Dec 2005 14:25:20 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512182225310.4827@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13839>

Linus Torvalds wrote:
> 
> Well, you can use "git://git.kernel.org/" for reading.
> 
> Personally, I use master.kernel.org both for reading and writing, but I 
> end up using an ssh key with an empty passphrase.
> 

If you use ssh-agent then you don't have to use an empty passphrase. 
ssh-agent should be automatically set up in all the current distros.

	-hpa
