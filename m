From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2011, #01; Tue, 4)
Date: Tue, 4 Jan 2011 21:11:47 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101041959020.6201@debian>
References: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 03:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaIr2-0007Yi-DL
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 03:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1AECLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 21:11:55 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42197 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1AECLz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 21:11:55 -0500
Received: by qwa26 with SMTP id 26so15198265qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=mVazj3HegUzC3dVAGValcoPQv38HpYWUmc6idr0xvn8=;
        b=jO0wV0V3O/os0xPO8shL5167iX/Y0zVO2gaMKCzONE7XnTVKGXD+C/MyaTqxxOYu1N
         NriPVWCe5eukXvvZJlYu5f9KEa7GVIlEPw9VUdSrnzjBcRDHJQK7Jd9wzlYb47m4EFJp
         M4MknRSzc/n8KB3v52Mdpve4Gob2/91XNRWQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=T6pqztC+fG3nHrlgTMi1BxHjG7o3fU7Z5DCTIocnkH9tzL6r9UF2CkYChmgCDG+1zG
         Ey9pdzD1Vqvw8Gk6mpihd9AvPKfb8oxqfIG3ZoueUmzV4FrZ9xtu4WRYJcgtxMo4GFPG
         h5t+5eT673M5IjTagPW3BN0CJmUVMX4xMA30s=
Received: by 10.224.19.203 with SMTP id c11mr21230883qab.170.1294193514317;
        Tue, 04 Jan 2011 18:11:54 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g28sm13222054qck.1.2011.01.04.18.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 18:11:53 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vipy4dy8y.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164539>

On Tue, 4 Jan 2011, Junio C Hamano wrote:

> A happy new year.

Indeed.

> I'll start paying much less attention to any new features and enhancements
> and shift the focus almost entirely on trivial fixes and regressions from
> now on.  Hopefully lists will do the same and we can have a fairly short
> rc period this cycle.  Please remind if there are patches that ought to be
> in 1.7.4 but are forgotten.

I noticed that my rebase refactoring patches are no longer in pu. Is
this (the above) why? They were not mentioned in the previous "What's
cooking" either, even though they were in pu at that time. It is not
quite clear to me which topics are mentioned in "What's cooking" and
which are not. I see that not all topics in pu right now are mentioned
in today's "What's cooking" either.

Regards,
Martin
