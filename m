From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 15
Date: Tue, 10 Aug 2010 18:26:31 +0530
Message-ID: <20100810125628.GC3921@kytes>
References: <20100808105232.GB2309@kytes>
 <AANLkTinSge3dygR93qLAC3+28QTU0O3mjYPKQV8+v7Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 14:58:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OioPg-0008VK-Gh
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 14:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757142Ab0HJM6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 08:58:37 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35182 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab0HJM6f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 08:58:35 -0400
Received: by pwj7 with SMTP id 7so1719248pwj.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uRDVnVoBCTZ9MBBMQH+CDqrh75lScBq7GEP3R4LSInk=;
        b=SS/3+hjMkWpFM8lPESIWmd9w6U81FLPCRcJSDRDF0owiq3gPd971vLVoWp1lc6aQq9
         88rnWRCDfvw12yTgEleDMqqIE3TtDs7L41Nd/x+Gy1hAQ7R6l+ZXfnvunu8RphaliV6j
         OfHb6pIQz++fQdfIqe3VkRDcdmHYMW4iIpC2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u1tOdalu6usfDoTSGxAdhe0xukFsmepPy/z6vhTnKD7aTTaK6PBnuNiAVXREkvnZMp
         C5beWKC+P/bNm1SJYpHnQlSn6AZlXgbVaaJrufMaqR967xhWZ108mWL+3nOK4L/Obffz
         WxsVUWADb8QmcHVWMVJOneGPNLMOGIT1QMNCc=
Received: by 10.142.150.28 with SMTP id x28mr14629396wfd.203.1281445115286;
        Tue, 10 Aug 2010 05:58:35 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm7765470wfa.22.2010.08.10.05.58.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 05:58:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinSge3dygR93qLAC3+28QTU0O3mjYPKQV8+v7Cw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153101>

Hi,

Sverre Rabbelier writes:
> Heya,
> 
> On Sun, Aug 8, 2010 at 05:52, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> > This task is VERY non-trivial, and essentially
> > involves making fast-import provide feedback and making
> > svn-dump-fast-export aware of the Git object store.
> 
> Could you send a ping to the relevant threads of the patches to fast-import?

If you still want this, I can dig up the relevant threads for you. I'm
working with those patches applied anyway.

-- Ram
