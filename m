From: dhruva <dhruvakm@gmail.com>
Subject: Re: [msysGit] Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 19:00:55 +0530
Message-ID: <e3f230850812010530h49fc360eu309876a4ebbb0f9d@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
	 <4933A922.7080300@viscovery.net>
	 <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com>
	 <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com>
	 <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com>
	 <4933D10E.6020706@viscovery.net>
	 <e3f230850812010402n69cced19s3f36a5bcb84977c6@mail.gmail.com>
	 <e3f230850812010507y54dff6dh3757bf97c78c0329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 14:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L78sp-0001T2-Jh
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 14:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYLANa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 08:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYLANa5
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 08:30:57 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:42012 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYLANa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 08:30:56 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2666080wfd.4
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 05:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5i1NR3JeI4wmWwDHzqgIeRFu6Z3KGyOvwTWIBKZcgUY=;
        b=FymOlvQFbQ+gWs3coIj2u9sxungRNYLyv9c1ztjlmxoeAVJuUMmEyrUNl5sypd9LAg
         itziFIF0m4O2XZEx+/HBjQDbA4XucGXplCy52Pm33fStz/qjb5YsQsQlGuE2nQGwjfsH
         r28UrxdZdH4jAayVbZLUpU++mlyaCjUm3VLTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tjS9UiJip6aZP0QNKSZiSeeaS8ZCqVe60pPDEYBgu86viQpU3N9AvXBf0EvBhlNNdo
         xk9ncFDirfusJGZUjuZYVbs6IPYpjkqB3D0h6ig12YOAuRxTMvJRoWwi37dt3oDNCvti
         k7w1qmpcNbxmCZsymxqZnKddsPCpYYZRgna6Q=
Received: by 10.142.83.4 with SMTP id g4mr4511979wfb.156.1228138255511;
        Mon, 01 Dec 2008 05:30:55 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 05:30:55 -0800 (PST)
In-Reply-To: <e3f230850812010507y54dff6dh3757bf97c78c0329@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102031>

Hi,
 Sorry for all the noise, I pushed the files. I had to use:
$ git push mob@repo.or.cz:/srv/git/msysgit.git

-dhruva

-- 
Contents reflect my personal views only!
