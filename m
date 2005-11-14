From: Andreas Ericsson <ae@op5.se>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 15:32:13 +0100
Message-ID: <43789FED.7060401@op5.se>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se> <20051114132956.GT30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 14 15:36:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbfNf-0002pS-E3
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVKNOcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVKNOcP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:32:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:15810 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751133AbVKNOcP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:32:15 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BEB326BD00
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 15:32:13 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20051114132956.GT30496@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11802>

Petr Baudis wrote:
> Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
> where Andreas Ericsson <ae@op5.se> said that...
> 
>>		--prefix=*)
>>			prefix=${1##*=}
> 
> 
> Aren't those heavy bashisms?
> 

Dunno. I only know bash-scripting, really. I'll replace them with some 
sed thing instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
