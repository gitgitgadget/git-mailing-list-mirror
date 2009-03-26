From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Documentation: minor consistency fixes in
	git-difftool.txt.
Date: Wed, 25 Mar 2009 21:17:41 -0700
Message-ID: <20090326041740.GA21285@gmail.com>
References: <1237961655-29147-1-git-send-email-davvid@gmail.com> <7vocvq842a.fsf@gitster.siamese.dyndns.org> <49CA05B2.7020207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmh37-0005R3-Cu
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZCZERI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbZCZERG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:17:06 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:11036 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbZCZERE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:17:04 -0400
Received: by rv-out-0506.google.com with SMTP id f9so406955rvb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ygqy41sJP3Ac7R2wDSu/9oczWKOzx1XMggcU7dFnvSM=;
        b=T2PCaeMI3GXn8bXEOQbbLClo+N5AlMCcurhjOMkyf4HCZoUiyAB63YmqMg2hwEslNO
         Zn7ySTUH56ZSUZugNXCvrC/7bDzBWftQ8VKxaz/DxurXRgYGA2JbsJZTpNNeuc9A9SF3
         109LPX9tgUciusC+c2f9YIYwR8lnOJUmaNkfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MIUPVi9M5oc1h75RXgSSoG9dMbW03EKKH/3vfzxAmVfkPusBs2N2NsF7Uy8IQlYua+
         Mp6R3C9/8fL/o/z1hdg83e4Vq/4T5UIZqB5KxI4J/LmwmiUc4KzAOZ1cg74+yjaphV7h
         N4XprJKB8xjSSKdt+aewahDMwb0oiWMKq68rQ=
Received: by 10.115.48.12 with SMTP id a12mr268410wak.167.1238041022469;
        Wed, 25 Mar 2009 21:17:02 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n9sm8693008wag.46.2009.03.25.21.17.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 21:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49CA05B2.7020207@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114722>

On  0, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 25.03.2009 08:17:
> > David Aguilar <davvid@gmail.com> writes:
> > 
> >> --- a/Documentation/git-difftool.txt
> >> +++ b/Documentation/git-difftool.txt
> >> @@ -12,7 +12,7 @@ SYNOPSIS
> >>  DESCRIPTION
> >>  -----------
> >>  'git-difftool' is a git command that allows you to compare and edit files
> >> -between revisions using common diff tools.  'git difftool' is a frontend
> >> +between revisions using common diff tools.  'git-difftool' is a frontend
> > 
> > I thought that the recent trend is to spell these as 'git difftool' (two
> > separate words), although I didn't follow the discussion on quoting styles
> > closely, so I do not know which of sq, dq or backtick is preferred.
> > 
> > Can somebody help me out here?
> > 
> 
> I'd say it's backticks for commands/code, but I think discussion about a
> style guide is still on.
> 
> Michael


Cool, I'll keep my eye on it.

I was merely going for consistency with the existing
documentation (such as git-mergetool.txt).
Once a consensus is reached I'll go ahead and follow suite.

Thanks,

-- 

	David
