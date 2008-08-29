From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Subject: [PATCH] Update to the git tutorial
Date: Fri, 29 Aug 2008 12:22:19 +0200
Message-ID: <4d8e3fd30808290322o66764cb2tafaf91ff86ca7b4c@mail.gmail.com>
References: <48B698D8.6080300@vodafone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 29 12:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ18Y-0004xO-27
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 12:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbYH2KWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYH2KWU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 06:22:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:2818 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYH2KWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 06:22:20 -0400
Received: by wf-out-1314.google.com with SMTP id 27so733394wfd.4
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HdmQI9tmG6VjjDZJYIz/wPxkOO4RmVdQiZu7bvjS0s8=;
        b=Q7+BtO5jOd0p26Y3dAff/eYxhMPVfHaCCgVSawQCgh/wD2yR7xEOR83AZD0D5QxWiD
         +pmHTBfQW++jqy0eHtmRsrWvG7V0VKhJBHZsPWuJfR+E34xgHLfqFb7JIWYEwCfBZdp7
         L2ukc0aFMNXZow0gKx31BvGZNKDUytmmEjr2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U8n/dUSZBRGqvGXGiyuQiqO408VZVY5cOdFEesBK3JV3N2FySVc+rlfQiGGba/xKI0
         7CXLEXNGIjpMuDI09SG25mYfbGZM7BbtHPl+LEG+1/Np8zbnG1VgrXZAeQnDxCES2TT0
         VHy0ImMIJBXK/qQaCNvQzvqae0G4SHtTyFlnQ=
Received: by 10.142.47.13 with SMTP id u13mr911870wfu.38.1220005339047;
        Fri, 29 Aug 2008 03:22:19 -0700 (PDT)
Received: by 10.142.177.15 with HTTP; Fri, 29 Aug 2008 03:22:19 -0700 (PDT)
In-Reply-To: <48B698D8.6080300@vodafone.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 2:23 PM, Paolo Ciarrocchi
<paolo.ciarrocchi@vodafone.com> wrote:
> From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
>
> Update to gitutorial as discussedin the git mailing list:
>
> http://marc.info/?t=121969390900002&r=1&w=2
>
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> ---
>  Documentation/gittutorial.txt |   29 ++++++++++++++++++++++++++++-
>  1 files changed, 28 insertions(+), 1 deletions(-)

Nice to see that you pick up the patch (with the right correction to
my poor changelog :-/).

BTW, I made the patch with msysgit on win, MUA is Thunderbird and
editor is Notepad++.
It might be a good idea to adjust CodingGuidelines since there might
be other win contributors.

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
