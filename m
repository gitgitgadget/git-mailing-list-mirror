From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-rename
Date: Mon, 09 Jan 2006 09:28:17 +0100
Message-ID: <43C21EA1.9020504@op5.se>
References: <20060108.222045.21927554.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 09:28:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvsO6-0004Aw-Kk
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 09:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWAII2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 03:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWAII2T
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 03:28:19 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:1159 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750880AbWAII2T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 03:28:19 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id C25BB6BCBE; Mon,  9 Jan 2006 09:28:17 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060108.222045.21927554.davem@davemloft.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14362>

David S. Miller wrote:
> Any particular reason why that little tool doesn't get installed by
> "make install"?  Is it deprecated?
> 

It's obsoleted by git-mv. If you have git-rename at all you most likely 
have built the pu branch some time past and not done "make clean".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
