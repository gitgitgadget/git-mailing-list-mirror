From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 16:04:49 -0400
Message-ID: <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
	 <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
	 <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
	 <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
	 <86vcyigcqy.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:05:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA6K5-00022P-GK
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 22:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab1DMUFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 16:05:52 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:55760 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757987Ab1DMUFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 16:05:51 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3DK4snN018328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Apr 2011 16:04:54 -0400
In-Reply-To: <86vcyigcqy.fsf@red.stonehenge.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3DK4snN018328
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303329908.70104@XkobQENBhlQdm5alzJUxvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171483>


On Wed, 2011-04-13 at 12:41 -0700, Randal L. Schwartz wrote:
> >>>>> "Drew" == Drew Northup <drew.northup@maine.edu> writes:
> 
> Drew> He also clearly stated that he's not calling git command-line tools...
> 
> Drew> "Gitbox neither links (statically or dynamically) against Git nor uses
> Drew> custom interfaces to interact with it. Git binaries are provided for
> Drew> your convenience only."
> 
> Huh?  How do you get "not using git CLI" there?  He's not using *custom*
> interfaces, but the *standard* interfaces are more than enough.
> 
> He's made new porcelein, and using the plumbing directly.  That's
> exactly why we have plumbing in git, right?

If that's what he's doing then why does he state that the git binaries
are "for your convenience only"--strongly implying his program will work
in the absence thereof? I'm hoping he just made a typo--as what he said
is there in plain English, and is somewhat contradicted by the next
sentence. If he's indeed using the plumbing then the binaries are
required--which is indeed what they are there for. 

I think that I've already proved myself to be one of the list's resident
grammar nazis. If you wish to dispute my interpretation of his grammar
please contact me directly and don't bother the rest of the list.

I suspect that when he gets a chance he'll be able to clarify what he's
doing well enough on his own.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
