From: Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 09/13] Rename everyday to giteveryday
Date: Sun, 24 Feb 2013 22:16:11 +0000
Message-ID: <512A912B.8080807@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-10-git-send-email-philipoakley@iee.org> <20130224145526.GK1361@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GitList <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:16:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9jsA-00043C-MH
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406Ab3BXWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:16:15 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:28696 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758237Ab3BXWQO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 17:16:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAHOPKlFZ8rke/2dsb2JhbAANOL52glqBJ4MSAQEBAQIBOEABEAsYCRYPCQMCAQIBRQYNAQcBAYgJqkmSLY5bMweDQAOqKQ
X-IronPort-AV: E=Sophos;i="4.84,730,1355097600"; 
   d="scan'208";a="415408149"
Received: from host-89-242-185-30.as13285.net (HELO [192.168.0.7]) ([89.242.185.30])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 24 Feb 2013 22:16:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130224145526.GK1361@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217010>

On 24/02/13 14:55, W. Trevor King wrote:
> On Sat, Feb 23, 2013 at 11:05:57PM +0000, Philip Oakley wrote:
>> diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
>> index e1fba85..3fc69f6 100644
>> --- a/Documentation/everyday.txt
>> +++ b/Documentation/everyday.txt
>> @@ -1,413 +1,25 @@
>> -Everyday Git With 20 Commands Or So
>> +Everyday GIT With 20 Commands Or So
>>   ===================================
>
> This looks like it's opposing 48a8c26 (Documentation: avoid poor-man's
> small caps GIT, 2013-01-21).  Another reason to use 'Git' over 'GIT'
> is to match the page we're redirecting to:

My mistake. When I was separating out the changes into separate patches 
I incorrectly restored/copied an old version of the title.

Will correct.

>
>> new file mode 100644
>> index 0000000..e1fba85
>> --- /dev/null
>> +++ b/Documentation/giteveryday.txt
>> @@ -0,0 +1,413 @@
>> +Everyday Git With 20 Commands Or So
>> +===================================
>
> Trevor
>
Philip
