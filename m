From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question  about announcing it
Date: Wed, 8 Jul 2009 03:02:28 +0200
Message-ID: <200907080302.29740.jnareb@gmail.com>
References: <200907030130.24417.jnareb@gmail.com> <40aa078e0907071716k40d6ce9cwc0f9801f4042ef3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 03:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOLYX-00030i-Be
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 03:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbZGHBCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 21:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbZGHBCe
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 21:02:34 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:60111 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbZGHBCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 21:02:33 -0400
Received: by bwz25 with SMTP id 25so2465898bwz.37
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XqtyF4ozFn8pcsaOzTEu1po2ZEG/ucp3s7rk7GK4504=;
        b=YNFkOSaPTBgT5QG4C2i4gSrHkum8JkVeragPuis/ibzcqc0NRDgXrX8qAtNPNBG3Db
         ofMNCu43pzVWuj36EbdA/Ojm1l15mnc0SrFfaNIe0xvq0affYVvKCfMoY+3fThsz7Cc+
         shIwf5knfPMueC/qVGAaj2mJ1WI2lzb8Psh14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iHdp9Lj0Bb6cavraNQZBUU5efu+2qMDnK4N+GWf+QrhenGPJRQkr3vBNreZTKgBNAD
         x3c1dlOQFlB9gaXadj5ns4ZKWJ66x5z9iJ0aewcW+YPLff6GRQU1iGXkF59TANBUnqnb
         lg8+xtT1F+G8dbqvXDU7ImyhIZfJUhebSeM2c=
Received: by 10.204.62.135 with SMTP id x7mr6338636bkh.95.1247014949951;
        Tue, 07 Jul 2009 18:02:29 -0700 (PDT)
Received: from ?192.168.1.13? (abva123.neoplus.adsl.tpnet.pl [83.8.198.123])
        by mx.google.com with ESMTPS id c28sm14806544fka.19.2009.07.07.18.02.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 18:02:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <40aa078e0907071716k40d6ce9cwc0f9801f4042ef3a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122884>

On Wed, 8 July 2009, Erik Faye-Lund wrote:
> 2009/7/3 Jakub Narebski <jnareb@gmail.com>:
> >
> > =A0 =A0* same filesystem (e.g. /path/to/repo.git or file:///path/to=
/repo.git)
>=20
> Shouldn't this be "local filesystem" or something instead? At least
> I'm using an USB-stick to take make sure I have the active branches o=
f
> some important projects I manage with me at all times (who knows when
> you'll find a computer to do some development even if you're stuck on
> some island in scotland without a laptop or whatever, right?), and I
> was a bit confused if this should be included here or in the "other,
> please specify"-section.

Yes, it should be "local filesystem" (or even "via filesystem";=20
it could have been mounted network share).  Thanks for noticing.

>=20
> For me, there was also the question of scp'd patches, but I guess
> those belong in the "other"-section.

IMHO it is no "pulling from upstream".  Anything that includes somethin=
g
other than git-fetch / git-clone / git-remote-update is of no interest
to this question.  I'll try to explain it in the comments.

--=20
Jakub Narebski
Poland
