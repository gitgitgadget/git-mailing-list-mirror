From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: git-mail-commits (Re: What's a good setup for submitting patches
	to the list properly?)
Date: Sat, 22 Aug 2009 22:56:56 +0200
Message-ID: <20090822205656.GA3526@vidovic>
References: <alpine.DEB.2.00.0908191849220.2012@GWPortableVCS> <alpine.DEB.2.00.0908220953460.2012@GWPortableVCS> <200908222220.35354.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 23:00:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mexh5-0003vw-Cw
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 23:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbZHVU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 16:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932962AbZHVU5E
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 16:57:04 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59073 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932901AbZHVU5B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 16:57:01 -0400
Received: by ewy3 with SMTP id 3so1458129ewy.18
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ZWkFRwdmTYRV4VY022/GYo+VmHP4r6lhE3ZuSoit1kQ=;
        b=KOouzUErNAHXlNGNxB61QgLfNwjW3NA8X/PnZ5GzusCQbZm4TCLfThTb9qR/ckOfvP
         5DtMQiTygeAiGNoa+GSVLrejGFDfYuomyiGOZkiQZCStlbFrfo4J7U2Sr4QJy6fnA4n7
         kAfMCQtskOOR2VEHidYht7Iw+LkxFfvtR0iPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tXqxqPR1n8g2PiEDnPb3sDcxDdOj3YDfmZQwgMBY7TQjaDW4piWD0hjWGr7eQGmrYY
         xHXwpFIOWwQiVCKa19S3Vvp38zBcwiWMUl6jV/ihRnGMXrOlHprjdZoHX+Fag16nV0zw
         ApIOPSPV8qzIi13st4QKTtToOGecsx2x1BZPo=
Received: by 10.211.195.3 with SMTP id x3mr3189191ebp.14.1250974621954;
        Sat, 22 Aug 2009 13:57:01 -0700 (PDT)
Received: from @ (88-122-112-47.rev.libertysurf.net [88.122.112.47])
        by mx.google.com with ESMTPS id 28sm3586456eye.40.2009.08.22.13.56.58
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 22 Aug 2009 13:57:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200908222220.35354.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126821>

The 22/08/09, Christian Couder wrote:

> There is "git send-email" that is bundled with git. But I use 
> git-mail-commits from Julian Philips. I am very happy with it. Thanks 
> Julian!

Isn't there any public repo for it?

-- 
Nicolas Sebrecht
