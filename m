From: "Rajkumar S" <rajkumars@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 17:48:01 +0530
Message-ID: <64de5c8b0609150518x279e786tc11b85171dcbe899@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
	 <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
	 <64de5c8b0609150432o5d6835a8pb578082746576864@mail.gmail.com>
	 <eee3i5$ib6$1@sea.gmane.org>
	 <64de5c8b0609150459i2e678a02r86bb678ea420054f@mail.gmail.com>
	 <eee551$mtc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 15 14:18:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOCe2-00044N-MJ
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 14:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWIOMSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 08:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWIOMSF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 08:18:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:17833 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751338AbWIOMSC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 08:18:02 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1351936nzf
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 05:18:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rH3ji7NY55FZ2vc3/5ZDcUzimGCiXI/s+a5485+xGekYrwPz7ocrCSDyAaBu0+OGp0Vl9Y4uPOR83LoepMSpmfLd3HUYBUot7lGpncFmzONVEGLlz6PFDvRICF9163kB0Ip//vjOnzK9ySJZk4bihArFh8jt2utRnQUfGxtVCGQ=
Received: by 10.65.73.16 with SMTP id a16mr12075051qbl;
        Fri, 15 Sep 2006 05:18:01 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Fri, 15 Sep 2006 05:18:01 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <eee551$mtc$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27083>

On 9/15/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Besides in remotes file you have only specified which remote branch
> is tracked by which local branch. Additionally all but first are marked
> as not-for-merge. There is no place for default branch to merge with.
>
> There was some discussion about moving remotes information into config
> file, including marking tracking branches as read-only, marking default
> branch to merge (or marking branch as for-merge/not-for-merge), marking
> branch as of not fast-forwarding type (like 'pu' in git.git) on the
> _server_ side etc. But it petered out, unfortunately.

Thanks a lot for your comments, I have just put the RELENG_1 line in
the remotes and have RELENG_1 always checked out.

raj
