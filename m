From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tracking files across tree reorganizations
Date: Thu, 15 Dec 2005 00:12:14 -0800
Message-ID: <43A1255E.50400@zytor.com>
References: <43A08B8F.1000901@zytor.com> <46a038f90512142138x77e57850ib095c1d68ecdfd13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 09:13:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmoEB-0004Il-Cl
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 09:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVLOIMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVLOIMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 03:12:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:15070 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965168AbVLOIMY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 03:12:24 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBF8CEVw030109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Dec 2005 00:12:15 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512142138x77e57850ib095c1d68ecdfd13@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13686>

Martin Langhoff wrote:
> On 12/15/05, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>Did anything ever happen with that?
> 
> Perhaps I'm slow today, but git-merge -s recursive was supposed to do
> it transparently (automagically). At least it was merged into git with
> that excuse ;-)
> 
> Does it not work for you or am I missing something?
> 

I'll try it.

	-hpa
