From: Wink Saville <wink@saville.com>
Subject: Re: [egit] How-to use egit
Date: Thu, 13 Dec 2007 16:11:30 -0800
Message-ID: <4761CA32.80702@saville.com>
References: <476032A2.9010308@saville.com> <20071213024735.GB7492@fawkes> <4761B3B2.4040807@saville.com> <200712140024.20667.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:12:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2y9m-0007n7-Vu
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 01:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763952AbXLNALf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 19:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764021AbXLNALf
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 19:11:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:54590 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762550AbXLNALe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 19:11:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so731577rvb.1
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 16:11:33 -0800 (PST)
Received: by 10.140.180.11 with SMTP id c11mr1522113rvf.166.1197591093551;
        Thu, 13 Dec 2007 16:11:33 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id c36sm3315998rvf.2007.12.13.16.11.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Dec 2007 16:11:32 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <200712140024.20667.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68203>

Robin Rosenberg wrote:
> torsdag 13 december 2007 skrev Wink Saville:
>   
>> Yes, I selected them all and a single jar was created which
>>     
> Never seen that behaviour. I'm surprised that would be the default.
> When I export I get separate jars.
>
>   
>> I then started eclipse and now I see: Window/Preferences/Team/Git
>> When I select "Git" in the above, I see "Hi, I'm an empty preference page."
>>     
> That's all there is for now, but it means the plugin is activated.
>
>   
>> But again, I don't see any new menu items that
>> would allow me to look at history or make commits.
>> Is there more I need to to install the plugin, or
>> maybe I just need a little guidance on how to use it.
>>     
>
> We do not actually implement any menus in the menu bar. The only menus
> are in the context (right click) menu on resources.
>
> Try right-click on a project in the project explorer and the Team menu>Share project.
>
> -- robin
>   
Got it:

One thing that would be helpful for me is the
relationship between the items in the context menu
and the git commands, it isn't obvious to me.

As a for instance, it seems "Update index (Refresh)"
is a "git add <file>" but what is "Assume unchanged"?

One other thing is there a "git diff" and or "git diff HEAD"?

Thanks,

Wink
