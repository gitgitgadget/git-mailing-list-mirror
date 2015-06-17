From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 16:58:27 +0700
Message-ID: <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
References: <558127CB.70603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ed Avis <eda@waniasset.com>, Scott Schmit <i.grok@comcast.net>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 11:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5A7q-0007IX-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 11:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbbFQJ7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 05:59:06 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32887 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbbFQJ67 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 05:58:59 -0400
Received: by igbos3 with SMTP id os3so64294237igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WfTeeePPXNDLyZb/k4eimgvlibPA2sVe1OBXV3JjV94=;
        b=rZ9MpphNBk9PBzdvc2BWc/GL4lkH1Zf5Y0WMCBQSghMv2o0s0SuXnpkq5WT1G4F4+N
         nQ2CMQxPcFFsb6agDpcEk+bfGVFROesXGocsrENezr8nGtjo0DAF0H0E+uEh4GQicINQ
         6PH3qyMJG0Y8EpYguNXvLoR+/Bsku+EvsDY5LKnKlcLCwg9OPH3iIP8fiNUS+VNimon2
         E/zxtyWptgw6rumxWBPwN1KsfXKKJrbgO14B5TQfNKKz2GXqUzZ48LhVOLSywOgXXVnE
         Ka4K83Ba2FtK2m7QfLS/l1op1MyAI3AE4AhB1US6rpezT2ume9avOw0QAM6YqTPixGAM
         ULsA==
X-Received: by 10.50.4.66 with SMTP id i2mr34129231igi.40.1434535138246; Wed,
 17 Jun 2015 02:58:58 -0700 (PDT)
Received: by 10.107.6.226 with HTTP; Wed, 17 Jun 2015 02:58:27 -0700 (PDT)
In-Reply-To: <558127CB.70603@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271824>

On Wed, Jun 17, 2015 at 2:54 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> -git-checkout - Checkout a branch or paths to the working tree
> +git-checkout - Switch branches or restore changes

I didn't follow closely the previous discussion. Forgive me if this is
already discussed, but I would keep the "in the working tree".
"Restore changes" alone seems vague.
--=20
Duy
