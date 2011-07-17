From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/17] revert: Introduce --reset to remove sequencer state
Date: Sun, 17 Jul 2011 14:25:49 -0500
Message-ID: <20110717192548.GI27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-17-git-send-email-artagnon@gmail.com>
 <20110712203011.GF14909@elie>
 <CALkWK0mfNNfpyyMDFgVD_gnEC7OxHuPAPc+27-PepYNKPOR8-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiWyb-00021Y-DA
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191Ab1GQTZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 15:25:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51740 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab1GQTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:25:55 -0400
Received: by iwn6 with SMTP id 6so2539107iwn.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3pemKSFPX4br8rePtPVd3oYf/8DgfoPrzVpSqi9/kZ8=;
        b=LNDY92Z1zHItDBsxwM1Dyn/T4jo1RokHMuqVeKiu9GLgCvl9YU3I+ZZvVsfMXInfza
         ACxhM/VpzUKfrC+S2FlRGhoTp+hseptROzib6S5HvYvBPz2dzjAxwkgHQfD1O/YjIbd6
         GfoaDL90pw8tdAPp4GaFrOrv9BIdb2kg3+yQY=
Received: by 10.42.151.136 with SMTP id e8mr6352355icw.324.1310930754875;
        Sun, 17 Jul 2011 12:25:54 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id v3sm2383559ibh.50.2011.07.17.12.25.52
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 12:25:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mfNNfpyyMDFgVD_gnEC7OxHuPAPc+27-PepYNKPOR8-w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177314>

Ramkumar Ramachandra wrote:

> New commit message.

Much clearer.  Thank you.
