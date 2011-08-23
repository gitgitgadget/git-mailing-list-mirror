From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Tue, 23 Aug 2011 23:32:07 +0100
Message-ID: <CAOpHH-X2OP983mX_oMmsMg2-8UAKxK_2J0Fz_a_pDN7HhOn7Pg@mail.gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
 <20110819115310.GC15639@padd.com> <CAOpHH-WeLWyEZaktYRzVN+dfgqu3==o4bgrfzpvS-QUCQboPgg@mail.gmail.com>
 <20110820191407.GD7135@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:32:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvzWV-0003CI-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab1HWWcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 18:32:39 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:61510 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1HWWci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 18:32:38 -0400
Received: by iye16 with SMTP id 16so874232iye.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lF+qkuI+yDI8mwZVwHU/u88RT5cVdVZvA1pqHmbVKb0=;
        b=oxy/SsKihyCwOA1m4otZBF1WnbbIc5LUIaKS4lHp0PNKEOlR8PFUIG9Cq0RQeXdp48
         oeXWCpxZmKj5p6nwo4SIsv0NPXYF17PX7SBKFap2AZBC7GYjLah+b/Lp1iLawpu6bf34
         hxP37TwCbTkoSg5qQXWE6OoovZoi3M8PWldrI=
Received: by 10.231.55.76 with SMTP id t12mr8699944ibg.28.1314138757272; Tue,
 23 Aug 2011 15:32:37 -0700 (PDT)
Received: by 10.231.10.140 with HTTP; Tue, 23 Aug 2011 15:32:07 -0700 (PDT)
In-Reply-To: <20110820191407.GD7135@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179977>

On Sat, Aug 20, 2011 at 8:14 PM, Pete Wyckoff <pw@padd.com> wrote:
> In particular, a clear case of how to set up the branches for
> the branchList example would be good. =A0My minimal test did not
> exactly work.

Could you send me the list of steps you followed that resulted in git-p=
4
failing to detect the branches?

Thanks,
--=20
Vitor Antunes
