From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v5)
Date: Sat, 6 Jun 2009 09:12:13 +0800
Message-ID: <be6fef0d0906051812j241e78feo1df31d0d244f1b4f@mail.gmail.com>
References: <20090605235959.f4df6457.rctay89@gmail.com>
	 <m3zlcm5s7g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Clemens Buchacher <drizzd@aon.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkSL-0006da-H3
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbZFFBMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZFFBMM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:12:12 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:60301 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZFFBML convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:12:11 -0400
Received: by pxi40 with SMTP id 40so309368pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FVu6YyGrkpUBbcCZGVvPV5iubn7Gnhefvz5uU1+csO0=;
        b=ks5U9NSHYfMPBqJtyZSanjmvPjLT9CH1ffyx9LL/xnrpWLdAOgzIpPsL931o2sZRaw
         wsTBXCf/zK64MVjPW7iIYvWHCWcqCsB47KulkJI7w+rmeYewxWRjBfOlMckxoSNa6nc2
         +JZFGMGZpXt9QK6NHAcQ7PB9K7IbLF3aWI/I8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ba9OHCvHug4D+vCyQvdjuhoBwYfLb8LiP8/bxbe2Cc62CMs/znY3M4oXawpjwNpYTQ
         eErrKkfxwhmHitan2v0rTXb4dFpX/VWVhRz4p2b6Q9uv5yLUaIGOvaPBr2mGybDSPVDO
         QPTPLBa8akbElj6UxlPVvnmjOw6e8R2OLQYrs=
Received: by 10.142.102.18 with SMTP id z18mr1513710wfb.66.1244250733592; Fri, 
	05 Jun 2009 18:12:13 -0700 (PDT)
In-Reply-To: <m3zlcm5s7g.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120858>

Hi,

On Sat, Jun 6, 2009 at 4:41 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> Could you please make all patches in this series to be replies to thi=
s
> cover letter ('shallow' threading)? =A0This way it would be easier to
> read this patch series (or kill / ignore it as a whole)?
>
> Thanks in advance

I'll keep that in mind.

> P.S. Why subject is "Re: [PATCH 00/23] ..." and not "[PATCH 00/23] ..=
=2E"?

Hmm, I've checked gmane and elsewhere, the subject says "[PATCH 00/23].=
=2E."...

--=20
Cheers,
Ray Chuan
