From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 15:19:22 -0500
Message-ID: <20120426201921.GA15026@burratino>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
 <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "David E. Wheeler" <david@justatheory.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVA9-000703-LD
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759137Ab2DZUTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:19:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64414 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2DZUTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:19:31 -0400
Received: by iadi9 with SMTP id i9so12122iad.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/gqSzOtVXbPHLc7GLMwA99RmwdhtKApZaC9kVpnqbHA=;
        b=L4hURejTlw2yID/ShsJ66WWVZha6BF358+c6lMrEzqotpFbBBHCKhuvP6y8ICVpXIN
         MerHi3w0YN2iP+ub2Uf1LjB4PZfMAiI9CQ1rHiK+BeX1Y/nBmPi2EZtvJFbmJavxzi1u
         eFz7orVQwHWhfd1WzuJaHBFGFznqgOcHSGQlr31D2SpCgHf4TK4SzhW8qQnLnWubDbT9
         vVlI2Qc1WHmO8Xjwz9GQCwCF48cL7ahvydG5wh94oUTIJbjUPjqXyPCOYYFgg27GqNJG
         l65ldinORJkc5Q2DMjaFNxdPX6l1wNRGiwxQPUoHhghj2lrFnJqnhoMDHH/EYfHxuGWP
         4SOw==
Received: by 10.42.169.132 with SMTP id b4mr7127158icz.5.1335471571022;
        Thu, 26 Apr 2012 13:19:31 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dk9sm25770471igb.13.2012.04.26.13.19.29
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Apr 2012 13:19:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196407>

David E. Wheeler wrote:

>         5. GIT API documentation
>            git-htmldocs/technical/api-index.html
>
> Which also aren't very useful. :-(

Sure they are --- they tell you where in the git-htmldocs tarball
from [1] to find the relevant pages.

Do you know of a public webpage we can count on to continue to serve
the docs?  I agree that that would be even better.

Hope that helps,
Jonathan

[1] http://code.google.com/p/git-core/downloads/list
