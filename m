From: Jakub Narebski <jnareb@gmail.com>
Subject: Best example of GSoC student participation (was: Re: native-git-svn: A Summer of Code 2010 proposal)
Date: Sun, 21 Mar 2010 09:43:38 -0700 (PDT)
Message-ID: <m3ljdlk4nw.fsf_-_@localhost.localdomain>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>
	<32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
	<fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
	<32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
	<alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
	<f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
	<20100320210406.GA29899@progeny.tock>
	<alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>
	<20100321110807.GA24016@progeny.tock>
	<alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 21 17:43:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOFg-0001nD-Ft
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 17:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab0CUQnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 12:43:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:27306 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab0CUQnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 12:43:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so202072fgg.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=VL2iHbp5XIzm1hA4nXeKTvYZgHUpBPxi3uyawOpjHXY=;
        b=lSdlYAMsBcG7khM4qf197o1UYKrfpeIVBA08DU8khKWcaqGnevvi8s5xsid3UuBk/M
         I4AiyPaUSl9MFyiJxgWYRvB2qrdS6m7SVL6eNEJY5wrag5flGhosJ7PdLogaVoMjFSSF
         QltUVmMCWo5M6NgCP1zAIajXYH5pes79DemYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iRLdoZ4bXL/PvlrzU00jHNumbScNWCQxX477zRl1/cZzwDBrFXxr/+TdxGlzS7qtAx
         A5xbbwS3sArI0j7ZJR7KiythFeKIVeFsVemIaAI1/089VW//6ITZYHyzpPS/lHfRn5Xv
         tJI9E5Pf80jqXTTJp4xeqF4dhjCleh8fwnutM=
Received: by 10.87.15.19 with SMTP id s19mr3613224fgi.0.1269189820519;
        Sun, 21 Mar 2010 09:43:40 -0700 (PDT)
Received: from localhost.localdomain (abwo10.neoplus.adsl.tpnet.pl [83.8.238.10])
        by mx.google.com with ESMTPS id 14sm2840536fxm.9.2010.03.21.09.43.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 09:43:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2LGgnB8022569;
	Sun, 21 Mar 2010 17:42:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2LGgC7U022551;
	Sun, 21 Mar 2010 17:42:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142833>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The mistakes in the sequencer project were more than this. Not only was 
> the development of the branch almost invisible, when it was done, it was 
> basically with a comment "here it is, take it or leave it", and good 
> suggestions as to improve the code went unheeded.
> 
> That's why I suggested frequent progress reports on the mailing list. 
> Of course, these reports should only be commented upon by people who are 
> fully informed about the project, they should not be invitations to 
> everybody and her dog to distract the student by putting in unreasonable 
> or uninformed wishes.

By the way, which of the former GSoC students (and for which project)
can serve as the best example of good interaction with the git
community and with GSoC mentors?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
