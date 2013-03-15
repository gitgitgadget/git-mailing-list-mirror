From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Fri, 15 Mar 2013 14:11:04 -0600
Message-ID: <51438058.7080204@workspacewhiz.com>
References: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com> <20130315210325.7b0a3505ffa4d46e7e716324@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kristof Mattei <kristof@kristofmattei.be>, git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Fri Mar 15 21:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGb55-0001wS-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 21:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab3COURz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 16:17:55 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:46861 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237Ab3COURy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 16:17:54 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Mar 2013 16:17:54 EDT
Received: (qmail 10590 invoked by uid 399); 15 Mar 2013 14:11:07 -0600
Received: from unknown (HELO ?172.20.10.3?) (jjensen@workspacewhiz.com@70.208.2.127)
  by hsmail.qwknetllc.com with ESMTPAM; 15 Mar 2013 14:11:07 -0600
X-Originating-IP: 70.208.2.127
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130315210325.7b0a3505ffa4d46e7e716324@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218260>

----- Original Message -----
From: Konstantin Khomoutov
Date: 3/15/2013 11:03 AM
> On Fri, 15 Mar 2013 11:05:11 +0100
> Kristof Mattei <kristof@kristofmattei.be> wrote:
>
>> C:\Program Files (x86)\Git\bin>ssh -V
>> OpenSSH_6.1p1, OpenSSL 1.0.1e 11 Feb 2013
>>
>> Is there any way you can incorporate this update in the installer?
> Yes, you should grab the msysGit (the Git for Windows build
> environment) [2], tweak it to include the new OpenSSH binary, ensure it
> builds and works OK and then send a pull request (or post your patchset
> to the msysgit mailing list [3].
>
Wow, we can do that now?

When I brought up the vastly improved performance from a newer SSH 
executable, I was told the only way to get it in would be to build from 
source [1].

-Josh

[1] 
https://groups.google.com/forum/?fromgroups=#!searchin/msysgit/ssh$20josh/msysgit/U3InWruEl88/TAFaw4xJUI0J
