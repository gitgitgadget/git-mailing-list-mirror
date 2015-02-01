From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.3.0
Date: Sun, 1 Feb 2015 11:14:43 +0800
Message-ID: <CANYiYbF4F4z60HsC=Eb2vjuU9DihncHf1OeLTTi_VMkg0_mE9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Alex Henrie <alexhenrie24@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 04:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHkzv-00088N-Na
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 04:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbbBADOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 22:14:45 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35873 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbBADOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 22:14:44 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so33077541wgg.4
        for <git@vger.kernel.org>; Sat, 31 Jan 2015 19:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=IYiwq99/LhSS1YHiU9J3NeeGdVhZPLZ8robuqd8MTlE=;
        b=PznSTumAzogrHXuJ0sXJ2QRHaVewLkwXQJmQQ5AmKr6rHXsp2ojbKdk7SarWvB99T2
         4DZnvCVzfri5s4Omc7va/yDu6vWOuPEdpkIFEL47FGLoTPcYIDcsjp7rVboWeAcSTnCN
         gnp9voSB8k1MPe3PbeCxltpWCaH4cmXoPyFpr3I+zKV1aoRZCVuJkGpG9DCkgpLH+7X2
         WN5CqzgBxxHWZoF73xzoHEBX4xMSYQC51u369u0wRGsjzOrlUZn0JHMYH7QDi0ysTlFm
         qcgkbBwmcTQQ4WpzzsJngv1IszoYI6WrUnsvSNlzvnf2Fb+w5PFVzInm+TxZObkGcz2I
         WXoQ==
X-Received: by 10.194.237.41 with SMTP id uz9mr29648864wjc.80.1422760483586;
 Sat, 31 Jan 2015 19:14:43 -0800 (PST)
Received: by 10.194.80.131 with HTTP; Sat, 31 Jan 2015 19:14:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263231>

Hi Junio,

The following changes since commit 15598cf41beed0d86cd2ac443e0f69c5a3b40321:

  Git 2.3.0-rc2 (2015-01-27 14:39:53 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 7471cf88f54990831fe2fd84160350fe432a7b76:

  l10n: ca.po: Fix trailing whitespace (2015-01-30 15:02:34 -0700)

----------------------------------------------------------------
Alex Henrie (1):
      l10n: ca.po: Fix trailing whitespace

 po/ca.po | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--
Jiang Xin
