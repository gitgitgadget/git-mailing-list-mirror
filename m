From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Best newbie / advanced / expert reference texts for Git?
Date: Fri, 19 Nov 2010 19:14:50 +0700
Message-ID: <AANLkTinmPsL8zJCAVDibb3EA7RuLP3usRVSSyooPuma8@mail.gmail.com>
References: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 13:15:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPsf-0005hK-RB
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab0KSMPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 07:15:21 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49828 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0KSMPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 07:15:14 -0500
Received: by wyb28 with SMTP id 28so4380402wyb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9G1JCna4qwtyej8gDVbhpWQHxlSBYUx0kwmQGP5CFQE=;
        b=nf18AheZGQE4+3hHHydCDzTmE/6kCAjGtY84yeue27aa49UuFxFAf0u+SofKGd22yF
         JJZOxMbf4ph5NdRleymOGslpwH05IzDTEi6GLx/XHMFKRBUqmCTliYFd4mjP9AHJVZH6
         wcvmZhodJLe+2JH6PLcKtsbM5IufAxRA7V5BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Gk7F+tx5bG+L/1FXbCoYtt9FLZygWkktv2oWjH2pNA/2TjfXzhlRQvd/4FTEv7wmzv
         fFzibLr+MMLyQXezTlUfyAfOgYQxaD0SJC95G5gZk5GVhy5tt79lNG4lRp5mJa4FCgxp
         wO1gq1QRmRvjZ/r43RyHRuO2f30hz+awGoAcs=
Received: by 10.216.166.68 with SMTP id f46mr896409wel.26.1290168910609; Fri,
 19 Nov 2010 04:15:10 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Fri, 19 Nov 2010 04:14:50 -0800 (PST)
In-Reply-To: <AANLkTikctrASqX0FLCOapyJCt1VqG6_cxs_oXJ6fExZC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161743>

On Fri, Nov 19, 2010 at 6:02 PM, Dun Peal <dunpealer@gmail.com> wrote:
> 3. Advanced: someone who knows all the above, but would like to know
> everything there is to know about Git.

It's obvious: the source code and its history, then old timers (ok no
more texts) who can tell you its history, original design...
-- 
Duy
