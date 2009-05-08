From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Fri, 08 May 2009 13:09:11 +0200
Message-ID: <op.utlylkb61e62zd@balu>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
 <op.utlq3vgx1e62zd@merlin.emma.line.org>
 <7vprek0ywq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 13:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2NxT-0001mm-Hc
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 13:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZEHLJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 07:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZEHLJO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 07:09:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:41577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752214AbZEHLJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 07:09:13 -0400
Received: (qmail invoked by alias); 08 May 2009 11:09:12 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu) [131.234.21.37]
  by mail.gmx.net (mp001) with SMTP; 08 May 2009 13:09:12 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX180Na5Ilxo0Ldk5EFUmVudXNWKLNZK691er41CzPa
	8qkS858ZJFvnZj
In-Reply-To: <7vprek0ywq.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118599>

Am 08.05.2009, 10:41 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> "Matthias Andree" <matthias.andree@gmx.de> writes:
>
>>> Interesting.  I wonder if you need the change to the Makefile.
>>>
>>> As long as GIT-VERSION-GEN notices that you have a freshly built git
>>> available (test -x) and uses it, falling back to whatever on the PATH,  
>>> it
>>> would not have to touch GIT-VERSION-FILE, no?
>>
>> Hi Junio,
>>
>> ... Let's not introduce second-guessing into
>> the script....
>
> Fine then.  Or you could just append "." to the $PATH ;-)

"." in the super user's PATH? Cool stuff, and so innovative. Economy  
crisis special offer - get the barndoor-sized hole for a piece bird dung.  
Special offer valid only today, while stocks last...

SCNR.

-- 
Matthias Andree
