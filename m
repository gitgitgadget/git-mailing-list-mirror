From: "Lee Marlow" <lee.marlow@gmail.com>
Subject: Re: [PATCH 2/2] bash completion: Use 'git add' completions for 'git stage'
Date: Fri, 9 Jan 2009 09:06:24 -0700
Message-ID: <7968d7490901090806j58cb653fvbe7c5e8ee648d577@mail.gmail.com>
References: <1228937958-5091-1-git-send-email-lee.marlow@gmail.com>
	 <1228937958-5091-2-git-send-email-lee.marlow@gmail.com>
	 <20081210195957.GE11928@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 17:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLJtm-0005t3-Fk
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 17:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZAIQG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbZAIQG0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 11:06:26 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:1977 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZAIQGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 11:06:25 -0500
Received: by an-out-0708.google.com with SMTP id d40so3088576and.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 08:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GtpNqVn6NJ/tcgNGXvrbpWIgaPWCEL7ch1QRrPonsWs=;
        b=LcUdGWhlk4Tix/RxLyOf7ck06+4Nxdcwqd/Xk4a9KdRWwg/7mCB2984XrXQYZsOA5e
         w3H9gy/+cvDuiwKoedy6j99kdYlhObH40b7t48RYT1hpx2r8xqXfmJNTgqF3maMihScQ
         Gg1R4oDcj1XcrruSlvgfRwjelZpUw3AscTtAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ow+wMTVeAcxzKIIM23g4OYfwUME8TCop1RY1Yxglvkx0yHWCXQZoJNfxxksrS73Nvz
         vxwEk6xTDUB6ieULpAnAl5yD/UvX3DtNkREKOZtT0ZPwJeypaVDW81yrAiSyjIrW43ig
         +0owR1Wfu/3y5ML08Hygo9lYUQlPRJ/8Aceao=
Received: by 10.142.108.2 with SMTP id g2mr10758764wfc.259.1231517184223;
        Fri, 09 Jan 2009 08:06:24 -0800 (PST)
Received: by 10.143.19.9 with HTTP; Fri, 9 Jan 2009 08:06:24 -0800 (PST)
In-Reply-To: <20081210195957.GE11928@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105018>

On Wed, Dec 10, 2008 at 12:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Lee Marlow <lee.marlow@gmail.com> wrote:
>> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> Also,
>
> Trivially-Acked-by: Shawn O. Pearce <spearce@spearce.org>

Nudge
