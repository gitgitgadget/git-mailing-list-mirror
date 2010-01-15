From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Remove some junk characters from COPYING
Date: Fri, 15 Jan 2010 14:28:12 -0800
Message-ID: <20100115222811.GB18878@gmail.com>
References: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuen-00042y-ER
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab0AOW21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758283Ab0AOW2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:28:25 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41327 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758269Ab0AOW2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:28:23 -0500
Received: by ewy19 with SMTP id 19so807364ewy.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0lnI4QJz3B25srdUthahbDNIELO2EwFIPQi9QyzMwMc=;
        b=CodFscL+WKdtbA8xP9eRjpoQiPtH7atK0Yd9KzHHNNPAurcEg4D7oeyFUtdZyAOVQh
         PYuce/I34H8/qdwYA98Uz18qzqEeeHQxvwfuZSZHmV1V0wuV64LOppImmS7LssLic8xU
         4WUk1G04ZO6YF4IPQlSqzG+Nsb6y74NvmlaKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YgYz7ljaSQdzdrf1k0UyUH5hejXDy7j0jGxpsVS96tA7kGs+FFce/kPD0XrnlsrOV6
         twZzS3ka9jk16EU5kDUN2VJLIJGYSqCco+eLv5tXLgamhK87DzT/W7xBa2/6Nl0njSS5
         rZ+lSaCxNTpyWreUkX+xDNRq9l8Oig3S+0cE4=
Received: by 10.213.97.4 with SMTP id j4mr290243ebn.18.1263594499228;
        Fri, 15 Jan 2010 14:28:19 -0800 (PST)
Received: from gmail.com (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id 28sm2386015eyg.20.2010.01.15.14.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:28:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f3271551001150022p342dccd3r5e93b5f5354d208c@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137141>

Hello,

On Fri, Jan 15, 2010 at 01:52:30PM +0530, Ramkumar Ramachandra wrote:
> I removed a few ^L characters from COPYING. Kindly find patch
> attached. Again, I'm sorry I couldn't include it inline- I'm behind a
> restrictive firewall, and Gmail mangles up patches.
> 
> -- Ram

I've had great success with the 'git send-email', msmtp, and
gmail combination.

http://git.or.cz/gitwiki/GitTips#Usingmsmtptosendyourpatches

I highly recommend using that setup.


I'm sure there are other ways, but that's the one that works for
me.  I also use mutt to read gmail; also highly recommended :)


Have a nice day,

-- 
		David
