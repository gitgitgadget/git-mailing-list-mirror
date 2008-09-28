From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: small warm-up: easy parse-opt migrations.
Date: Sun, 28 Sep 2008 15:20:22 +0200
Message-ID: <bd6139dc0809280620g2bf80d65k7866aab4a9bbe654@mail.gmail.com>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 28 15:21:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjwDN-0002pd-QT
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 15:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbYI1NUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 09:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbYI1NUY
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 09:20:24 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34054 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYI1NUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 09:20:23 -0400
Received: by gxk9 with SMTP id 9so9722209gxk.13
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LUgk50bdTuk9nrzhg5qmibhWZypMPvPi14j2MHo9fOw=;
        b=uapCkKGEQebk08+ov+P6hI8xSdg19qACyoPMICYb8cAmmonC3b5dn+GMcZOJgMGEPC
         6kVkBRQhV5IY+tIK8Od5X6fxYNMcvR0BiaTOpaNZjkG/n9/rWmOyJfpCIc8JQyXKhcOL
         q8OpyV9uE2TF5LAtatPz7T5X1dNC7NDIsf39I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=QBi3MHbnT+WVI7DGHEBDWtnsl0MxMMCFnxni0/wH1eIiKYzYq1KCRHhaWxjdN42FiV
         AEC7IOal1esykGgTusAxuSAtXgbqBzOw3la+jGpYQiIW7qAgSPORsC7MfEdlzW/+OxqK
         O7VLQ1PAG/pBoJ/oFE3plrnOx4jKTgi+Gkom0=
Received: by 10.150.97.20 with SMTP id u20mr5793470ybb.96.1222608022236;
        Sun, 28 Sep 2008 06:20:22 -0700 (PDT)
Received: by 10.150.225.21 with HTTP; Sun, 28 Sep 2008 06:20:22 -0700 (PDT)
In-Reply-To: <1222595139-32087-1-git-send-email-madcoder@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96964>

On Sun, Sep 28, 2008 at 11:45, Pierre Habouzit <madcoder@debian.org> wrote:
> There's not a lot to tell, those are just three migration to
> parse-options.

I think you forgot the -n switch to git format-patch, yes?

-- 
Cheers,

Sverre Rabbelier
