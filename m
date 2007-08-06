From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: gitbox status (for those who want to hack on it)
Date: Sun, 5 Aug 2007 21:41:55 -0400
Message-ID: <fcaeb9bf0708051841w4701d04dw894b61c5a26d6ed5@mail.gmail.com>
References: <fcaeb9bf0708041040w6d2b3f2cu1680e1e7dc542ffb@mail.gmail.com>
	 <Pine.LNX.4.64.0708051635170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 03:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHrbr-0005r1-DH
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 03:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbXHFBl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 21:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbXHFBl4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 21:41:56 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:53813 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXHFBl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 21:41:56 -0400
Received: by an-out-0708.google.com with SMTP id d31so245714and
        for <git@vger.kernel.org>; Sun, 05 Aug 2007 18:41:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=haD0vgYeJg96rxb+bTZj6aqMeu89aKecJwmpMckvcMRyJYt7ETnLEvm9S6htn5d/WGN3UDdLEXh48qXvdk/r/4DcLIkd/IAvLEi4l4s6dWcG6BaujpXLmZAeMQ9nueOMiAl9mL3u606TnN1KnJUX8VRogh1LBo4ac34aZmHD0/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CRcpl2CreLbjDRKqA9owGqDGY5MmZ+o9tz1ICyarSr7c5m8izB5qTBCLeuZRESYcF+0PR1HDejZS3AZyiRGXzRIdN0QA8ru6rvjbkLJpZXL6MDXjprdCxSlCrmbJp7GGcvDLM2xGxrjw1npIXcRBKLogLCV+Kko/i9rLHDIyoD0=
Received: by 10.100.94.3 with SMTP id r3mr2905774anb.1186364515265;
        Sun, 05 Aug 2007 18:41:55 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Sun, 5 Aug 2007 18:41:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708051635170.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55099>

On 8/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 4 Aug 2007, Nguyen Thai Ngoc Duy wrote:
>
> > I would say it's in pretty good state now because it can run through
> > test cases. Running tests on Windows can take about an hour so I'll
> > put test results here so you don't have to rerun the whole thing if
> > you want to know what part needs work.
>
> I think your project is awesome.  Unfortunately, I did not have time to
> check it out yet -- work-tree regressions and msysgit keep me occupied,
> along with daytime job...

Hey no worries. msysgit is actually good job. BTW, where was
msysgit.git going? I recall I saw something there in repo.or.cz, now
it's gone.
-- 
Duy
