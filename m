From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sun, 24 Dec 2006 15:07:04 -0300
Message-ID: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl>
References: <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752444AbWLXSHV@vger.kernel.org Sun Dec 24 19:09:15 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752444AbWLXSHV@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyXmW-0002qC-BC
	for glk-linux-kernel-3@gmane.org; Sun, 24 Dec 2006 19:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbWLXSHV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 24 Dec 2006 13:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWLXSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 13:07:20 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33912 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbWLXSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 13:07:19 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBOI75hW021919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2006 15:07:06 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBOI746w008739;
	Sun, 24 Dec 2006 15:07:04 -0300
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: Message from Jeff Garzik <jeff@garzik.org> 
   of "Wed, 20 Dec 2006 22:04:17 CDT." <4589F9B1.2020405@garzik.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:01:51 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 24 Dec 2006 15:07:08 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35369>

Jeff Garzik <jeff@garzik.org> wrote:
> I refreshed my git intro/cookbook for kernel hackers, at
> http://linux.yyz.us/git-howto.html

Looks nice, starting to look it over.

Notes:

Getting started:

  There are RPM packages available (I think they are for latest Fedora; in
  case of doubt get the latest SRPM and build yourself, sometimes the
  distros lag /way/ behind). There are also Debian packages there, dunno
  about those.

Basic tasks:

  'git pull' should be enough, no need to give the URL each time.
  It is useful to tell people how to get "nonofficial" branches (via URL +
  branches) too.
  

Miscellaneous debris:

  'git pull' has gotten tags each time for me?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
