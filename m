From: Knut Eldhuset <knut@3d-radar.com>
Subject: Re: Different svn-id URLs in history
Date: Thu, 09 Oct 2008 08:16:29 +0200
Message-ID: <48EDA1BD.6070209@3d-radar.com>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net> <48EC546F.7060106@3d-radar.com> <48EC7022.7030707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 08:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnoqK-0005Rr-FL
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbYJIGQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbYJIGQd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:16:33 -0400
Received: from epost.nunatak.no ([193.200.93.202]:59684 "EHLO epost.nunatak.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891AbYJIGQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:16:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by epost.nunatak.no (Postfix) with ESMTP id 1791E121C96E;
	Thu,  9 Oct 2008 08:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.425
X-Spam-Level: 
X-Spam-Status: No, score=-2.425 tagged_above=-10 required=6.6
	tests=[AWL=0.074, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from epost.nunatak.no ([127.0.0.1])
	by localhost (epost.nunatak.no [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9AunsWReFpki; Thu,  9 Oct 2008 08:16:30 +0200 (CEST)
Received: from [192.168.169.42] (unknown [194.19.26.200])
	by epost.nunatak.no (Postfix) with ESMTP id A115D121C96A;
	Thu,  9 Oct 2008 08:16:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48EC7022.7030707@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97829>

Michael J Gruber wrote:
> svn is typically "abused" in the sense that one svn repo is used for
> separate projects (your subtrees). git-svn can deal with non-standard
> repo layouts.
> 

I've decided to give up on cloning the whole svn repo. Cloning just our 
src folder is sufficient for now, and it does follow a sensible repo layout.

Maybe I'll get back to this if I manage to find a way of reproducing the 
previously described behavior.

Regards,
Knut
