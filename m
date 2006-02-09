From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: git + ssh + key authentication feature-request
Date: Thu, 09 Feb 2006 02:16:18 +0100
Message-ID: <43EA97E2.5060700@iaglans.de>
References: <43EA73C3.2040309@iaglans.de> <7vhd79o6m5.fsf@assigned-by-dhcp.cox.net> <43EA7D57.7040409@iaglans.de> <7v4q39o3xs.fsf@assigned-by-dhcp.cox.net> <43EA8DDA.3070906@iaglans.de> <Pine.LNX.4.64.0602081545330.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 01:17:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6zV2-0004qR-6G
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 01:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWBIARZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422724AbWBIARZ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 19:17:25 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:10502 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422720AbWBIARX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 19:17:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A081B3E9D
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 01:17:22 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00825-07 for <git@vger.kernel.org>;
	Thu, 9 Feb 2006 01:17:21 +0100 (CET)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 3CE6B3E51
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 01:17:20 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602081545330.2458@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15773>

Linus Torvalds wrote:
> 
> On Thu, 9 Feb 2006, Nicolas Vilz 'niv' wrote:
> 
>>So, how do i tell git to send my identity-file to sshd? And could I set an
>>alias like in .git/remotes for that location / identity?
> 
> 
> Use a "fake host".
> 
[...ssh config...]

> 
> (Yeah, I forget the exact ssh config file format, so you should 
> double-check that.)

i will do that.. :))

I thank you all for your help.

Nicolas
