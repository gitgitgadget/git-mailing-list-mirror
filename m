From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:45:58 -0500
Message-ID: <76718491001292145y3d31ecc9y9b180ec89587288f@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
	 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
	 <7viqakcu56.fsf@alter.siamese.dyndns.org>
	 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
	 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
	 <ron1-F006CF.18381129012010@news.gmane.org>
	 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
	 <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
	 <alpine.LFD.2.00.1001300011290.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ron Garret <ron1@flownet.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6AV-00050g-9m
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0A3FqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183Ab0A3FqB
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:46:01 -0500
Received: from mail-iw0-f187.google.com ([209.85.223.187]:38047 "EHLO
	mail-iw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab0A3FqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:46:00 -0500
Received: by iwn17 with SMTP id 17so2986193iwn.25
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 21:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JGS+3/S4jA22xc0ZmABhWumInYww3ah85UphIg2sRJk=;
        b=FBZjeTtimVC8kqm07xIs7Yt8/+R4ozsnVcAxc2Hmt4cV/yNRpWegQrWgxat/YtYYWf
         xC9JBeANUVJymUmk1E5QeO+IzmJF9dMBiR2yP2TpoOXWIsSV6QMIPRiu+HHsKKQ9Vath
         B6C1ZyB+0HO69+8btDCAfoxudKF7kQcnoiaQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=E2pxXf3ELQr6G2GKD/pNCGh3dQ38K/v49WfqGkI1L70dBOqKwMrzABOHCl0bzaTnBG
         /E5RSAtzM0vlg+u8Q2jjAxextSfN0835yEuAZDRrm26PAG5E7UAMTpPbJ3JSfPyqf6vb
         p1doElsOB9g6/pd0PievOJrXIk6F0rQ6vIqsA=
Received: by 10.231.170.3 with SMTP id b3mr2590126ibz.89.1264830358768; Fri, 
	29 Jan 2010 21:45:58 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001300011290.1681@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138449>

On Sat, Jan 30, 2010 at 12:15 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Could you please take this really nice explanation and make it into a
> patch adding a "Detached HEAD" section in the git-checkout.txt manual
> page please?

Will do, and I'll even make the branches go upwards. :-)

j.
