From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/5] doc/checkout: split checkout and branch creation in 
	synopsis
Date: Mon, 13 Apr 2009 15:21:04 +0200
Message-ID: <fabb9a1e0904130621x64a93c80w31e769cad8c89c96@mail.gmail.com>
References: <20090413110947.GA15647@coredump.intra.peff.net> 
	<20090413111933.GD15982@coredump.intra.peff.net> <fabb9a1e0904130613g5b664706jb6a3c29107ac1fc9@mail.gmail.com> 
	<20090413131949.GA16293@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 15:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtM7i-00046T-UM
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 15:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbZDMNVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 09:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZDMNVW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 09:21:22 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54482 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZDMNVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 09:21:21 -0400
Received: by fxm2 with SMTP id 2so1986626fxm.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zXMAEas3piRebIA8oGdac6Vn9/MFq3xsPdT9v97Uy7Q=;
        b=OyR7Cn5hgPlasHC9LJ4chzFVVWXJQ3TFyAAL+ajx2SMtJKiOSoyghNsKoIY2lGdl93
         i7YYlDUSjltvse1/ULzBs9azylSnjSrtbHIWNkwCW/blEXjfpgfOGbzo5DDUTuEhc+p4
         AB10BYS9gNEKMaKlfi3idc4ncU2hofVn0Nd8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KbqKC4/GOOUayH5yAGC53IO3472mDYbUJ57//Nb1m5hsYKgcS/FxyEAZCh9Y/RQM9Z
         ArSY2o7BhNedAoVbwqHh6kAWlHzYYSFpdEWgu2fauxQzehl+sQpDHmZEsCJohtONO61g
         TIVzmXZvWqLsOpfGX0CvPSmp8kzHdz4Kc26gg=
Received: by 10.103.160.9 with SMTP id m9mr3307039muo.96.1239628879317; Mon, 
	13 Apr 2009 06:21:19 -0700 (PDT)
In-Reply-To: <20090413131949.GA16293@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116439>

Heya,

On Mon, Apr 13, 2009 at 15:19, Jeff King <peff@peff.net> wrote:
> =A0'git checkout' ... -b <new_branch> [<start_point>]
>
> The cause where "-b <new_branch>" isn't used is covered in the line
> above.

Ah, it is indeed, thatm akes it even more readable! :)

--=20
Cheers,

Sverre Rabbelier
