From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Sat, 10 Dec 2011 04:00:33 +0530
Message-ID: <CALkWK0=vL8MakgaKNkDWLGHp1d_48GP5KKBGSSHkYG3ygB_rQg@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com> <20111207070223.GC11737@elie.hsd1.il.comcast.net>
 <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com>
 <20111209193527.GD20913@elie.hsd1.il.comcast.net> <CALkWK0ki1r5AqYb8qyGHUNupTAhCa2TKwVgkrCpLr+zo_pCy9g@mail.gmail.com>
 <20111209195042.GG20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 23:31:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ8y4-0006T5-Fu
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 23:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab1LIWaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 17:30:55 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:36488 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1LIWaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 17:30:55 -0500
Received: by qcqz2 with SMTP id z2so2548027qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 14:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FE5P8zER13P3Df0WfmiTiCP3p91Uw45QOOe2blt0f6o=;
        b=RBfPkJfonpX/loVbAOIBxw3yQ67R3X0aXIAM/3XMCiNBcq/vtZz5w5M3QWAYoMw6HG
         14sYd7DQWWyer0VkPjABGGdMNvbsrFiqzzeKchU5CgZIZnLm/FevExzTRAxptj6mTm5Y
         9FPf17Qg0k6uJ9P5SXGfhAGUc9LDReX1Rl9vQ=
Received: by 10.229.227.84 with SMTP id iz20mr2288733qcb.164.1323469854344;
 Fri, 09 Dec 2011 14:30:54 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 14:30:33 -0800 (PST)
In-Reply-To: <20111209195042.GG20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186699>

Hey,

Jonathan Nieder wrote:
> You can make git misbehave before applying the commit.

Right, it's all in the discussion surrounding $gmane/184031.  I
couldn't recall because it was so long ago :\

Thanks.

-- Ram
