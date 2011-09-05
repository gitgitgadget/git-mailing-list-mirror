From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH 10/10] want_color: automatically fallback to color.ui
Date: Mon, 5 Sep 2011 13:31:58 +0200
Message-ID: <20110905113158.GA1842@sherwood.local>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050533.GJ2889@sigill.intra.peff.net>
 <alpine.DEB.2.00.1109032212310.12564@debian>
 <20110904125312.GA21724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 13:32:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0XPR-0004wk-V0
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 13:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1IELcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 07:32:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61364 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab1IELcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 07:32:07 -0400
Received: by ewy4 with SMTP id 4so2181310ewy.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gdEnl3TtN6G52Xt2sIrKEBYpWrFW7FYn9WkIbRdT4Rs=;
        b=x676VIPUjxwdFJbFyXdGGtN7CalzxS5RfamqkpOgmEm6rao1g3i5/0AGU1Nwg8zFxg
         5TvQU8GSo4PqHqhbcKrFxzyepFNB9ZpwL9epNByVgdq9OadxiY+S7cdXwk7YhrcvFOS/
         0907zOnV+618T06CwRiocz+0uuIy+vNMLED+E=
Received: by 10.213.26.5 with SMTP id b5mr346480ebc.13.1315222325999;
        Mon, 05 Sep 2011 04:32:05 -0700 (PDT)
Received: from sherwood.local ([89.204.153.238])
        by mx.google.com with ESMTPS id w19sm9491226eeh.6.2011.09.05.04.32.03
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Sep 2011 04:32:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110904125312.GA21724@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180736>

@ Jeff King <peff@peff.net> wrote (2011-09-04 14:53+0200):
> Sorry, this is a regression.

I should have found that.
I apologize.

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations
