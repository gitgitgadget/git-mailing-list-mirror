From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary (long)
Date: Thu, 4 Oct 2007 16:59:26 +0200
Message-ID: <8fe92b430710040759r5777264aj5ecb09e0252fef9a@mail.gmail.com>
References: <8fe92b430710040212u332bb4e5yfa6c10b8236c6301@mail.gmail.com>
	 <CDD8E66B-44E0-4258-A3CC-4E48BC58FD2F@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Benoit SIGOURE" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSAq-0006C7-9f
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbXJDO72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 10:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbXJDO72
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:59:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:51793 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbXJDO72 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 10:59:28 -0400
Received: by nz-out-0506.google.com with SMTP id s18so180552nze
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p8g+3sWy33bq/P5guO2rRFsO3uBjX5vrGJ2LUvf4Dyg=;
        b=AcZ9fVCNQEp8gDWyY2A0Wfs77tw3K7AM7h7WB49HBXBoD9JoZRgopTnAr4R2Ik+tAG+LYsn014dA52+5Jt3uyN2Iht0GcP/BYCGL7f3Npoqe1Owyve2Ib75fWvMev65k9CBAGXYfi0f7zCCC5uzIyKylYta3GuqyW4FIzlNEHb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWbEbPFt7COSoUjgZu4HsPKstrctH2W5ODvvOVLHjzSPEG+R6RWWW93thduHND93/XQeGiiGYiIlpridT8U7d2/ENUd9gvZX7AaSFrnZoK3Nv5HLT7ba8/s+n7Jlw7+dm1sxTl9vLo0dsEpSa41oBMiekaSb/G4iv3VhB/yKt7w=
Received: by 10.114.123.1 with SMTP id v1mr1611445wac.1191509966720;
        Thu, 04 Oct 2007 07:59:26 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Thu, 4 Oct 2007 07:59:26 -0700 (PDT)
In-Reply-To: <CDD8E66B-44E0-4258-A3CC-4E48BC58FD2F@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59960>

On 10/4/07, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:

> Hi Jakub,
> nice work you've done there.  Well done!

Half done. But thanks.

By the way, I'd put final data from the survey as an attachement at
   http://git.or.cz/gitwiki/GitSurvey2007
Currently there is data I used to generate this summary, in CSV format.
I have used horrible Perl script to tabularize free-form questions, removing
comments etc., and to generate tables in this summary.

> On Oct 4, 2007, at 11:12 AM, Jakub Narebski wrote:
>

> > Note that Git is GPLv2, and it will probably stay that forever, so you
> > are _free_ to start a commercial support scheme for Git, but others
> > are free not to choose it. This question is to get to know if there is
> > sufficient demand for commercial Git support for it to be viable.
>
> Once again (AFAIR this was already raised during one of the previous
> summary) what's the link between GPLv2 and commercial support?  You
> seem to imply that because Git won't move to GPLv3, it's a good thing
> for potential paid support, or something.  I don't quite see how
> GPLvX comes into play with commercial support.  I'm not a license
> expert though.

The only link between GPL and commercial support is that GPL does not
prohibit commercial support (like noncommercial-free licenses for example),
and that having commercial support doesn't mean that license would change
to proprietary (it cannot).

-- 
Jakub Narebski
