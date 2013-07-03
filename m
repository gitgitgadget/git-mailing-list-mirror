From: Kyle McKay <mackyle@gmail.com>
Subject: Re: repo.or.cz being not well???
Date: Tue, 2 Jul 2013 23:01:27 -0700
Message-ID: <5DA7CF37-6738-42A4-8648-2952ADF94284@gmail.com>
References: <7vli5q9ba2.fsf@alter.siamese.dyndns.org> <7va9m5apl8.fsf@alter.siamese.dyndns.org> <CB8FBC9A-B24D-4EAC-820F-A40472387FD9@gmail.com> <87k3l8gavd.fsf@igel.home>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "repo.or.cz admins" <admin@repo.or.cz>
To: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 08:01:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuG8E-0002yv-Om
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 08:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3GCGBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 02:01:31 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:59524 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab3GCGBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 02:01:30 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so7427080oah.24
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=uO8I3Du+28sQjwXXk2dXvXT5Q+BupbkkBjTSkCO5aHU=;
        b=W3y4/QQzfCC4QgBTMyM118TTN+0MK8MffWBZ1FRkopdJnsKqWQ/sdCGWUlpU6At3q/
         7tL1oWSW4LOyggCXEoXt1HYRXuxl95Z7Vx6c0iJiJWGsHP8Zh0ClgLozNWdp2zbfgQqk
         BujyW0967RdEJ0SBgxZWacuFox/F3CdB3HUEASKZMayQfgUg3NQmu/FtNKjboxWy+96V
         0Jivl6A16NZVvGF6jZ0k3oYmvHJNjfWcxurlKkjGprHOBwjzIQNVdaQvAPzfr1/nHWAQ
         Q90R9za6wgLzWdIMkTH0OKIkWuHa1NLP9XbfJxMCwjVgfOWbrnxPwozu9BQQhNdCixUv
         +bWg==
X-Received: by 10.60.137.225 with SMTP id ql1mr14318461oeb.48.1372831289903;
        Tue, 02 Jul 2013 23:01:29 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kz3sm9600962obb.6.2013.07.02.23.01.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 23:01:29 -0700 (PDT)
In-Reply-To: <87k3l8gavd.fsf@igel.home>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229452>

On Jul 2, 2013, at 09:55, Andreas Schwab wrote:
> Kyle McKay <mackyle@gmail.com> writes:
>
>> Do you feel that it's important to accept these alternate URL  
>> versions
>> that are not listed on the project page:
>>
>> 1) Optional trailing '/'
>> 2) For the ssh scp form, optional leading '/'
> 3) Optional trailing .git

Thank you for your patience.

The 3 URL variants listed above should all be working again now.

On Jul 1, 2013, at 16:10, Junio C Hamano wrote:
> I just (1) was curious, as getting "error 403" when I didn't mean to
> talk to an HTTP server was strange,

The '403' prefix has also been removed from ssh protocol error  
messages to reduce confusion.

Regards,
Kyle
