X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 21:58:33 -0300
Message-ID: <200612150058.kBF0wX23005507@laptop13.inf.utfsm.cl>
References: <arekm@maven.pl>
NNTP-Posting-Date: Fri, 15 Dec 2006 00:59:29 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Arkadiusz Miskiewicz <arekm@maven.pl> 
   of "Thu, 14 Dec 2006 20:00:54 BST." <200612142000.54409.arekm@maven.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:00:01 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 14 Dec 2006 21:58:50 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34458>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv1Q5-0003E5-Tf for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932675AbWLOA7K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWLOA7J
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:59:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35825 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932681AbWLOA7I (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 19:59:08 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kBF0wlnO005321 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 14 Dec 2006 21:58:50 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBF0wX23005507; Thu, 14
 Dec 2006 21:58:34 -0300
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Sender: git-owner@vger.kernel.org

Arkadiusz Miskiewicz <arekm@maven.pl> wrote:

[...]

> ps. I'm blind or there is no documentation about what utilities are needed to 
> get git fully working? (like sed, coreutils, grep, rcs package (merge tool 
> afaik needed)...). 

Look at the .spec (or .spec.in) file, they record what the running git
needs.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
