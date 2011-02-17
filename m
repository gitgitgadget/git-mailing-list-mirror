From: Miles Bader <miles@gnu.org>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 07:24:46 +0000
Message-ID: <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com> <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
 <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 08:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpyFC-0004V2-Jh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab1BQHZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 02:25:34 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42709 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1BQHZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 02:25:27 -0500
Received: by bwz15 with SMTP id 15so1409772bwz.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 23:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lKQN2fPKXJd8EaMPh+V5TZ+aEaWgxC5lYtnV2C5Fnuo=;
        b=wuDnHPRl3Bd2lq+zdnRiv8Mw3uOFOgnRkNRXlvlEu6v8WFwOVts9d6u+3vixmbDEkO
         f4Tt+WJP/C32HAK27kcwdGDoTaZnAvUqrOIGzCqgER51MltUQAI7C3b9uh1K9IwfamjM
         nyZXYa24SOExv2S/SE666OsyGSU1RAx41G0z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=SS8H/Lm3zx4+bMcrMhT0pLNFfF16qEzaDSpnEVY/+shx+b/snJDq17x1cm77+PvbkB
         WBq44/hyWRbo1jf17gEOglXHCTBIjtJ+tPwB8Z3mAYmCZYUTDzwdkSg/6EnIxmhsePRE
         Nnyfe9H8BmUjKbBpym6x6yBpc/XuAoLkokRJg=
Received: by 10.204.72.71 with SMTP id l7mr1320722bkj.55.1297927526339; Wed,
 16 Feb 2011 23:25:26 -0800 (PST)
Received: by 10.204.119.130 with HTTP; Wed, 16 Feb 2011 23:24:46 -0800 (PST)
In-Reply-To: <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com>
X-Google-Sender-Auth: x8Z9wmfRK6UO6FJJjhKKftnUVMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167049>

Hmm, on a related note, is there an obvious way to _show_ the current
branch's upstream...?

[I mean, which just prints out "origin/master" or whatever...]

Thanks,

-miles

--=20
Cat is power. =A0Cat is peace.
