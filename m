From: Dusty Phillips <dusty@buchuki.com>
Subject: Re: [PATCH 01/16] remote-helpers: avoid has_key
Date: Mon, 22 Apr 2013 16:51:28 -0600
Message-ID: <5175BEF0.7040509@buchuki.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com> <1366667724-567-2-git-send-email-felipe.contreras@gmail.com> <7va9oqnqs9.fsf@alter.siamese.dyndns.org> <CAMP44s1XaOOnHCCAHL3C=ZQFe6v4vOD+n7mwzFT0nEZAwGfqrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 23 01:10:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPsn-0006VB-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 01:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628Ab3DVXKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 19:10:45 -0400
Received: from sender1.zohomail.com ([72.5.230.103]:40947 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3DVXKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 19:10:44 -0400
Received: from [192.168.1.5] (S0106602ad0907ddb.mh.shawcable.net [70.73.103.32]) by mx.zohomail.com
	with SMTPS id 1366671117908154.2207932330291; Mon, 22 Apr 2013 15:51:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <CAMP44s1XaOOnHCCAHL3C=ZQFe6v4vOD+n7mwzFT0nEZAwGfqrg@mail.gmail.com>
X-ZohoMailClient: External
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222129>

On 04/22/2013 04:35 PM, Felipe Contreras wrote:
> On Mon, Apr 22, 2013 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> From: Dusty Phillips <dusty@linux.ca>
>>>
>>> It is deprecated.
>>>
>>> [fc: do the same in remote-bzr]
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>> No sign-off by the author?
>>
>> It does not matter for something so trivial like this that there is
>> no other way to write, but it is a good habit you should encourage
>> your contributors to acquire, so that you do not have to waste time
>> with "please sign off" when their next contribution that is more
>> substantial comes.
> He is not a contributor, he sent a few patches, and then immediately
> started gitifyhg, I haven't heard a word from him.
>
> Still, he was the original author, so...

Acknowledged that I will not likely be contributing any more patches. I 
apologize for the lack of signoffs on the pull requests; I wasn't 
actually aware that they were going into git mainline already. I will 
state for the record that all patches I submitted to Felipe's github 
fork of git in November and December, 2012 were authored by me and only 
me and I submitted them with the understanding and expectation that they 
would be licensed under the GPL.

Dusty
