From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] Documentation: fix a grammatical error in
	api-builtin.txt
Date: Mon, 27 Apr 2009 11:43:15 -0400
Message-ID: <20090427154315.GA9414@linux.vnet>
References: <20090413181121.GA8851@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:43:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySzY-0004hX-6m
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbZD0Pn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755315AbZD0PnZ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:43:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:37537 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZD0PnY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:43:24 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1835348wfd.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=sg3KcUahYzdow2UTYOnRo3I2LvkWhBP4Ixm75k2DlnM=;
        b=AIY31qWbpcWVgIVpZxL+RD7auiyzOlz/AyKssXVvukMOzRqD6MwpqzfWpVhbYd8amP
         4JyYevl61l+dO4KQ10rW3SZHo83e7s4OghrC0kwREKTjF0SgAu9r7aiQm0PzvXyl7D3y
         pESopY53nSbfqQl9/cm1VyQsxoa4C9R3SB8+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=CMgzcuwRxBXtO4IXsW6MrHz+QzL7r5Kl8TTZ2ZI0fF8Hho91bRWpE//DH/J4pzEkVA
         EST3yT92vAcK0chXyd3Kdyfbz+73PpT48tstTmeCS3KCmJCdTU3+HQ2ZywF+7/gcokMI
         UMQUD4BJKhAX203cZTN3N+wAf6YtOA4BTWHjI=
Received: by 10.142.211.7 with SMTP id j7mr1251050wfg.306.1240847004319;
        Mon, 27 Apr 2009 08:43:24 -0700 (PDT)
Received: from linux.vnet (n2-51-168.dhcp.drexel.edu [144.118.51.168])
        by mx.google.com with ESMTPS id 28sm5010414wfd.25.2009.04.27.08.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 08:43:23 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090413181121.GA8851@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117679>

On Mon, 13 Apr 2009, Allan Caffee wrote:
> Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
> ---
>  Documentation/technical/api-builtin.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/technical/api-builtin.txt b/Documentation/technical/api-builtin.txt
> index 7ede1e6..5cb2b05 100644
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -37,7 +37,7 @@ where options is the bitwise-or of:
>  
>  	Make sure there is a work tree, i.e. the command cannot act
>  	on bare repositories.
> -	This makes only sense when `RUN_SETUP` is also set.
> +	This only makes sense when `RUN_SETUP` is also set.
>  
>  . Add `builtin-foo.o` to `BUILTIN_OBJS` in `Makefile`.

Bump. (Forgot to CC Junio.)
