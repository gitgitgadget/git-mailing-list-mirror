From: Ron Eggler <ron.eggler@gmail.com>
Subject: Re: found some code...
Date: Tue, 17 Jan 2012 18:49:42 -0800
Message-ID: <2918969.0SyTOLELv0@reg-desktop>
References: <loom.20120118T015734-175@post.gmane.org> <CAH5451k4bMJtMLsaFi6g_uRGTL0OdQ5Z1Pss3xuMdWYs+6VcLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 03:50:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnLbA-0007Xv-Er
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 03:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab2ARCt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 21:49:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48714 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab2ARCt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 21:49:59 -0500
Received: by ggdk6 with SMTP id k6so3579600ggd.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 18:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=5AEoVwz8Qpy4H8HsblBH7355IZeu599RoQc37dpBbrQ=;
        b=XLsHADsjt1WfRmeDdoaB4GTCVqWCWd7OLYRPu7TXHXdleNR0yGxhB8RA3pq1bSIYrL
         SKR+0fFSUNo0qeJBQUhH70XzxDtxN5PnYBj6DeGUguL2qMHYrOm+PWcmvYw81TBmEblt
         nNU7V+79EohzbiVxuteyC1bgkVqodzGD87gSE=
Received: by 10.236.139.199 with SMTP id c47mr28036014yhj.113.1326854998761;
        Tue, 17 Jan 2012 18:49:58 -0800 (PST)
Received: from reg-desktop.localnet (S0106b0487afe2a57.vc.shawcable.net. [24.82.166.99])
        by mx.google.com with ESMTPS id r1sm40127712yhh.14.2012.01.17.18.49.56
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jan 2012 18:49:57 -0800 (PST)
User-Agent: KMail/4.7.3 (Linux/3.0.0-15-generic; KDE/4.7.4; i686; ; )
In-Reply-To: <CAH5451k4bMJtMLsaFi6g_uRGTL0OdQ5Z1Pss3xuMdWYs+6VcLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188739>

On January 18, 2012 12:16:49 PM Andrew Ardill wrote:
> Hi Ron,
> 
> On 18 January 2012 12:02, Ron Eggler <ron.eggler@gmail.com> wrote:
> > Hi There,
> > 
> > Some mishap had happened with my project:
> > I found a piece of code that is the most recent one that never got
> > commited to the repository. It is dated December 5th and it definitely
> > is the most recent piece of code.
> > Now in the mean time I switched computers so I had to reinstall git and
> > get create new local folders. Now this directory with the most recent
> > code, shows every file as unversioned which should not be true.
> > Only a couple, maybe 3 files had changed with that last change. Now when
> > I commit this now, is that gonna mess up my old repo or can I safely
> > gio ahead and commit that most recent code (even tho it might commit
> > the whole folder) - it almost seems like it forgot which files
> > were in the repo vs. which files were in my local folder...
> > 
> > Thanks for hints and suggestions how I get myself cleanly out of this
> > mess! Thanks,
> > Ron
> 
> Out of interest, how did you transfer the existing code onto the new
> machine? In particular, did you clone the existing repository using
> git clone, or using some other method (such as zipping/emailing)? If
> it was not via clone, did you copy the .git subdirectory, or did you
> recreate it?

I copied the whole directory (incl .git) onto a thumb drive.
 
> Is the old repository (on the old computer) still available?

No, unfortunately not
-- 
Ron
