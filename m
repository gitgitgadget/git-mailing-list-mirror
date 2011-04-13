From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 16:26:28 -0400
Message-ID: <20110413202627.GD11019@foodlogiq3-xp-d620>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
 <1302721187.21900.4.camel@drew-northup.unet.maine.edu>
 <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
 <1302722214.22161.5.camel@drew-northup.unet.maine.edu>
 <86vcyigcqy.fsf@red.stonehenge.com>
 <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA6eB-00063D-9h
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 22:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758570Ab1DMU0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 16:26:34 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44165 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563Ab1DMU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 16:26:31 -0400
Received: by yia27 with SMTP id 27so406905yia.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=leImqPCkHLODY7HPvIx7VOU0X8lJ0sbxx23SVnkmE58=;
        b=ibP5mx2NdUk5jsHSswg28B6CHiruQsNvhw/Tb+Sfilpj5dp0aPXDfkjSsUhd6LzPRJ
         PIEFVl5KFOERrfIxVIBZnLFe7yQqwcMou03kKZjKhZCoXnH2s0sEPzp04TyiVw7zBhOS
         HpVuCcW/jaBfbV1JWVqclnARQuRa9Oiq7WT+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j4yGSedvz6ZXYIQURryChpt5mKnrvrIBHo+TymNggUewrcMMQNVWSJe4V00JYKzW/D
         TMTvD5FWE4AvHYt/lSBQAtjyXjdAQZPgur2nhC8FyKgW70Px7sKpXShfmRHi2858hk9q
         UOYKmqU+a2FxZ7VG+b9a/gu6A7C4dRoFsgUSU=
Received: by 10.91.73.24 with SMTP id a24mr912956agl.122.1302726390986;
        Wed, 13 Apr 2011 13:26:30 -0700 (PDT)
Received: from foodlogiq3-xp-d620 (rrcs-70-61-89-105.midsouth.biz.rr.com [70.61.89.105])
        by mx.google.com with ESMTPS id k16sm898181anb.11.2011.04.13.13.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 13:26:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171484>

Drew Northup, Wed, Apr 13, 2011 at 04:04:49PM -0400:
> If that's what he's doing then why does he state that the git binaries
> are "for your convenience only"--strongly implying his program will
> work in the absence thereof? I'm hoping he just made a typo--as what
> he said is there in plain English, and is somewhat contradicted by the
> next sentence. If he's indeed using the plumbing then the binaries are
> required--which is indeed what they are there for. 

I didn't detect that implication at all. I took it to mean that he is
distributing Git alongside his frontend because it would not function
properly without it. It's a "convenience" in the sense that if he didn't
bundle the Git binaries, you'd have to install them separately in order
to use his product. Why would he bother to include Git itself if the
product worked just fine without it?


> I think that I've already proved myself to be one of the list's
> resident grammar nazis. If you wish to dispute my interpretation of
> his grammar please contact me directly and don't bother the rest of
> the list.

Sending this to the list anyway, because it seems germane to the overall
discussion.
