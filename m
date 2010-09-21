From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: does kernel upgrade require a recompile of git?
Date: Tue, 21 Sep 2010 19:25:30 +0000
Message-ID: <AANLkTimvAG=_Ym2xbNOuOxfaaBo7e1PMuQtO3fvau3d3@mail.gmail.com>
References: <i7b003$81q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 21:25:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy8TI-0000RT-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 21:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188Ab0IUTZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 15:25:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61050 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab0IUTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 15:25:31 -0400
Received: by iwn5 with SMTP id 5so5344375iwn.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ETlMsnnEX8AReS8GILu9T14nmQUgyjtyDzgoZXtoSBE=;
        b=paFly9mrCPjqk8TXrm174M83hJqDreqvya+9kcfDVjK7dmRLJCx1IT8Cm+yFEcyIie
         owFhdDJU8HGwH6KhfuQPfR3UxFNRlkwwKdUmPr30c2EofyVn8+MeoPgfISTTOx2hVHqn
         1Wp+jpMkeN0mA72RV2qNElVJvVxsXyN3PDUAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SMpDCZDPJobgkV3Y+4fe050jfEdcDamZLMIAp9us4mrkGgK2So43TSlaRdOiaOgmii
         ABnecZY36qhL/112gU1cia11qaYLxQQUu9afLaqj45EFoIhMPhGX+mSP/NecBJZPPk/K
         01+oa0HJXNK1mORcgCYg02U5e+8Lw4AxKii5A=
Received: by 10.231.30.72 with SMTP id t8mr7373537ibc.46.1285097130405; Tue,
 21 Sep 2010 12:25:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 21 Sep 2010 12:25:30 -0700 (PDT)
In-Reply-To: <i7b003$81q$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156745>

On Tue, Sep 21, 2010 at 19:10, Neal Kreitzinger <neal@rsss.com> wrote:
> If the linux kernel gets upgraded on my machine does that mean I need to
> recompile git?

no
