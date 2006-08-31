From: Jorma Karvonen <karvjorm@users.sourceforge.net>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 20:25:13 +0300
Message-ID: <44F71B79.5070901@users.sourceforge.net>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net> <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F71557.1080404@users.sourceforge.net> <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: karvjorm@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 19:26:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIqHm-0001Hn-5J
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 19:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWHaRY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 13:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHaRY4
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 13:24:56 -0400
Received: from smtp1.song.fi ([194.100.2.124]:13158 "EHLO smtp1.song.fi")
	by vger.kernel.org with ESMTP id S932214AbWHaRYz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 13:24:55 -0400
Received: from [192.168.1.34] (dsl-60-2-216-83.maxinetti.fi [83.216.2.60])
	by smtp1.song.fi (Postfix) with ESMTP id 150C617E7A3;
	Thu, 31 Aug 2006 20:24:53 +0300 (EEST)
User-Agent: Thunderbird 2.0a1 (X11/20060724)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608311904520.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26270>

Johannes Schindelin wrote:
> Hi,
>
> On Thu, 31 Aug 2006, Jorma Karvonen wrote:
>
>   
>> I tried
>>
>> make configure
>>
>> and got an error message:
>>
>> /bin/sh: curl-config: command not found
>> make: **** No rule to make target `configure'. Stop.
>>     
>
> Okay. I deem this a bug in our Makefile.
>
> Could you please try "autoconf" and _then_ "./configure"?
>
> Hth,
> Dscho
>
>   
Hi,

I tried autoconf and result was:

autoconf: no input file

Best regards,

Jorma Karvonen
karvjorm (at) users (dot) sourceforge (dot) net
