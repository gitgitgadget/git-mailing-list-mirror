From: Jim Babka <jim@babkas.info>
Subject: Re: git svn hangs
Date: Tue, 14 Apr 2009 14:39:15 -0500
Message-ID: <49E4E663.4080802@bestmail.us>
References: <49DE2796.4090406@bestmail.us> <20090411020919.GA30267@dcvr.yhbt.net>
Reply-To: babka@bestmail.us
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtoV2-00025s-Cs
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 21:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbZDNTjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbZDNTjT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 15:39:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:52871 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZDNTjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 15:39:18 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1404214wah.21
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 12:39:17 -0700 (PDT)
Received: by 10.114.125.18 with SMTP id x18mr3857696wac.220.1239737957037;
        Tue, 14 Apr 2009 12:39:17 -0700 (PDT)
Received: from ?9.53.51.163? ([32.97.110.53])
        by mx.google.com with ESMTPS id n30sm7461023wag.21.2009.04.14.12.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Apr 2009 12:39:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090411020919.GA30267@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116559>

The exact same thing happens on a Linux (RedHat) machine. I don't know 
of any public repositories that I could run this against.

Jim Babka.

Eric Wong wrote:
> Jim Babka <jim@babkas.info> wrote:
>   
>> I need some help. I have tried both the native Windows git (git version  
>> 1.6.2.2.1669.g7eaf8, coming from Git-1.6.2.2-preview20090408) and the  
>> git in Cygwin (git version 1.6.1.2), but I see almost the same behavior.  
>> I try to run the following command and see the following results:
>>     
>
> Hi Jim,
>
> Can you test the clone operation from a Linux/Unix machine?  Does
> git-svn on Windows work for you with other (public) repositories?  I
> can't support Windows other than accepting patches from others.
>
>   
