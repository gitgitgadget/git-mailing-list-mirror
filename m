From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fixes for ActiveState Perl
Date: Sun, 20 Feb 2011 12:58:26 +0100
Message-ID: <AANLkTimWXSTe0DCQQRqgw8z2OVqiu+tdJrp20emdWVpk@mail.gmail.com>
References: <4D5914C1.9050008@io.com> <AANLkTimCXEbzZnR1k32u942hjB37nThN_RDBL5N7owHa@mail.gmail.com>
 <4D5984DD.1030004@io.com> <AANLkTimb2puTjj=DDqJcshwSVgqebhS9__jHoY1KdO_7@mail.gmail.com>
 <4D5A6847.90804@io.com> <4D5D2B95.2060506@io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: rkitover@io.com
X-From: git-owner@vger.kernel.org Sun Feb 20 12:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr7wX-0004Fp-Hp
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 12:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab1BTL7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 06:59:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63644 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1BTL7H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 06:59:07 -0500
Received: by gyh20 with SMTP id 20so574866gyh.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 03:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/FNSRY8mckFWPfvcA/YuIO6sdO7Ss/jm4HEGUE6sHF8=;
        b=JLjp/l7sLUIkqRdVXQJqVuCpA92cXVI2DP1JJeRHev+jpPRcpUC7mdvTgB5xtki9TM
         RfJPMhVymwXgU3i83NK1mENZVGs+py+pea7USA5eiArPgEf0a92xti94IjOlVvtUt/7W
         Qpu8G1v7jLtuurtHgRM3cyAP08cxJPn7+UeMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lmEvCVeCoYQYnI/OTMhsW0mSBjAJdc0GbPKqwSpHQgSR9OqIpRNGcyJosSan83Bnet
         P2xQe2F8aEet0LQfaxU+HDfdcLaoKBO4gzhMhvVy/rqhvSoIRBvC3wG6kwAxzdDPGJwu
         VEF99QX1thBHS5zOWzBiElXcVQ8s52myisp5E=
Received: by 10.150.95.17 with SMTP id s17mr300601ybb.362.1298203146124; Sun,
 20 Feb 2011 03:59:06 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Sun, 20 Feb 2011 03:58:26 -0800 (PST)
In-Reply-To: <4D5D2B95.2060506@io.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167418>

Heya,

On Thu, Feb 17, 2011 at 15:07, Rafael Kitover <rkitover@io.com> wrote:
> I put a lot of work into this patch...what do I do with it now?

Step one would be to keep those who are interested  cc-ed. If they
agree that the new version is sound, cc Junio to have it merged to
next.

-- 
Cheers,

Sverre Rabbelier
