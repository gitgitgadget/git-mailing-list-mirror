From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: fnmatch vs regex
Date: Wed, 5 Mar 2014 22:28:07 +0100
Message-ID: <CAL0uuq0UaB0NF8rBP3TWGOUrT_jCMnFKKvweJ9d+XeYWPw300w@mail.gmail.com>
References: <CAKOJyXc2dezciw=x=-Gw3qjt3Sd=V=2Dy_ARZ25kmjYHULT5_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Vincenzo di Cicco <enzodicicco@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:28:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLJMN-00057v-2v
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 22:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265AbaCEV2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 16:28:10 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:38718 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbaCEV2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 16:28:08 -0500
Received: by mail-vc0-f176.google.com with SMTP id lc6so1192029vcb.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 13:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3QS1lh6fQDTvEc6etviJ9QxI6gkeqy3QSjpxp4NbQmc=;
        b=Q2tJqO180RbKLxknbGWn2zKlmvnl260YDPmFNwzUqdCrxIZr5wp7Riar8G7tg5tCaE
         srn3/6TzpeT8Fd/wy32150jdOx5sEgwZB/SFg/of5EogmAxNhLyyXYvDCvIhHlZLkxfD
         GNrfq1UPPPHxRt+JHU0X5Sr03l1cu9UG6Ecz0fak3cU7sNFZm2IguGW+BMWzKpnXW/S3
         m8URqEx6rgtFBNKwg5JL17BTOG2dRyFREBYO2yETYsLOjR/eJlwYshZ47NbOutInV98A
         kesWsy9C40ElPjfycWxW3siwvFU+kKHL0Rd7TpYJXN8tbFUrrj/1O7bbW3BE+DrmO1xy
         ge4w==
X-Received: by 10.58.133.15 with SMTP id oy15mr1911708veb.19.1394054887271;
 Wed, 05 Mar 2014 13:28:07 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Wed, 5 Mar 2014 13:28:07 -0800 (PST)
In-Reply-To: <CAKOJyXc2dezciw=x=-Gw3qjt3Sd=V=2Dy_ARZ25kmjYHULT5_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243483>

On Wed, Mar 5, 2014 at 8:55 PM, Vincenzo di Cicco <enzodicicco@gmail.com> wrote:
> Hi there, I'm NaN.
> Recently I enrolled to this mailing list thanks to the GSoC.
> I've looked the Ideas Page but -unfortunately- some projects are very
> difficult for me.

Hi Vincenzo!

I also got interested in contributing to Git because of GSoC. I
encourage you to try doing a microproject: the coding part can be
*really* trivial. For example, mine just involved deleting lines
(after, of course, explaining why they weren't needed anymore). If you
are having trouble following the instructions in
Documentation/SubmittingPatches I recommend this video:
https://www.youtube.com/watch?v=LLBrBBImJt4.
