From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 22:18:42 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301172216310.2151@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com> <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca> <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Lang, David" <David.Lang@uhn.ca>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Smith <ishchis2@gmail.com>
To: Matt Seitz <mseitz@mhseitz.onmicrosoft.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 07:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw5K7-0000AC-HH
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 07:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab3ARGUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 01:20:46 -0500
Received: from mail.lang.hm ([64.81.33.126]:37422 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3ARGUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 01:20:46 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0I6K7OP008046;
	Thu, 17 Jan 2013 22:20:07 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213906>

On Fri, 18 Jan 2013, Matt Seitz wrote:

> From: git-owner@vger.kernel.org [git-owner@vger.kernel.org] on behalf of Lang, David [David.Lang@uhn.ca]
>
> The other David Lang (david@lang.hm) believes that using "git push" using NFS or CIFS/SMB may not be safe and reliable.  Based on the following article by the creator of git, I believe using "git push" over NFS or CIFS/SMB is safe and reliable:
>
> http://permalink.gmane.org/gmane.comp.version-control.git/122670
>
> The GitFaq wiki also says that using "git push" over NFS or CIFS/SMB is safe and reliable:
>
> https://git.wiki.kernel.org/index.php/GitFaq#What_can_I_use_to_set_up_a_public_repository.3F

I'm glad to learn that git is more robust than I feared.

David Lang
