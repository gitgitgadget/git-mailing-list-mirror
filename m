From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Thu, 24 Jul 2008 20:53:15 +0200
Message-ID: <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
	 <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5xB-00070e-Vr
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbYGXSxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYGXSxR
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:53:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:25386 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbYGXSxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:53:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3597133wfd.4
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8gVyjnSPzDKHYIY8SWXyuC4GxLADBw6g36tBiagE4o0=;
        b=djLwef0YBL+l9iKiEN6U+iZZkclA5gNklmroJJIR6W/0MnTB9COMbnAkpHxp5pOILa
         n3MPxdTJRResEMsHil9IuqwktZ4tGmhwbGxqYcnFXGfIEPLPa4GrK803w9yKCmY+OZfr
         SqrtN2Z7Zx2Bq8urPODxgQRUZ/nKs5nnYZ0+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=TgdSBCdwbiOpWfVHJtWPvhcS/mpw9isGQyfsttLc/sKCRhwDJfELYv3MoP/DLR5Lh+
         B1WFcycOh8Bn7Fd26NctKXBjf5sfRt56u+m10RBZNcaB2k321i1M3oilk2k30f/YWmvr
         tUTa7YeC9ZoBzS3GZDoAFnbccM0TrN/Jop0OY=
Received: by 10.142.221.19 with SMTP id t19mr217451wfg.119.1216925596233;
        Thu, 24 Jul 2008 11:53:16 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Thu, 24 Jul 2008 11:53:15 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89940>

On Thu, Jul 24, 2008 at 8:45 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>

Something went wrong replying here possibly? Or is it just me who is
receiving empty messages? (At least the 3rd empty mail I see.)

-- 
Cheers,

Sverre Rabbelier
