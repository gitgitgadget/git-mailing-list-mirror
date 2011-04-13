From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 15:16:54 -0400
Message-ID: <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
	 <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
	 <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:17:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA5Z5-0006r9-0k
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757050Ab1DMTRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:17:18 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:46781 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756746Ab1DMTRR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:17:17 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3DJGxT7014567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Apr 2011 15:17:05 -0400
In-Reply-To: <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=4 Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3DJGxT7014567
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303327026.0827@0NC3LiQkzPW+cjO+ROPpaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171475>


On Wed, 2011-04-13 at 12:09 -0700, Joshua Juran wrote:
> On Apr 13, 2011, at 11:59 AM, Drew Northup wrote:
> 
> > On Wed, 2011-04-13 at 11:16 -0700, Daniel Searles wrote:
> >> Hi All,
> >>
> >> I'm curious if Gitbox is in violation of the Git's GPL.
> >> http://www.gitboxapp.com/
> >>
> >> Thank you,
> >> Daniel Searles
> >> Tech Support
> >> Media Lab, Inc.
> >
> > Well, it appears that he may have implemented "git" on his own, or at
> > the very least he's trying to imply that he did.
> >
> > http://www.gitboxapp.com/faq.html#gpl
> 
> He very clearly says that he ships Git, not a reimplementation.

He also clearly stated that he's not calling git command-line tools...

"Gitbox neither links (statically or dynamically) against Git nor uses
custom interfaces to interact with it. Git binaries are provided for
your convenience only."

I'm hoping he'll have a more complete statement for all of us.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
