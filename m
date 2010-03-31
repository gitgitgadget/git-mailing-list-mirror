From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Documentation: clarify grammar
Date: Wed, 31 Mar 2010 10:46:00 +0530
Message-ID: <p2kf3271551003302216qc6e378a8u2f85751c9c8a24d5@mail.gmail.com>
References: <4BB2B34B.1080508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Yawar Amin <yawar.amin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 07:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwqP0-0001LS-V8
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 07:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955Ab0CaFXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 01:23:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48523 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756926Ab0CaFXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 01:23:30 -0400
Received: by pwi5 with SMTP id 5so8478697pwi.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 22:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=6GL7EB/j8JhJjYptttVsb26tWFei1VLUsW6yGYUPfWY=;
        b=rln+lM16OG0P8VEsjzj6EH6oBchEa34+jmCpjZ9kOPQOCSg8I8LE8GFjtO0ucR52k3
         xVGHr0B29ISReIR6oDmj5YLbzuDWDFpUYedb2XCZS4GS6oBpJMdm7RpS5S3gDzl7Q/zr
         WQvEe9s12yyURt7s2vap1yMfGLQBkN76pKtkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=wKtGqmEgepLeh3AstsyHhPzyo6tEZNP2cZCumsTXHJMeOyPBYeNU9C1jycM4SunABr
         ZJihv8jzxRmBnGkwH13UYmXlmyrr7rSTF1XtA7ux8fsPdEeuti147ufmGp8ifzezwI9x
         gAKKZoTtdlDxTUI7emCdYWXhfNKNuutpc/Bw0=
Received: by 10.142.109.19 with HTTP; Tue, 30 Mar 2010 22:16:00 -0700 (PDT)
In-Reply-To: <4BB2B34B.1080508@gmail.com>
Received: by 10.142.250.3 with SMTP id x3mr1022619wfh.168.1270012580100; Tue, 
	30 Mar 2010 22:16:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143647>

Hi,

On Wed, Mar 31, 2010 at 7:58 AM, Yawar Amin <yawar.amin@gmail.com> wrote:
> Parenthesize the mention of the git protocol to make it clear that
> `former' and `latter' refer to the standard SSH syntax and the
> alternate SCP-like syntax, rather than the SSH protocol and git
> protocol.

I've already submitted a patch to rewrite large portions of the
urls.txt page [1]. Kindly submit patches against that.

-- Ram

[1] http://thread.gmane.org/gmane.comp.version-control.git/143499
