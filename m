From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git issues/bugs - is there an alert process?
Date: Wed, 25 May 2011 06:59:51 -0700 (PDT)
Message-ID: <m37h9ezxst.fsf@localhost.localdomain>
References: <1306172653284-6395510.post@n2.nabble.com>
	<20110523212150.GF6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: funeeldy <Marlene_Cote@affirmednetworks.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 16:00:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEcz-0007s6-2y
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864Ab1EYN74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 09:59:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35576 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757001Ab1EYN7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 09:59:55 -0400
Received: by wya21 with SMTP id 21so5792441wya.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=tkkCtdfctt+NXWhEqAjgcoFv2e41SUmMgGuC4C34uNU=;
        b=mrgw2EFg2tPlXjiz0W9I/N+b4oX+c4NYy13yueddAaSK8JIwP3H3sQoGwFCxjF/FOJ
         wQKwOehCeFzRTCM3VHyE3/Z1LkNdynf0XBIS7ftmpa0PvtZoRIxgQzQ4jzakfgyJcQCG
         uQha/8mXp+GjETFk8NvFkQ+woiKyqwgyJy09Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=IxOGCq2wbF49eo7DF5ptBCf52h5smUVn11tw5Fvb7oTmSd2T8OJLgOa9nTNL3jBt2S
         fXuWfqt9P9UP6QQg55kEJIVYcH/LNg4tkEMbkT/RsJ4WDTly643nOiQ+uwBq8cy1pVLd
         bJPfwqRG8NyR50N2ZT2DTbesoPPd2l6J8DO8E=
Received: by 10.216.220.213 with SMTP id o63mr4477653wep.98.1306331992922;
        Wed, 25 May 2011 06:59:52 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id eo2sm391007wbb.43.2011.05.25.06.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 06:59:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4PDxLEG005939;
	Wed, 25 May 2011 15:59:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4PDwxwP005927;
	Wed, 25 May 2011 15:58:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110523212150.GF6281@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174392>

Jeff King <peff@peff.net> writes:

> On Mon, May 23, 2011 at 10:44:13AM -0700, funeeldy wrote:
> 
> > Is there any way for me to sign up to get alerts for serious bugs discovered
> > in a version of git?
> 
> You can read the release notes; minor versions are always bugfix
> releases, and important bugfixes are backported to them. If you read
> only the [ANNOUNCE] messages on git@vger, you will see new releases.
> 
> I seem to recall we have an announce-only mailing list, and somebody set
> up an rss feed, but I don't remember the details. Maybe somebody else
> does, or you can find it via google.

I don't know anything about announce-only mailing list, but 
GIT Mailing List RSS Feeds (based on filtering mails) is available
at http://gitrss.q42.co.uk/

-- 
Jakub Narebski
Poland
ShadeHawk on #git
