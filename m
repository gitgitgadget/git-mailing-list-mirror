From: Charles Duffy <cduffy@spamcop.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 06:30:29 -0500
Message-ID: <453761D5.80306@spamcop.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE> <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE> <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4536DBB1.6050701@spamcop.net> <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de> <45375D16.90204@spamcop.net> <Pine.LNX.4.63.0610191321090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 13:31:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaW6y-0005rJ-GP
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWJSLax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 07:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJSLax
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:30:53 -0400
Received: from smtp.isgenesis.com ([204.57.75.199]:48104 "EHLO isgenesis.com")
	by vger.kernel.org with ESMTP id S1161395AbWJSLaw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:30:52 -0400
Received: from [69.91.92.72] (account ccd HELO [192.168.1.10])
  by isgenesis.com (CommuniGate Pro SMTP 5.0.4)
  with ESMTPSA id 1296734; Thu, 19 Oct 2006 06:30:50 -0500
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610191321090.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29342>

Johannes Schindelin wrote:
>> Shell scripts allow for a fragile system because they could include C code
>> snippets which they then compile and LD_PRELOAD.
>>     
>
> Well, I do not expect people to misbehave. You do not compile a nasty 
> C-program from a shell script _by mistake_.
>   

You also don't replace bzrlib functionality (in your terms, plumbing) in 
a plugin by mistake.

> I also expect people not to constantly miss my point.

I think your point is predicated on a misunderstanding of how plugins work.
