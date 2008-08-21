From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git-aware Issue Tracking?
Date: Thu, 21 Aug 2008 20:47:12 +1200
Message-ID: <46a038f90808210147pa3087a5k5bd5804e36bdcc13@mail.gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
	 <20080819175931.GH20947@spearce.org>
	 <200808192121.30372.robin.rosenberg.lists@dewire.com>
	 <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
	 <20080820152305.GJ10544@machine.or.cz>
	 <20080820164409.GH3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, andy@catalyst.net.nz
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5q6-0002Ts-F2
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbYHUIrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbYHUIrO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:47:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:34168 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYHUIrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:47:13 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1060707wfd.4
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qgeAgEbgh16TtDl26ZZti182dDm5/osbY83k3pjZX3M=;
        b=lZbd7oAPQ+B6QOUVlUsjg36UUjgMMWXb5Ht/zhI/qV6uo0QzCmGChOanlxcEuoBl6j
         6kEUfq6RQr6EmD/c+fvTVDI89TD9eqxam24TKkO3Wf47QIozQuKmmgcZ5jLtEiSTL03+
         sEIRx3v5tswK/HjNEWqrwRnAwyWDsmWEn7sW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=C5+jImWdHcarKtT5ADy9Fy4ufxEu9EhsBJXDduWSUEwq2liRHKmEync7CyrpNS/Qu6
         gOYbyDNZzoJykeu75gdIZ0TRz12euREaYYAUVPEKwhxZpiiMholYyeJBYazPibcCyQZs
         58GPZKVhc+ipLuP90nj14pQ26M1XjGVGd6NdU=
Received: by 10.142.139.19 with SMTP id m19mr402160wfd.25.1219308432922;
        Thu, 21 Aug 2008 01:47:12 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Thu, 21 Aug 2008 01:47:12 -0700 (PDT)
In-Reply-To: <20080820164409.GH3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93124>

On Thu, Aug 21, 2008 at 4:44 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Cil is interesting.  I'm concerned about keeping the state in tree
> with the repository though in a distributed development team.

I'm not a Cil user, but I work with the original dev, and a few people
around here use it. Perhaps Andy can help answer questions about it...

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
