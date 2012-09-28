From: Jiang Xin <worldhello.net@gmail.com>
Subject: Fwd: Please pull git-l10n updates on maint branch
Date: Fri, 28 Sep 2012 09:13:32 +0800
Message-ID: <CANYiYbFhVo7PC+etHHhai-+waz8MOz9OU-v2Y3oNgZqbmm9MSQ@mail.gmail.com>
References: <CANYiYbHWwfuFOyNPPTkMo5QLsBuq_jaqG_zSRuy1dryk4pKyNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 03:13:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THP9D-00039X-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 03:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819Ab2I1BNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 21:13:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62616 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab2I1BNd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 21:13:33 -0400
Received: by ieak13 with SMTP id k13so6113702iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=b9lANYSKC3UCwXJyIuGHuF7ABnJTRj2K/Eqg3VX6MUo=;
        b=aqo2Sw3n6FnaHbBGP/KcsNfrtX5sSi33Lt4zsEwO05vbOfhbtmbwWDIKaiCrDzjWNL
         ElCfqv/IuIYLfca1eqcRc6rpVAONhAvwlr53b0mdt3omfQ15qrxUgXHfKv1JMckCAxUl
         jjev6RuvLdPEt5569dhl4AXMCnUxBYqT4AtWsOLc3f0P9BgQXZQO8UD/aHcNjZ+ti1z/
         SJqi1+2pz4qvR/RH/0Q8S0j78HtlbkPzfn2oscJv3XgPSi1dPfhSbovPQl7gbd2CxTgJ
         7ak86YM3hPK0PYPj9t3hwJS3vHW1KrQdnzISzgzYwa8kp9SmVneijo9SVmGzzK4Wfxfo
         YO1w==
Received: by 10.50.219.229 with SMTP id pr5mr167910igc.59.1348794812524; Thu,
 27 Sep 2012 18:13:32 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Thu, 27 Sep 2012 18:13:32 -0700 (PDT)
In-Reply-To: <CANYiYbHWwfuFOyNPPTkMo5QLsBuq_jaqG_zSRuy1dryk4pKyNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206530>

Hi, Junio

The following changes since commit e70d1632bdaf25a9ee528e78133cab319083eade:

  Further merging in preparation for 1.7.12.1 (2012-09-12 14:12:48 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po maint

for you to fetch changes up to 5b3ba7193f2f99fa1c23c1952f3e0f880e101ae2:

  Merge branch 'l10n-thynson' of git://github.com/thynson/git-po-zh_CN
into maint (2012-09-28 06:49:08 +0800)

----------------------------------------------------------------

Jiang Xin (2):
      Merge branch 'maint' of https://github.com/ralfth/git-po-de into maint
      Merge branch 'l10n-thynson' of
git://github.com/thynson/git-po-zh_CN into maint

Ralf Thielow (1):
      l10n: de.po: correct translation of a 'rebase' message

Thynson (2):
      l10n: Unify the translation for '(un)expected'
      l10n: Improve many translation for zh_CN

 po/de.po    |   10 +++++-----
 po/zh_CN.po |   46 +++++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

--
Jiang Xin
