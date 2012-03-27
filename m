From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Tue, 27 Mar 2012 20:14:32 +0100
Message-ID: <201203272114.33122.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203251955.21454.jnareb@gmail.com> <CACeyogdhChrGe-k+VLkAzq1F9U1TFYsCN5Kc_u7jAwRhaz+fJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:14:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCbr2-00077T-0M
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab2C0TOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:14:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:51453 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab2C0TOe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:14:34 -0400
Received: by wejx9 with SMTP id x9so154009wej.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=FTYS9lM0NeqMut8mDp0BLLvR2PVx3URcNi+MYWg+uxg=;
        b=z85tzk2N/hRXAjOXMXJtsMdqmtOi7vRfxN3d43GNyN5dIL8YUefX9MFGdcjXcGQpo8
         dltP+XzUT9QiT47Ytj31ZL1sMaYOdDl0Zc8qeYovbXs+0WUfJmxJvnvjDuv9fmyib0/s
         /si/XyQ68nyxZDljZutZKEbOXvgJwWH2s8e19UVWoHj5LXKDngMYPCqxeRzRmaWQ0el2
         aLlMbcYmlZ8k+/k81ZBf4zWjzEisEEnrdi99G+OspcUWfScsqD+lK38c6rbe9DuYAwMA
         1ogiP7HFXVE+twI5DXwUgjB64Qoulspqt6tdn0pFaP9KQ5fINW2hgCxfSX6/Ywl/gW/N
         bC1w==
Received: by 10.216.132.226 with SMTP id o76mr15365822wei.93.1332875673680;
        Tue, 27 Mar 2012 12:14:33 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id 9sm2788920wid.2.2012.03.27.12.14.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 12:14:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogdhChrGe-k+VLkAzq1F9U1TFYsCN5Kc_u7jAwRhaz+fJQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194076>

On Tue, 27 Mar 2012, chaitanyaa nalla wrote:
> Jakub Narebski wrote:

> > There was also some time ago a patch that added ability to mark a commit
> > to compare current commit to (using JavaScript and cookies), to have an
> > UI to compare arbitrary commits using 'commitdiff' view.  Or something
> > similar to MediaWiki (Wikipedia) page history view.
> 
> Hey jakub,
>
> Will that patch be included in future version, if it is the case can
> i consider implementing with some enhancements??
 
This idea is in my TODO list for gitweb, but I don't have specific plans
on when it would be implemented (if at all).

P.S. Please leave only relevant part of cited (quoted) response.  Thanks
in advance.
-- 
Jakub Narebski
Poland
