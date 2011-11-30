From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [HELP] Adding git awareness to the darning patch management system.
Date: Wed, 30 Nov 2011 17:04:05 +0800
Message-ID: <CALUzUxrcWB62jARtgifTOocGL4gEGXDFMiO=ppHXzFyUmb+3ww@mail.gmail.com>
References: <4ED59232.3000807@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Williams <peter_ono@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5R-00057Y-2l
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090Ab1K3JEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 04:04:12 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab1K3JEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 04:04:08 -0500
Received: by bkas6 with SMTP id s6so570681bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xEYlOyRT3eQN5P8tQg0IBva0P3IoXfynJtxyCU83Ikg=;
        b=jsTo0lJXAQX4FJo094mrDi51TW0oOVNqj195k6E4yYiDHbCU8BUhWzHT54HQucsR1y
         LlfDrMWLpI+lG42TNUhTFzkulxRyRFYe8iSM35mFNe3EfCkReOiQD07cntHbh2loEN9C
         QFGxBx/G2fUOJyJYMfE6Zwju2wdw1FQrTUGpI=
Received: by 10.204.145.89 with SMTP id c25mr1311001bkv.35.1322643845254; Wed,
 30 Nov 2011 01:04:05 -0800 (PST)
Received: by 10.223.71.206 with HTTP; Wed, 30 Nov 2011 01:04:05 -0800 (PST)
In-Reply-To: <4ED59232.3000807@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186116>

On Wed, Nov 30, 2011 at 10:17 AM, Peter Williams
<peter_ono@users.sourceforge.net> wrote:
> I'm the author of the darning patch management system
> <http://darning.sourceforge.net/> and would like some help adding git
> awareness to the system. =A0At this stage of the development, "awaren=
ess" is
> fairly simple concept with two broad aims:

That link says it "combines the strengths of quilt and mq and
eliminates their weaknesses", but I don't see any info on why this is
the case with your program; it would be great it if you could provide
a quick start guide (probably easier to show this with some commands
in the CLI rather than GUI screenshots).

Have a look at StGit's tutorial
http://www.procode.org/stgit/doc/tutorial.html (very similar to quilt
and mq too) to see what I mean.

--=20
Cheers,
Ray Chuan
