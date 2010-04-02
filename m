From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git as backup and file sync system
Date: Fri, 2 Apr 2010 13:35:36 -0600
Message-ID: <k2mfabb9a1e1004021235xc75e25a8na941c1754fd543c@mail.gmail.com>
References: <m2q5f14cf5e1004021216y60797d29j1f63092435998823@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: turner25@gmail.com, Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 21:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmew-0003yE-QP
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab0DBTf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:35:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34888 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab0DBTf5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 15:35:57 -0400
Received: by gyg13 with SMTP id 13so1133348gyg.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YnuPD0VbyyN4Tgf70XDc1Hh93TdUIcdx6HFzIhCjPyM=;
        b=OBdu5+xeW58+pyC98LX392nAdvO6nq21pYGPFh+jGcZ4AEagbXzypPcwCcBHc7jUIA
         CAUnEH9DhnItJsLJjI6XhrF43Tq/yt56uo/TSOyXZlIH9DoTYt6EUg6FDgq4gv8Fnus/
         O+Cj0ReWuh/MyleXyUG1Eoos32XlPGglrE5YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QweppRalOUAbWhpk3YFVmZe73oKp3ZPLPQwNbdHQSQpIcX/ib1GcmRhDizPpnBN0Hd
         TcqU8qZ3i4Y14NsyeJOXCxTSUUivz2wHj95ihU3BOmnlW5G9SlySXyrKqOlR/w9E4La4
         dn607xFa7Jwbxx16nKOCoAJFkwX5ZlaJMDjt8=
Received: by 10.100.206.13 with HTTP; Fri, 2 Apr 2010 12:35:36 -0700 (PDT)
In-Reply-To: <m2q5f14cf5e1004021216y60797d29j1f63092435998823@mail.gmail.com>
Received: by 10.101.187.17 with SMTP id o17mr7040641anp.201.1270236956145; 
	Fri, 02 Apr 2010 12:35:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143844>

Heya,

On Fri, Apr 2, 2010 at 13:16, Simon <turner25@gmail.com> wrote:
> =A0I'm not sure if this post will be very welcome, but I'd like your
> feedback or suggestions. =A0I've been reading Jon Loeliger's book abo=
ut
> git and I've understood many many things. =A0I'm interested in using =
git
> as a backup and sync system between computers.

You might want to look into 'bup', [0] designed specifically for that
purpose. It seems like introduction post about it on apenwarr.ca is
down though [1].

[0] http://github.com/apenwarr/bup
[1] http://apenwarr.ca/log/?m=3D201001#04

--=20
Cheers,

Sverre Rabbelier
