From: Craig Schlenter <craig@codefountain.com>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 15:40:50 +0200
Message-ID: <cae2e895f6598781f4f22b76e781684b@codefountain.com>
References: <1131800663.29461.11.camel@blade>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 12 14:45:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EavgA-0005pj-SF
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKLNoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 08:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVKLNoY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:44:24 -0500
Received: from mail-01.jhb.wbs.co.za ([196.30.31.196]:4862 "EHLO
	mail-01.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S932361AbVKLNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 08:44:23 -0500
Received: from wbs-196-2-115-130.wbs.co.za ([196.2.115.130] helo=[172.17.17.2])
	by mail-01.jhb.wbs.co.za with esmtp (Exim 4.50)
	id 1Eavfr-0000ZH-3c
	for git@vger.kernel.org; Sat, 12 Nov 2005 15:44:07 +0200
In-Reply-To: <1131800663.29461.11.camel@blade>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.623)
X-Original-Subject: Re: Remove unneeded packs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11687>

On 12 Nov 2005, at 3:04 PM, Marcel Holtmann wrote:

> every time Linus re-creates the pack for his linux-2.6 tree, I end up
> with another pack. I use HTTP as transport and thus the new pack will 
> be
> download (which is almost 100 MB), but that is fine.
> [snip]

The 100MB situation is not cool for those of us on a tight bandwidth
budget or slow links. Can anyone tell me if the native git protocol is
any better at this stuff please?

Thanks,

--Craig
