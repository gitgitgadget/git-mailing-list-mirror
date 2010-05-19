From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCHv2] git-web--browse: Add support for google chrome
Date: Wed, 19 May 2010 12:06:29 +0200
Message-ID: <AANLkTinzbHtabNuDbRRSzyy6a87JeXotiZTq4foR-iVG@mail.gmail.com>
References: <1274262692-3783-1-git-send-email-pavan.sss1991@gmail.com>
	 <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 12:14:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEgIJ-0001ZS-SK
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 12:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841Ab0ESKO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 06:14:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45765 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756203Ab0ESKO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 06:14:26 -0400
Received: by wyg36 with SMTP id 36so284996wyg.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=a1CZZuaTNkSJY5MS1b7bPPiCrX+uSoMS5wpc1kcz3VY=;
        b=I92xGoi/eJBQLYDKRs/QoRsaLPNI35omRRHd8b0PKO2dyNPv29h0CLOJdrbO8p/KEi
         tsFTHsKa57+N2HZFmLg89wtwVMDMRrbH8acYG6JI1WWnunzf7K7wGtUZozcFIIbyXrpQ
         OP0G50bz/vq3gksMEmEksLiX8AMZIu70HJjCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=LMdntekelnIl8NFcK+vn4ihT1c3ux0yd3dsCq18O+PPXhkKdJydJrLmyViVq6cpYx2
         6ciEeYDeH2x8buKrczRwDXcJKq+03MbKe1sx4K+P9KgZHBXYHZT2gMzo5aBs8kPx3ZkK
         J4Mt6iAuloQepZDiKB7Y97/Hh7NSxSyI8r+3k=
Received: by 10.216.168.7 with SMTP id j7mr5039023wel.214.1274263589095; Wed, 
	19 May 2010 03:06:29 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Wed, 19 May 2010 03:06:29 -0700 (PDT)
In-Reply-To: <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147323>

On Wed, May 19, 2010 at 11:51 AM, Pavan Kumar Sunkara
<pavan.sss1991@gmail.com> wrote:
> Add support for another web browser called chrome. To
> select it, the value of the browser is 'chromium'.
>

Extreme nit-pick: This last sentence is a bit outdated now, isn't it?
Both 'chrome' and 'chromium' should work now, right? If you decide to
post another version (I'm not sure it's worth the hassle, though -
this is probably in the who-cares-land), perhaps you should mention
that you're adding support for Chrome AND Chromium?

-- 
Erik "kusma" Faye-Lund
