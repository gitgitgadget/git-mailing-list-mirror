From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration
 file.
Date: Mon, 05 Dec 2005 12:32:45 +0100
Message-ID: <4394255D.1030009@op5.se>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net> <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Dec 05 12:35:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjEbM-00071b-IH
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 12:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVLELdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 06:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVLELdK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 06:33:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:11471 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932371AbVLELdJ
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 06:33:09 -0500
Received: from [129.16.248.6] (dhcp-248-6.nomad.chalmers.se [129.16.248.6])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 672E06BCFE
	for <git@vger.kernel.org>; Mon,  5 Dec 2005 12:32:46 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13211>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> 
>>It is just silly to start the file called "config" with a
>>comment that says "This is the config file."
> 
> 
> Any likes or dislikes?
> 

I believe we all agree in silent consensus.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
