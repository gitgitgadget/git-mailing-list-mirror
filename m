From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Getting Ensimag students to work on Git for a few weeks
Date: Tue, 27 Oct 2009 15:44:05 +0100
Message-ID: <20091027144405.GA12464@localhost>
References: <vpqocntxhzv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 27 15:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2nHZ-00009R-P1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbZJ0OoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbZJ0OoL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:44:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:11942 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbZJ0OoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:44:10 -0400
Received: by fg-out-1718.google.com with SMTP id 16so288914fgg.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/jPDamQts/fESysT8P37ID/cuSCqIrt3PKtK8/HgFgg=;
        b=TUvF8QzD7jdlSdjLMBZi9SzLZETyMBX4KndEKRcStn52IeBlWH8twJWVkmLt4d6QDS
         X2B0NXXiC2UTpOSauexR2JGl2GMq5Phn+w4pH5Tdp32HNaWFJ8SnJq3xeYbIuBF2mBtE
         0L9n5x+EUQgDWOMuwsyrAgi/E22PlZJNEpJas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=f+CDiMitnErhgQEIyrU7QwfwvjGiQFKBo94/QEciyr4CeEztV/Q8O8yFwt879j+xmU
         1VcA53yp5wrYd0PiX8dM5aFsNXgFG+aKrL3A/9NeruJOyt7rdxhSgXT6WK7bdLa+DR2r
         CUXKxBF+uIeCrTdUcx3DPH3LO1o+OjUEKOcWw=
Received: by 10.86.10.36 with SMTP id 36mr2057030fgj.61.1256654654178;
        Tue, 27 Oct 2009 07:44:14 -0700 (PDT)
Received: from darc.lan (p549A6E37.dip.t-dialin.net [84.154.110.55])
        by mx.google.com with ESMTPS id d6sm9296474fga.5.2009.10.27.07.44.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 07:44:12 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N2nHJ-00054t-5k; Tue, 27 Oct 2009 15:44:05 +0100
Content-Disposition: inline
In-Reply-To: <vpqocntxhzv.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131343>

On Tue, Oct 27, 2009 at 11:12:52AM +0100, Matthieu Moy wrote:

> The students work full-time for about 3 weeks (May 20th to June 16th),
> and are grouped by teams of 2 to 4 students. Given my bandwidth, I
> plan to propose only one group of 4 students this year, but we may
> scale up later, who knows.

That's not much time to get familiar with a complex project like git. So you
will have to do something extremely simple, which probably means that it
won't be anything exciting. If it were, someone else would have done it
already.

Clemens
