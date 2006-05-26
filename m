From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Fri, 26 May 2006 15:51:59 +0200
Message-ID: <f3d7535d0605260651o2adc239cg4536c554200fcb87@mail.gmail.com>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
	 <20060526011153.GA27720@spearce.org>
	 <Pine.LNX.4.63.0605261534270.27610@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 26 15:52:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjck6-00010c-Md
	for gcvg-git@gmane.org; Fri, 26 May 2006 15:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWEZNwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 09:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWEZNwe
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 09:52:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:19035 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750746AbWEZNwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 09:52:33 -0400
Received: by nz-out-0102.google.com with SMTP id o1so75672nzf
        for <git@vger.kernel.org>; Fri, 26 May 2006 06:52:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QzC8i3r4oKoIvOiF+i0bO4sIv3DcW2zaadtfLFI7NyGvsJRUqJrOel76HpcLqa0iODTcwEI+/465+ZLsOihMcqDj1o8QM8Fp2XcZ7gcGNYAkNElESyldxV3AW32Um+QHuAV8NsJHPnWNqYWYrRZW1KnWqMfIimQaOEEoGDuOiLA=
Received: by 10.65.133.13 with SMTP id k13mr346328qbn;
        Fri, 26 May 2006 06:51:59 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Fri, 26 May 2006 06:51:59 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0605261534270.27610@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20812>

Hi Johannes,

2006/5/26, Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> > I've been seeing the same failed test case for a long time now on
> > my own Mac OS X system.
>
> ... which is sort of funny, because I don't see it on my system. Running
> an iBook G3 with Mac OS X 10.2.8. "make test" runs through, and no, AFAICT
> I do not have any local modifications which could be responsible for that.

Hm, well thats strange, although I guess Shawn runs Tiger - as I do.
(10.4.6 currently).

I tried already with DarwinPorts perl and OSX sytem perl. Both did not
work as expected.

bye

Stefan
-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.
