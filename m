From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problems with using git
Date: Thu, 02 Mar 2006 14:59:34 +0100
Message-ID: <4406FA46.7080608@op5.se>
References: <44063B7C.40609@webdrake.net> <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org> <4406F8B1.9050303@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 15:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEoLD-0005u2-35
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 14:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWCBN7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 08:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCBN7g
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 08:59:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:38111 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751168AbWCBN7f
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 08:59:35 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 7F2616BCBE; Thu,  2 Mar 2006 14:59:34 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
In-Reply-To: <4406F8B1.9050303@webdrake.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17071>

Joseph Wakeling wrote:
> Thanks very much to all who offered advice on this. :-)
> 
> Unfortunately openSUSE is somewhat out of sync not just with git but in
> libraries necessary to install the latest version (libcrypto.so.4,
> libssl.so.4).  The openssl (0.9.7g-2.4) and openssl-devel (0.9.7g-2)
> packages don't contain these but rather contain libcrypto.so.0.9.7 and
> libssl.0.9.7.  Just in case it's important to future git development.
> 

It might be useful for the openSuSE developers, but for git this is 
totally irrelevant. If you build from sources yourself they will be 
linked to whatever libraries you have installed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
