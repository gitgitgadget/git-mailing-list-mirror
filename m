From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: config option for diff-opts
Date: Tue, 22 Jan 2008 22:04:21 -0500
Message-ID: <9e4733910801221904k5f66a231t9cb8330eff3861c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVv6-0006c0-6S
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 04:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbYAWDEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 22:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbYAWDEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 22:04:25 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:29240 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbYAWDEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 22:04:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4770699wah.23
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 19:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CSi6V2gp7EITVgQKKtWptFn1hY0N+3UXnvOuSdRsWmc=;
        b=powh2Vz7Gt990tg+u5Du0Mq2+ZonWhW/X2/kbDAGXqJGDdv9mAd0mPMUx+xCUtDQg7qedRm8nw0o4v9YcT2vR3JguQbSLGBeux4irmOpni18h6tfX5+oCA3XU0SH4ZAuFDp9jF3C2nrkr3666eDJBRmITnAba/ICQxPwJm4RFmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xzAMAriGakXhEFI+LbRXGFziAeFIPNKexioXTjKnkq3k3ahXqPLGhG+wtPqJrtNFoOILfCiw1scrG2Lk2pKWpWfyBuy6OjLQ332WsaOQfToKFyBAIE+UY5NO8mbiW+7z7t49q2B3sw7CIcK4Iawtv9gPVVmrMK2Mc9KiZqAhA5o=
Received: by 10.114.194.1 with SMTP id r1mr7626058waf.40.1201057462014;
        Tue, 22 Jan 2008 19:04:22 -0800 (PST)
Received: by 10.114.93.14 with HTTP; Tue, 22 Jan 2008 19:04:21 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71504>

Could I get a config option added to stgit for diff-opts? So that I
can always have git diff -M set on renames.

-- 
Jon Smirl
jonsmirl@gmail.com
