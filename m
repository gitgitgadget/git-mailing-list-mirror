From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sun, 29 Mar 2009 14:55:38 +0200
Message-ID: <fabb9a1e0903290555o3503b58ie097f8f8336c4401@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <1238278694146-2550633.post@n2.nabble.com> 
	<fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> 
	<1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> 
	<1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com> 
	<1238328537685-2552369.post@n2.nabble.com> <fabb9a1e0903290535y59cd3a1fvd5a7d3476dff45bc@mail.gmail.com> 
	<1238331203288-2552470.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 14:57:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnua8-00049e-PH
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbZC2Mz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbZC2Mz4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:55:56 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45964 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483AbZC2Mz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:55:56 -0400
Received: by fxm2 with SMTP id 2so1601183fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BYil2xqfxM8Jecz4wFlxIdGyG0ElbqmjJt8KNPTOx/c=;
        b=ocCdvxOCtEGn8FtcNiXNCTHdKZRVoYbvTS2nJ6KCHXTQSAgOmsBrFUCBOecTYHEVeW
         UIvBC9iolflU6tH9OlV7bt4CDyq1jbW0pVkMZ7YyMc5EUOljKFDc2e7ebqmMCbThsAf4
         gFKtOcKC+5pHBRT8ERBLRbyNZ0Mh82EgEG4OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LEKooGn3tZxNyC3UXOl0kYHbjEJjMvrzaMZMqySdiyCTeFQwdmKUumBIVI8lone/u0
         DE63f4HoaQ6Gz1yG2hiey2YPm0T1amsJ1exynAKJ2Z2KtBQK93Ql8pHePBTZhUGcCi80
         FZ9ZftzyvQ0W9+xKgiJq6GZHGlKbWAyvT/6OY=
In-Reply-To: <1238331203288-2552470.post@n2.nabble.com>
Received: by 10.103.228.19 with SMTP id f19mr1215641mur.18.1238331353159; Sun, 
	29 Mar 2009 05:55:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115026>

Heya,

On Sun, Mar 29, 2009 at 14:53, jamespetts <jamespetts@yahoo.com> wrote:
>
> "Unable to determine upstream SVN infromation from working tree history".
>
> Have I done something wrong...?

I'm afraid this is where my git-svn knowledge is no longer sufficient
:(. I have had the same problem myself, and I don't know how to fix
it, perhaps Eric has a moment to enlighten?

-- 
Cheers,

Sverre Rabbelier
