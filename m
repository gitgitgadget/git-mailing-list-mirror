From: Yang Zhang <yanghatespam@gmail.com>
Subject: =?windows-1252?Q?Re=3A_How_to_fix_=93Your_branch_and_=27origin=2Fmaster=27_ha?=
	=?windows-1252?Q?ve_diverged=94_after_editing_a_commit_that_came_before_a_pul?=
	=?windows-1252?Q?l=3F?=
Date: Sat, 20 Nov 2010 12:12:27 -0800
Message-ID: <AANLkTinFhFjxLNnu-CZiAnGpcFG8Hu-bL1N5ME89ZTku@mail.gmail.com>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com> <20101120043628.GB20725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 20 21:13:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJtoL-0006OB-CN
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 21:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab0KTUMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 15:12:51 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55553 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab0KTUMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 15:12:50 -0500
Received: by gxk23 with SMTP id 23so3381792gxk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jJJQEJ0fItcPTFBVjjTUKtVJOCCsdBeGhqO8Xe2OxA0=;
        b=yGTN17Fh03noyPmY6NPIHOTeMsy8uOIbeiZlFys5orAwBBNN0mubVaIaNLOUgL9/k3
         WOY6KtR6w0DhNw++ZBB6cBeJqNdNFTHGsNuD0eQyyA9SNFXpWpOBnbJkUmZ9YxxeB694
         in33mZVCYnXEczOGkO5ZV9jTpcLyFZXwxMfpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sEddwtw/qbet9k1t/EM5+i08+z/5GOmFIJKnQsZICxDWB4hPIQwwTx//8XRUlklkhu
         r/SrPJQGaVPdVZhX8aEKHX8Ln5OtSnn+PYxW6JE6ITMgdjxsuUDDpdTy4l7NyIzV/2O/
         n/teR/2ScdUZyEIEzGXes1JAssXrVhyuGqA1I=
Received: by 10.90.4.1 with SMTP id 1mr4734622agd.124.1290283968046; Sat, 20
 Nov 2010 12:12:48 -0800 (PST)
Received: by 10.90.222.2 with HTTP; Sat, 20 Nov 2010 12:12:27 -0800 (PST)
In-Reply-To: <20101120043628.GB20725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161841>

On Fri, Nov 19, 2010 at 8:36 PM, Jeff King <peff@peff.net> wrote:
> Whew, that turned out long. Hopefully it helps, and did not just confuse
> you more. :)

That was a *fantastic* explanation. Thank you!

-- 
Yang Zhang
http://yz.mit.edu/
