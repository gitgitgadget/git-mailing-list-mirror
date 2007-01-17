From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 21:01:45 +0100
Message-ID: <dbfc82860701171201k3131e42flf03b129e39167c9c@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
	 <200701172022.52015.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 21:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Gyp-0002SP-KG
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbXAQUBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbXAQUBv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:01:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:60319 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbXAQUBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 15:01:50 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2594728wxd
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 12:01:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=neMtsX9KhUvjtV/rlWeh4Gip+YbXXn5pXSUPSIhkfPO4wIRTwWshVpsumDuRkzXsHnBx7yDVLRPL4phrTKBY/Mj9Bkw9WO6l6BSArSrF/2dRCssRwtXyh0kQ+8luE8I/JL7jS9e4rytD3E+QRGUXzylOmPftd6ywuHwXKrO867E=
Received: by 10.70.125.11 with SMTP id x11mr13332153wxc.1169064107198;
        Wed, 17 Jan 2007 12:01:47 -0800 (PST)
Received: by 10.70.111.12 with HTTP; Wed, 17 Jan 2007 12:01:45 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200701172022.52015.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 5565a55f8b645d69
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37034>

On 1/17/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Nikolai Weibull wrote:
>
> > I maintain the git completion-definition for Zsh.
>
> Could you add it to contrib/completion/ or at least put link
> in http://git.or.cz/gitwiki/InterfacesFrontendsAndTools ?

I did announce it way back when, but since it's included with new
releases of Zsh there's really nothing interesting to add or link to.
It's also in Zsh's CVS repository, but I do my updates here:

  http://git.bitwi.se/?p=dot-home.git;a=tree

although I now realize that I haven't pushed some recent updates to
that repository yet.

  nikolai
