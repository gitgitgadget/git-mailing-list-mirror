From: Andreas Ericsson <ae@op5.se>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 17:41:34 +0100
Message-ID: <44032BBE.6090608@op5.se>
References: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org> <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer> <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com> <4402E56D.4010606@op5.se> <20060227133124.GA8794@informatik.uni-freiburg.de> <4403086F.5040704@op5.se> <20060227163709.GA12538@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:42:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlRL-0005vD-LL
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWB0Qlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWB0Qlg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:41:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:33715 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751491AbWB0Qlg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 11:41:36 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 20DA86BD10; Mon, 27 Feb 2006 17:41:35 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060227163709.GA12538@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16861>

Uwe Zeisberger wrote:
> Andreas Ericsson wrote:
> 
>>Uwe Zeisberger wrote:
>>
>>>Hello,
>>>
>>>Andreas Ericsson wrote:
>>>
>>>
>>>>I think the question is whether completely empty lines are also ignored 
>>>>by Python, or if they start a new block of code. Whatever the case, it 
>>>>must hold true for both 2.3 and 2.4.
>>>
>>>see
>>>	http://www.python.org/doc/2.2.3/ref/blank-lines.html
>>>	http://www.python.org/doc/2.3.5/ref/blank-lines.html
>>>	http://www.python.org/doc/2.4.2/ref/blank-lines.html
>>>
>>
>>So in essence, a multi-line statement is closed when a completely empty 
>>line is found,
> 
> Wrong.
> 
> i.e. In scripts, lines containing only (zero or more) whitespaces are
> ignored.
> 

I stand corrected. Thrice, even. Voi, voi... :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
