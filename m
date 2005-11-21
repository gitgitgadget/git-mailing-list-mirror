From: llandre <r&d2@dave-tech.it>
Subject: Re: cvsimport and RTAI repository
Date: Mon, 21 Nov 2005 16:42:12 +0100
Message-ID: <4381EAD4.8090901@dave-tech.it>
References: <4381E565.4020108@dave-tech.it> <Pine.LNX.4.63.0511211625300.23247@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 16:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeDn5-00052D-Qk
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 16:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVKUPlI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVKUPlI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 10:41:08 -0500
Received: from host46-203.pool8538.interbusiness.it ([85.38.203.46]:19972 "HELO
	dave-tech.it") by vger.kernel.org with SMTP id S932286AbVKUPlH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 10:41:07 -0500
Received: (qmail 17001 invoked by uid 0); 21 Nov 2005 16:45:00 -0000
Received: from unknown (HELO ?192.168.0.6?) (192.168.2.253)
  by 192.168.2.1 with SMTP; 21 Nov 2005 16:45:00 -0000
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511211625300.23247@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12449>

Hi Johannes,

thanks for your advice but unfortunately it did not work :(

> Hi,
> 
> On Mon, 21 Nov 2005, llandre wrote:
> 
> 
>>cvs [rlog aborted]: received abort signal
>>[...]
> 
> 
> Maybe rlog does not work here... Have you tried
> 
> 	git-cvsimport -p --no-rlog ...
> 
> ? This passes the option --no-rlog to cvsps which helped me once.



-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2@dave-tech.it
