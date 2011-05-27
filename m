From: Claire Fousse <claire.fousse@gmail.com>
Subject: Re: Git-Mediawiki : Question about Jeff King's import script
Date: Fri, 27 May 2011 11:05:07 +0200
Message-ID: <BANLkTinxb8vpjDx7pJ1zL4GhwL3nLe0YoA@mail.gmail.com>
References: <BANLkTi=nLZV_QCyKT8LOhzkJYoJD6J4wPA@mail.gmail.com>
	<20110526154214.GA4049@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "matthieu.moy" <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 11:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPsyp-0007N7-HQ
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 11:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab1E0JFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 05:05:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51440 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab1E0JFH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 05:05:07 -0400
Received: by pwi15 with SMTP id 15so716198pwi.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DIDM4UMxPibbt1WIQwlmTDREN7J8fuXNnOkBDaXclxI=;
        b=vMCu4Qs7gIJH4K2ZgepagiujQJ4vdDa+ITcVOMZqwipM1t3Ha0V3dmAx5RqVjcwXvv
         1MYy0Qu1OIWiml97FNkEiRZiA1hUKLQV8xbKxKCwWOuJKyaJzWWqQXeH5mHvlJAYtZBn
         3JXWgquxOsFz+hr7X4XLEwTpS5dwOyAF0Cesw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ng0YCbRfVxrBGFoy2tLVRm187BW2zS8RznDylnzBf0zVza62kwE9MESCiNPW1MhH/D
         /b6aVpXH67WXb8pIIu6TkHkTZALz5LWrBMImrg2XIhuE+kQyPLgnjwsj2YQbr9RHepq6
         cHb+zDzAxKwy2j4aEvyfmD4aXf+5HsojXGZN0=
Received: by 10.142.144.8 with SMTP id r8mr310078wfd.142.1306487107501; Fri,
 27 May 2011 02:05:07 -0700 (PDT)
Received: by 10.143.155.9 with HTTP; Fri, 27 May 2011 02:05:07 -0700 (PDT)
In-Reply-To: <20110526154214.GA4049@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174603>

Thanks for your answer. That helped a lot.

-- 
Claire Fousse
