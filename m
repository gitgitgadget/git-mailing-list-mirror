From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: TopGit release?
Date: Wed, 15 Dec 2010 15:54:28 +0100
Message-ID: <AANLkTi=E2H8n8jZPQ0Rz5gxaQTeLtJXeCFFZv08dip0E@mail.gmail.com>
References: <87ei9k42v5.fsf@write-only.cryp.to>
	<20101215080148.GA28971@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Simons <simons@cryp.to>, git@vger.kernel.org,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:02:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSssV-0007on-0P
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0LOPCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 10:02:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33488 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab0LOPCp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 10:02:45 -0500
Received: by gyb11 with SMTP id 11so1068171gyb.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ryEgMX2PTRn7mwWHOMyhEde+s75m/3kGZiKptKYjt40=;
        b=lZEm5bE6VRryBhnoKSCrak6uo9YRBJq8qSb420DBYmDR1BqRL77Y/h93FxQT/RaU0D
         /PNoA03r7nY6Fhaq7+c/XE5yucKqOJZMQMi4zy+BoOOkVwMsfTi5ZOqq6UrRjUaizFVw
         D22e68C33Bte2CAKJ6GLPDDgiWV/NPWuqQorg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VXBc6UBYV+lb0FknpgpD1NPvPNygHJ48zpGDEokfV4QkU0ZuKS/vsflxgF9Hhg3/p2
         pHEMWRC2Zz16I3KMWzZsCq3jagE/mTNEyaeX4T2qD9QCzWVNUvM5N8AClMamzvEzsjs8
         noCo9iUiauysQy56aW9s5uytVqlyxUuxWpxb4=
Received: by 10.42.171.138 with SMTP id j10mr1812909icz.492.1292424868202;
 Wed, 15 Dec 2010 06:54:28 -0800 (PST)
Received: by 10.42.167.74 with HTTP; Wed, 15 Dec 2010 06:54:28 -0800 (PST)
In-Reply-To: <20101215080148.GA28971@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163756>

2010/12/15 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Tue, Dec 14, 2010 at 07:37:50PM +0100, Peter Simons wrote:
>> I was wondering whether there's a chance that we'll have a new relea=
se
>> of TopGit in the foreseeable future? Version 0.8 seems to be quite o=
ld
>> by now, but still there's no observable progress in getting a new
>> version tagged. Is this project still alive?
> There are a few patches pending, but I currently don't find the time =
to
> go through and apply them[1]. =C2=A0Moreover I hardly use topgit anym=
ore.
> So if someone with interest in topgit wants to step forward to help t=
his
> would be very appreciated.
>
> Best regards
> Uwe
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/159433
> =C2=A0 =C2=A0hint to Bert: this series doesn't apply to master

I know, you applied a patch, which was rendered obsolete with this
patch series. you commited on Nov 02, and I send the series Oct 20.

Bert

> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Uwe Kleine-K=C3=B6nig =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
