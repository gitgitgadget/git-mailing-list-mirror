From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Fri, 01 Feb 2008 20:53:21 -0800
Message-ID: <47A3F741.6070501@saville.com>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202040637.GA24478@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 05:54:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLAON-0001fI-Fy
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 05:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761489AbYBBExZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 23:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755024AbYBBExZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 23:53:25 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:16443 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbYBBExY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 23:53:24 -0500
Received: by an-out-0708.google.com with SMTP id d31so338350and.103
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 20:53:23 -0800 (PST)
Received: by 10.100.57.6 with SMTP id f6mr9051615ana.78.1201928003814;
        Fri, 01 Feb 2008 20:53:23 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id t26sm8836871ele.4.2008.02.01.20.53.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Feb 2008 20:53:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080202040637.GA24478@soma>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72224>

Eric Wong wrote:
> Wink Saville <wink@saville.com> wrote:
>   
>> Wink Saville wrote:
>>     
>>> I was doing an git-svn dcommit and got a seg fault. The first
>>> phase of updating svn completed and then it seg faulted on the
>>> second. So I suspect I'm out of sync and need to recover,
>>> any guidance appreciated.
>>>
>>> If it's any help the svn repo is at 
>>> http://async-msgcomp.googlecode.com/svn.
>>> If someone needs it I happen to have a backup of the git repo before
>>> doing the commit and then after the seg fault.
>>>
>>> If there is any other information that someone needs I can try
>>> to supply it.
>>>       
>
> Which version of the SVN bindings do you have installed?
>
>   
I've installed 1.4.4 as supplied in ubuntu 7.10.
