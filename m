From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 4/5] fmt-merge-msg: Remove deprecated --summary
 option
Date: Sat, 21 Aug 2010 11:19:05 +0530
Message-ID: <20100821054903.GG6211@kytes>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-5-git-send-email-artagnon@gmail.com>
 <20100821040421.GB2636@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 07:51:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omgyw-0000o9-UG
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 07:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242Ab0HUFvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 01:51:01 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65257 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab0HUFu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 01:50:59 -0400
Received: by pwi7 with SMTP id 7so1322798pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 22:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4NqG0Rmo0kU3NjCHmBg6isTwMBjbaFP4z8FrSnxOkks=;
        b=nuY59csrd7ixt8mPbcyyWiDssvZMlPgC0C1N1sYy+GmJwb9fpOM15HpgkwFBoa0WQl
         IBjgEaXgAqXKWNs6jDcNG5ZdIW8Ym8Hysx8XvRgTz/Eu/N7KwqA7VwnlAo1JdyNSh4ZV
         nHFfyGP+JdiizJC1GSpOxY8NMPhODxzbxWUdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CZDmcDmQNvlHV/ClUS5E5bEMyQ3qnwpWeLNFpHgOrTzN+Xs1Nit5dZuNLiL8WaMahi
         G2+OzkRze2M4aDiKjQCcUQXqA+M0rUz0fyCT0MBDGTA7b0v+n0m1BRXIrcBH46KxMofj
         UbqjeEW/Rm14MPG+16DDCTdzfFU+RUPJJyjsA=
Received: by 10.114.92.3 with SMTP id p3mr2659546wab.77.1282369859245;
        Fri, 20 Aug 2010 22:50:59 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x9sm6445153waj.15.2010.08.20.22.50.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 22:50:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100821040421.GB2636@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154111>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Remove the deprecated --summary option
> 
> We stopped advertising it in v1.7.1-rc0~3^2, right?  That would make
> this v1.8 or later material, I think.

Oh. I should drop this patch while re-rolling?

-- Ram
