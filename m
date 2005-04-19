From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 16:19:01 -0600
Message-ID: <426583D5.2020308@mesatop.com>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO108-0004Xv-6G
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVDSWT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDSWT0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:19:26 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:4044 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261697AbVDSWTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:19:09 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JMJ6Kc008209;
	Tue, 19 Apr 2005 16:19:06 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3JMJ1xs023766;
	Tue, 19 Apr 2005 16:19:01 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 19 Apr 2005, Greg KH wrote:
> 
>>Nice, it looks like the merge of this tree, and my usb tree worked just
>>fine.
> 
> 
> Yup, it all seems to work out.

[many files patched]
patching file mm/mmap.c
patching file net/bridge/br_sysfs_if.c
patching file scripts/ver_linux
----------------------^^^^^^^^^
Hey, that's my patch!  Last...and least.
But perhaps a progress bar right about here might be
a good thing for the terminally impatient.

real    3m54.909s
user    0m14.835s
sys     0m10.587s

4 minutes might be long enough to cause some folks to lose hope.

Steven

