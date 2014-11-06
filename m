From: victor <liwenxi9999@163.com>
Subject: Re: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Thu, 6 Nov 2014 00:36:49 -0800 (PST)
Message-ID: <1415263009541-7620695.post@n2.nabble.com>
References: <1415251144220-7620692.post@n2.nabble.com> <1415255667304-7620693.post@n2.nabble.com> <1415259507566-7620694.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 09:36:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmIYo-00087I-IH
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 09:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbaKFIgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 03:36:50 -0500
Received: from sam.nabble.com ([216.139.236.26]:39303 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbaKFIgu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 03:36:50 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <liwenxi9999@163.com>)
	id 1XmIYj-0003In-Hk
	for git@vger.kernel.org; Thu, 06 Nov 2014 00:36:49 -0800
In-Reply-To: <1415259507566-7620694.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I used below command to configure:
./configure --prefix=/usr/local/git-2.1.3/ --disable-pthreads

Actually, I think the error message is quite clear this time, it is about
hook of "Deleting a tag is not allowed in this repository".

Can I try to disable the hook?

Thanks,
Victor



--
View this message in context: http://git.661346.n2.nabble.com/Installed-git-2-1-3-on-sparc-8-but-got-core-dump-during-git-clone-tp7620692p7620695.html
Sent from the git mailing list archive at Nabble.com.
