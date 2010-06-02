From: Andreas Krey <a.krey@gmx.de>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Wed, 2 Jun 2010 07:19:07 +0200
Message-ID: <20100602051907.GA19934@inner.home.ulmdo.de>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com> <4BF7B751.7050704@pileofstuff.org> <4BFB7F7F.5090407@drmicha.warpmail.net> <4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com> <4C0577D1.6030805@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:19:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgMK-0003jz-GE
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0FBFTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:19:15 -0400
Received: from continuum.iocl.org ([213.146.114.200]:62994 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0FBFTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:19:15 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o525J7H20980;
	Wed, 2 Jun 2010 07:19:07 +0200
Content-Disposition: inline
In-Reply-To: <4C0577D1.6030805@pileofstuff.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148201>

On Tue, 01 Jun 2010 22:12:49 +0000, Andrew Sayers wrote:
...
> I think it's also worth mentioning local/remote commits, as it's quite
> easy for people to commit and forget to push.

I found (for myself) 'gitk --all' making it lots easier to see the light
in these regards. (Missing such a thing for svn sorely.) Doing a fetch,
pressing F5 and seeing the remote branches move. Or diverge.

Andreas
