From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Wed, 02 Nov 2005 09:08:52 +0100
Message-ID: <43687414.1030702@op5.se>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org> <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz> <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com> <20051101234302.GD1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:09:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXDg1-0006Le-0l
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVKBIIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVKBIIy
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:08:54 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3310 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932264AbVKBIIx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:08:53 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id B9D746BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:08:52 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051101234302.GD1431@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11004>

Petr Baudis wrote:
> 
> Another possibility is to make the height dynamic and in proportion with
> the number of affected files. Or combine both the color and dynamic
> height. I believe changing the color to red would make it appear as
> black for the red-color-blind people?
> 

Color-blindness doesn't work like that. There are no "red-color-blind" 
people. It's either red-blue, red-green or blue-green and the problem 
lies in differing those colors from each other when they're close 
together (and, usually, intermixed). Red-green color-blindness is by far 
the most common so it would be wise not to use those.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
