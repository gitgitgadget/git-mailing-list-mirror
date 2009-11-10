From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release
 workflow
Date: Tue, 10 Nov 2009 19:06:12 +0100
Message-ID: <20091110180612.GB12012@headley>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
 <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rocketraman@fastmail.fm
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 19:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7v6n-0004ec-7R
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbZKJSGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 13:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbZKJSGK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:06:10 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64077 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbZKJSGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 13:06:09 -0500
Received: by bwz27 with SMTP id 27so295284bwz.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MIy6eNvBe6gfvbDchWGfAibGVfuctdFK6ExfnS7ePNs=;
        b=qM+BNSHxhJyDyROpLSrsVMRGSFTyHTYuMkuQBkwRxKeEyt1zYh4nzIZAIsZBuSi6rY
         Fa5PvMSO9HHgA4NjDJYq/nrT/Ge94MQ47wCOLo+D4KwbOdv6BS8IN4SV4U9rUQ3K71QV
         ckISWW9Xp9qM1C2NUh9b8LYPwOL0eWmON4nAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=gswfZema+wmL0RhPTdZK82/8MD5CCRwYNNQrOru/CaFQQQf9FbqkNU9egZHagqx1L3
         y4+/FqNFfre/ilDNZJyDXpcpRMTBQL+QSHqbJapa+3n/pCMTumDhf2jm50LEmIZqPVGt
         DFr+22L48adtkZWWcPywmNq4tZdki+HwCGYcI=
Received: by 10.204.152.154 with SMTP id g26mr427053bkw.54.1257876374025;
        Tue, 10 Nov 2009 10:06:14 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id d13sm1463158fka.22.2009.11.10.10.06.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 10:06:13 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org, rocketraman@fastmail.fm
Content-Disposition: inline
In-Reply-To: <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132580>

On Tue, Nov 10, 2009 at 11:08:59AM -0500, rocketraman@fastmail.fm wrote=
:

A small typo:

> +'maint' should now updated to the new release code so that maintenan=
ce
> +fixes can be merged for the current version:

There is a missing `be' somewhere, something like: "'maint' should now =
be
updated..."

Regards,

=C5=A0t=C4=9Bp=C3=A1n
