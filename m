From: Andrey Chernyshov <chernyshov.andrey@gmail.com>
Subject: Re: git for windows
Date: Wed, 27 Jan 2016 15:49:57 +0300
Message-ID: <56A8BCF5.8010309@gmail.com>
References: <56A8AAD6.4070404@gmail.com> <56A8AB7F.8040101@gmail.com>
 <56A8AF5F.5030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 13:50:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOPXx-0000qq-FD
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 13:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbcA0MuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 07:50:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:41773 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbcA0Mt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 07:49:59 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP; 27 Jan 2016 04:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,354,1449561600"; 
   d="scan'208";a="890204257"
Received: from jfdmzpr05.jf.intel.com (HELO [10.7.210.24]) ([10.7.210.24])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2016 04:50:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56A8AF5F.5030707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284911>

Additional note - when I use the command line git push doesn't display 
any errors but no updates on github...
git status says :

On branch master
Your branch is ahead of 'origin/master' by 3 commits.

On 1/27/2016 2:51 PM, Andrey Chernyshov wrote:
>
>
> On 1/27/2016 2:35 PM, Andrey Chernyshov wrote:
>>
>> On 1/27/2016 2:32 PM, Andrey Chernyshov wrote:
>>> Hi
>>>
>>> I'm using PHP storm with git for windows. Once I do a push to the 
>>> github I get the following error
>> Problem signature:
>>   Problem Event Name:    APPCRASH
>>   Application Name:    git-remote-https.exe
>>   Application Version:    2.7.0.0
>>   Application Timestamp:    35316130
>>   Fault Module Name:    libidn-11.dll
>>   Fault Module Version:    0.0.0.0
>>   Fault Module Timestamp:    00170158
>>   Exception Code:    c0000005
>>   Exception Offset:    00000000000046bc
>>   OS Version:    6.3.9600.2.0.0.256.4
>>   Locale ID:    1033
>>   Additional Information 1:    a547
>>   Additional Information 2:    a54764e1ee4f5613d3fc9395100a0ff4
>>   Additional Information 3:    ac01
>>   Additional Information 4:    ac010ce737711604ec050156caebd625
>>
>> Read our privacy statement online:
>> http://go.microsoft.com/fwlink/?linkid=280262
>>
>> If the online privacy statement is not available, please read our 
>> privacy statement offline:
>>   C:\windows\system32\en-US\erofflps.txt
>>
>>> If I try to push with Git GUI, it's the same, so not a PHPStorm 
>>> issue...
>>>
>>> -- 
>>> Thanks, Andrey.
>>
>> -- 
>> Thanks, Andrey.
>

-- 
Thanks, Andrey.
