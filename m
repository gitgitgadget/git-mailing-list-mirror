From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 22 May 2010 12:26:39 -0600
Message-ID: <4BF821DF.8040300@workspacewhiz.com>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	 <m34oi1s13e.fsf@localhost.localdomain> <1274543931.21346.171.camel@Luffy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 20:26:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFtPR-0007fL-81
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab0EVS0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 14:26:47 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:35709 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab0EVS0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 14:26:46 -0400
Received: (qmail 22727 invoked by uid 399); 22 May 2010 12:26:45 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 22 May 2010 12:26:45 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.5pre) Gecko/20100430 Lightning/1.0b2pre Thunderbird/3.1b2
In-Reply-To: <1274543931.21346.171.camel@Luffy>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147536>

  ----- Original Message -----
From: Daniele Segato
Date: 5/22/2010 9:58 AM
>> There is also Gerrit, a web based code review system, which runs in
>> any standard Java servlet container.
> Did someone worked with some of them and have a review or an opinion
> about them?
I use http://redmine.org/.  It has Git support and generally works 
great.  There is a decent set of plug-ins for it, too.

I set up Gerrit, and I really like what I see there.  Not only does it 
have code review functionality built in, it also knows how to merge 
changes automatically (as I understand it) when everyone buys off on the 
change.

Josh
