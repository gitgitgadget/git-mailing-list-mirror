From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: Re: [PATCH] Fix _XOPEN_SOURCE problem on DragonFly
Date: Fri, 2 Apr 2010 17:02:04 +0900
Message-ID: <20100402080204.GB53099@les.ath.cx>
References: <20100304020522.GA76036@les.ath.cx>
 <20100401073742.GA52362@les.ath.cx>
 <h2ibe6fef0d1004010737n813b81dds438563ea81bf694f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 10:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbpW-0002XJ-AT
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 10:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab0DBICI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 04:02:08 -0400
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:4270 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568Ab0DBICG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 04:02:06 -0400
Received: by les.ath.cx (Postfix, from userid 1000)
	id 9EF3C86654; Fri,  2 Apr 2010 17:02:04 +0900 (JST)
Content-Disposition: inline
In-Reply-To: <h2ibe6fef0d1004010737n813b81dds438563ea81bf694f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143794>

On Thu, Apr 01, 2010 at 10:37:48PM +0800, Tay Ray Chuan wrote:
> On Thu, Apr 1, 2010 at 3:37 PM, YONETANI Tomokazu <qhwt+git@les.ath.cx> wrote:
> > Hello.
> > Is there anything else I need to do to get this in?
> 
> you should read Documentation/SubmittingPatches:
> 
>   http://github.com/git/git/blob/HEAD/Documentation/SubmittingPatches
> 
> Briefly,
> 
> 1. Generate your patch with git-format-patch.
> 
> 2. s-o-b.

I *thought* having read something like that before :)  Thanks for the hint.
I just re-submitted the patch to meet the requirement.  Hopefully the new
one won't annoy anyone.

Best regards,
YONETANI Tomokazu.
