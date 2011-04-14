From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Gitbox
Date: Thu, 14 Apr 2011 15:22:17 +0530
Message-ID: <BANLkTikbyw=qSuFSF8MKEG1vJXrOSqGAdg@mail.gmail.com>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com>
	<1302721187.21900.4.camel@drew-northup.unet.maine.edu>
	<1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com>
	<1302722214.22161.5.camel@drew-northup.unet.maine.edu>
	<86vcyigcqy.fsf@red.stonehenge.com>
	<1302725089.22408.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <dsearles@medialab.com>, git@vger.kernel.org,
	oleganza@gmail.com
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 11:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAJDu-0004uP-5A
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 11:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663Ab1DNJwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 05:52:20 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40341 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab1DNJwS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 05:52:18 -0400
Received: by vws1 with SMTP id 1so1143461vws.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/d5xwZzjYx5DPX9MZ9H8BHxrzXrr0XFuEvWTYKPMP+A=;
        b=sIDATLxC+fFMBSMOoN759bjPReKtXMLbHUa9VYEdELc/uZy1sqGHnqS8QAKMlX+t4j
         69cXPLn99yuU5PeVGO/Ber0wSDYLluPKllafFgGQHcmBviarSnclxM7CO2uYNsmBZsv3
         a6WCrwqtcTW6XCS80c1IbT+MmGhfxgHPuBPzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oKhzY/ZkfgEYY2wykQw01v/X37qR2DkNT8XwevOVTzEHyYoo9rDTny3F3uoOvbWWet
         WFKdfgf9Z98O9tV2cDGNidFR5Sats9H7KjRIhIxZotOzw9TuzCLRORaSqBDgoYN+YYLT
         Ltt4iDreOx1C2zb9uTq6kk7CC1Lws3x04suGw=
Received: by 10.52.69.207 with SMTP id g15mr731422vdu.233.1302774737809; Thu,
 14 Apr 2011 02:52:17 -0700 (PDT)
Received: by 10.52.167.3 with HTTP; Thu, 14 Apr 2011 02:52:17 -0700 (PDT)
In-Reply-To: <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171510>

On Thu, Apr 14, 2011 at 1:34 AM, Drew Northup <drew.northup@maine.edu> wrote:

> If that's what he's doing then why does he state that the git binaries
> are "for your convenience only"--strongly implying his program will work
> in the absence thereof? I'm hoping he just made a typo--as what he said

Not at all; as others have explained, you're reading too much into that.

I believe what he is doing is often called "mere aggregation".
Perfectly legal, IMO.
