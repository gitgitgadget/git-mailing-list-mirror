From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 08:44:34 +0800
Message-ID: <AANLkTikjLN_c3W9JU1EkV52RREfTxqqF9YbPS-5biY3Z@mail.gmail.com>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 02:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORaYf-00069U-6v
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 02:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab0FXAog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 20:44:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43332 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab0FXAof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 20:44:35 -0400
Received: by gye5 with SMTP id 5so4075335gye.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 17:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+vxwW3U0ukoYfS2bxdqGWkdcq+YnpqksNvxgxm6GZz4=;
        b=pf4gYvmPxDqLcTJ4Trj9FlKrLQhKGJhY/lLpNMRjpGha+0aPr6KY1Co6UDGML2/q1g
         rnPRpVAfjpynjXCkdaNjhcyUJOjxGxMCLtl+CKaZtotMl1dU+2R/ZJf7oOokdgw/RuVd
         KimjP+1EY0bXOqncYAY79VEiUimJkbGMGZdyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v4b5XP9HqTOm30LiKcmW+cHNbcWh1DPr2prcj2xwSu1v1jtAFQK3v43S0t2FTvpIXU
         D2j1MMMOlETC/iHK8gC/2CxY3BszsANBpzBhHeA8WJjoBBnQDNFMtVklvx1XxPXccfJZ
         sYaqy08gx+8QpY+ygIaQPXPY5ZxovCpCkYRhE=
Received: by 10.90.247.32 with SMTP id u32mr5445016agh.180.1277340274560; Wed, 
	23 Jun 2010 17:44:34 -0700 (PDT)
Received: by 10.90.29.10 with HTTP; Wed, 23 Jun 2010 17:44:34 -0700 (PDT)
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149559>

On Thu, Jun 24, 2010 at 6:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [New Topics]
>
> * ar/decorate-color (2010-06-23) 4 commits
>  - Allow customizable commit decorations colors

This commit has some style violations. I've just sent a replacement patch, with
an explanation of (and an apology for) the offences [1].

nazri

[1] http://mid.gmane.org/1277338876-21958-1-git-send-email-ayiehere@gmail.com
