From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] Command names should not be translated.
Date: Mon, 20 Sep 2010 11:37:09 +0000
Message-ID: <AANLkTik5_n2CBNEmU2EB1QjXQ_ExxoRTUdRzq9_=dLTa@mail.gmail.com>
References: <0001.Command.names.should.not.be.translated.20100920@softwolves.pp.se>
	<AANLkTin8FR7+N-zCTWYpd=ygtJ6=0m+6iVWXoaok_na=@mail.gmail.com>
	<alpine.DEB.2.00.1009201230560.22862@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Sep 20 13:37:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxegQ-0005r5-0v
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 13:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab0ITLhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 07:37:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab0ITLhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 07:37:10 -0400
Received: by iwn5 with SMTP id 5so4210057iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 04:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bGUhMPaD+Z4k7HBnJFQ8AhWBbu/nZi/9/YU+eVf5Ous=;
        b=F83Dk3hgXgCAGVZSNiL/gRXh7x5bmirJrcbuKRoxEDV5eVcq6Yo0IxREABQQk3zrvx
         3DiLYr4Gfq+3f3Xr8l+8wljFbEoHPNO8B25qg6jNtAUCtmRB6nxeYFaDO0YHHiMkrocS
         zroyVsoXtgT8cQPtSHaIv54kujoPOnHM9ucv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eysCT8GJmmlwYusfX8m9Kwp5yjnwQzwRajDnojBr+9jkVMWm2tpGG7HAuJ/771/gjJ
         9qKgOhy3fRwK7V2blP0Ff1Y8MibMfR9YBJeM6iQwww8aj/FlF15AnIbHy2nKnYJtvnej
         mN0uWJ7hSbquvbcbxaYHwI+kRJ+KZQgl1qirM=
Received: by 10.231.162.2 with SMTP id t2mr10162189ibx.57.1284982629382; Mon,
 20 Sep 2010 04:37:09 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 04:37:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009201230560.22862@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156615>

On Mon, Sep 20, 2010 at 11:32, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> I *thought* I mentioned that somewhere, but if not sorry for making =
you do
>> un-needed work, and thanks a lot for the report about this issue.
>
> I thought you might have, but I didn't want to risk updating my work =
branch
> before submitting my changes, so I submitted it just in case. Just ig=
nore it
> then and keep patch that adds the sv.po file.
>
> There might be changes to the sv translation later on, we are still
> discussing parts of it, but I will make that a patch on top of the on=
e
> submitted.

OK, should I fold your newly submitted sv.po into the ab/i18n series
I'm about to submit, or do you want to work more on it?
