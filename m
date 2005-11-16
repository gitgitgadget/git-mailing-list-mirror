From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Sourceforge doesn't like git cvsimport
Date: Wed, 16 Nov 2005 11:09:43 -0800
Message-ID: <437B83F7.6010500@zytor.com>
References: <437B7416.8030704@zytor.com> <46a038f90511161100x4263ac01iaf3c0497db5021f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 20:12:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcSfR-0000mv-2V
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbVKPTJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVKPTJ6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:09:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10920 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751490AbVKPTJ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 14:09:57 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAGJ9mBD005774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 11:09:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511161100x4263ac01iaf3c0497db5021f6@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12042>

Martin Langhoff wrote:
> Unpossible!
> 
> I run git-cvsimport against Moodle's cvs repo on SF.net at least twice
> a day over SSH. I did it several times with anon cvs too. SF.net cvs
> servers have been up, down and unreliable the last week, but that's
> bad with the plain old cvs client too.
> 
> Can we get more info on what's happening?
> 

No idea.  I used it as late as earlier this week, but now I'm getting 
the error seen in the message.

It also frequently connects and immediately disconnects, which I 
attribute to the unreliability you describe.

	-hpa
