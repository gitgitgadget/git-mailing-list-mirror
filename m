From: "Marc Fargas" <telenieko@telenieko.com>
Subject: Re: git-svn: Having a "rare" structure
Date: Wed, 5 Nov 2008 18:46:19 +0100
Message-ID: <2686a05b0811050946n3aa524e2k5515967180ffb829@mail.gmail.com>
References: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>
	 <49119AAD.2010803@drmicha.warpmail.net>
	 <2686a05b0811050736q520f1771t6ffa2840bfb3c308@mail.gmail.com>
	 <4911DADA.4010902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:47:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmTg-0007if-3H
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbYKERqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 12:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbYKERqV
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:46:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:41254 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755613AbYKERqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 12:46:20 -0500
Received: by yw-out-2324.google.com with SMTP id 9so70496ywe.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 09:46:19 -0800 (PST)
Received: by 10.151.110.14 with SMTP id n14mr2039570ybm.245.1225907179210;
        Wed, 05 Nov 2008 09:46:19 -0800 (PST)
Received: by 10.150.57.12 with HTTP; Wed, 5 Nov 2008 09:46:19 -0800 (PST)
In-Reply-To: <4911DADA.4010902@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100167>

Hi,

On Wed, Nov 5, 2008 at 6:41 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> You can delete the bogus branches (using git branch -rd or git
> update-ref -d), but I'm not sure if you can reset git svn's state info:
> You may try messing with .git/svn/.metadata.

I'll try it, if not I'll recreate the repo from scratch ;)) Thanks for the tips!

> I tried the approach I suggested in the last post for real, and things
> seem to work. Only gotcha is I don't know whether django folks will
> stick with putting branches under {releases,features}, that would create
> problems

They say they won't put more folders in branches/ ;))

Thanks again for the tips, that will solve lots of trouble. Thanks!

Cheers.
Marc

-- 
http://www.marcfargas.com - will be finished someday.
