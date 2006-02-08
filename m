From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 09 Feb 2006 00:23:03 +0100
Message-ID: <43EA7D57.7040409@iaglans.de>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 08 23:24:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6xjV-0006HY-Vo
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 23:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWBHWYP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWBHWYP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 17:24:15 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:24069 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S965190AbWBHWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 17:24:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 5CB293E9D
	for <git@vger.kernel.org>; Wed,  8 Feb 2006 23:24:03 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28003-10 for <git@vger.kernel.org>;
	Wed, 8 Feb 2006 23:24:02 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 8C06D3E51
	for <git@vger.kernel.org>; Wed,  8 Feb 2006 23:24:01 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15756>

Junio C Hamano wrote:
> Nicolas Vilz 'niv' <niv@iaglans.de> writes:
> 
> 
>>I would like to ask if it is possible to use ssh keys to authenticate
>>via ssh on a git repository via git-pull/git-push. Since ssh supports
>>them, wouldn't it be nice to use them in git, too?
> 
> 
> Please read what has been discussed within the last couple of
> weeks at least.  I could say the last couple of months but I
> know that is asking too much ;-).
> 
> http://thread.gmane.org/gmane.comp.version-control.git/15462
> 

Sorry, i haven't found that, yet, so i asked..

in my case it would be only one system-user which has full access to 
several repositories. At this time, the users which use that account, 
have to give a password, which isn't that bad... it would be easier and 
more secure for me, not to give a password, but ask the users for the 
ssh pubkey..

I can still live with the password thing :)

Sincerly
Nicolas
