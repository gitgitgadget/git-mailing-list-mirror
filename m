From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed, 7 Apr 2010 12:52:52 -0500
Message-ID: <o2zfabb9a1e1004071052g24f91df2ra15f0c517bdd4887@mail.gmail.com>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com> 
	<1270661327-28078-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 19:53:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzZRQ-0003Dt-8F
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 19:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab0DGRxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 13:53:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:13092 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab0DGRxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 13:53:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so466514qwh.37
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=N3BF9bM/H9XOuYS91tUmRBGGqrOl1wlK56I0SFB1EXw=;
        b=LyWFizp/kl5IhRQLf5ssqtOKFlS2KaOwKRG+lP+P2NggmRfaYzpAEWufhcfd5iPl7f
         TeodHQDWBE1GOVv/C8wfIIRqVkKMKypxUdVU2jWmczR1SRCxqb7b27ThKI87CIEd66Em
         HeATWNCiZYMhqXhv9GnfkgNabtQ4gh7xLFV3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FoCmx6uUVWYBBT6C4vOeckLOxiIIOHGhSgHEcdX+LU0yWoryhluT+bOFn4+tFOtcxr
         o6LwTXQrvvFN4f5Yk/MQcAvmax+ScmugmZEDysUaTUEKRSafg5Xlpoao+O8kqrli6q9i
         PQ3SFQufL/nRPuMe2HQek5RRGdiObFWWrsnc4=
Received: by 10.224.74.3 with HTTP; Wed, 7 Apr 2010 10:52:52 -0700 (PDT)
In-Reply-To: <1270661327-28078-1-git-send-email-avarab@gmail.com>
Received: by 10.224.101.206 with SMTP id d14mr3345708qao.333.1270662794286; 
	Wed, 07 Apr 2010 10:53:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144256>

Heya,

On Wed, Apr 7, 2010 at 12:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> I'd forgotten how the Git project likes rebasing :)

It's not so much the rebasing, but your patch gets applied manually
from the mbox (meaning a different timestamp) by Junio (meaning a
different committer), who adds his S-o-b (meaning a different commit
message), so yeah, the hash is gonna change ;).

--=20
Cheers,

Sverre Rabbelier
