From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GIT - cloning torvalds/linux-2.6.git repository trouble.
Date: Sat, 5 Feb 2011 19:52:37 +0100
Message-ID: <AANLkTi=E3gWG2-3nLBW6JP+Wks2=4oUWSNSpk0=qEaU-@mail.gmail.com>
References: <AANLkTikiKagzJMh_xuOSzfA4c-qxOHhVeU2jhmbaDHji@mail.gmail.com> <AANLkTi=FAWh9T3HaocdKB7V4osRPsehTo=hTP0U-JbfR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Valentin QUEQUET <valentin.quequet@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:53:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlnG8-0003x7-Cr
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab1BESxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:53:18 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50794 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab1BESxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:53:18 -0500
Received: by iwn9 with SMTP id 9so3270737iwn.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=O9FRXn69UgPLhKrcVmjww8A6A80/zN1PKNvTmE9RiLU=;
        b=RkBAzY8+W1XKzuloQRU9tRFjaH0MmNkFCtfM6pl66rsgfwcTxO+/JuWMPSKa5p3vQ4
         17IGDlbveGrKQlbWAO7v4cWaz2idm8LgDHPSuRGplNYoszwCa4xhibLWtl4sTvu3GX+I
         qTtR93cHD7avc9Q/4phkzcLW5ck1gYwlCTNgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ulx3YRXSKnCU5lw+WikRciBfbxrgRebh/t9CvE0UqPSTCpHLnf526QiGOVICHwhvtr
         2RSVHuiLvkVAb2Ua8HZk52hn0z6HJ+yYByURnLQHUMAJi8BISn7UBNMxoS6QmcuaCKGd
         g2t8PdOzdHqU8cKy3U7BHLCZ1HQjib6adKDVc=
Received: by 10.231.207.71 with SMTP id fx7mr14766051ibb.127.1296931997524;
 Sat, 05 Feb 2011 10:53:17 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Sat, 5 Feb 2011 10:52:37 -0800 (PST)
In-Reply-To: <AANLkTi=FAWh9T3HaocdKB7V4osRPsehTo=hTP0U-JbfR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166110>

Heya,

On Sat, Feb 5, 2011 at 19:45, Valentin QUEQUET
<valentin.quequet@gmail.com> wrote:
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/info/packs
>
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-0b38509807589c455b1c769368348bd845441959.idx
> http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/pack-c53d2db50f885f3803a3afd46484b54c06b1433e.idx

<snip>

What happens if you lay out your repo like the urls? I.e. without the
"http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git"
prefix?

--
Cheers,

Sverre Rabbelier
