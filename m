From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git-svn: --no-metadata related bug
Date: Wed, 6 Apr 2011 23:42:39 +0530
Message-ID: <20110406181234.GB667@kytes>
References: <20110405190722.GB25644@kytes>
 <4D9C64EB.5060703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:13:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7XEi-0007kc-55
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab1DFSNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:13:42 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49854 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1DFSNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:13:42 -0400
Received: by gxk21 with SMTP id 21so677665gxk.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nS5+hp025WRDS5wckPRzTKlf7glfFWqomTXIMG+aJLU=;
        b=fyBI/DuRz15T6A1a+o8qKkBd07MoOPT4zJgd6fwd8VpyGryxHeNJsLeKnxcDoVDFdF
         knu/SA959JcdP3aAZ5aJRrdoBeP2AgFoH2NUCYe5P0yjEnR5xpFdZU8rCVM5frmQ8jY1
         yVc5dacyUgFVNNcu0wM0EK6kNO8zf0h1Dthek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KeyAGiAGFQvfeZPTLmfyB+cdZL08r65weG1n/Om8meole9R0dvllNOm4FYsq981zum
         qE9Xsi+FKG+6JWvndEHVUTnCaYb/YJtrPZyCCSz4OHpOP6YZhoftctW8cTWMjsz1uRbQ
         whzHIkU03rCatf1IAfAnU6RhyqZ7kFzzCuy7w=
Received: by 10.90.8.10 with SMTP id 10mr2243565agh.102.1302113621265;
        Wed, 06 Apr 2011 11:13:41 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d14sm917692ana.0.2011.04.06.11.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:13:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9C64EB.5060703@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170998>

Hi Michael,

Michael J Gruber writes:
> Ramkumar Ramachandra venit, vidit, dixit 05.04.2011 21:07:
> > git svn clone --no-metadata -T trunk http://dxirc.googlecode.com/svn/
> 
> Works fine for me, using:
> 
> git svn --version
> git-svn version 1.7.5.rc0.365.g23929a (svn 1.6.16)
> 
> What are the affected versions?

I'm sorry, but I have no additional information about the bug.  I
simply reported it on someone else's behalf, hoping that someone on
the list would be able to reproduce it and supply a fix (see IRC
conversation and explanation for not being able to test it myself).

-- Ram
