From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Google Summer of Code 2012
Date: Tue, 20 Mar 2012 18:44:54 +0100
Message-ID: <201203201844.55155.jnareb@gmail.com>
References: <001636c5c21b02c35904bba0ff9a@google.com> <201203201637.10417.jnareb@gmail.com> <7v62dz6v5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Andr=C3=A9_Walker?= <andre@andrewalker.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA37t-00068f-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 18:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab2CTRpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 13:45:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:42661 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab2CTRo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 13:44:59 -0400
Received: by wejx9 with SMTP id x9so274852wej.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qop4F/81GathqIgOaZx8GwjOutWZXHCJChSD9ti1B5g=;
        b=lPf1qiC+WbgbaULHovssLM7mR8brJkMXEw00hPCLUh8FfpkRAEAuXv9UTuNu1f9OVG
         GBhMOfCczoR2hCCL3+fV1ASv/9qOBC0Ap88uB6T3vzNzMw5/WRacCxhWTeqxM2CKcaQg
         Hkp0Ar4P5Fp/hJfk/c6ISQISx8jkklMYtToCTLg05I/VGAZ0GHjcbFlbo0z1H1mnbab6
         Fn+r46sBaI4OD4Rzm2B2w/i7Z5zWJ5SY5knjen3Q6rlFwsKn6vGLzzhg5tYldeu4Immf
         RMFV4eBDkxqJJh8yWHcADfb+orLv6P4wQIajm6OFX4+PnD2LHEGSB1YMuSdgq1hRa8mX
         KjHg==
Received: by 10.180.80.9 with SMTP id n9mr1855495wix.4.1332265498387;
        Tue, 20 Mar 2012 10:44:58 -0700 (PDT)
Received: from [192.168.1.13] (abwt72.neoplus.adsl.tpnet.pl. [83.8.243.72])
        by mx.google.com with ESMTPS id o2sm9031774wiv.11.2012.03.20.10.44.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 10:44:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62dz6v5c.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193524>

On Tue, 20 Mar 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > On Tue, 20 Mar 2012, Andr=C3=A9 Walker wrote:
> >
> > > Hello Jakub, I tweeted to you, but as your last tweet was from Ja=
nuary, I'm =20
> > > guessing here [personal email via Google Profile] is probably a b=
etter
> > > place to talk.
> >
> > Actually the discussion of GSoC project application ideas with ment=
oring
> > organization[1] should take place in the open, on git mailing list,
> > git@vger.kernel.org.  (You don't need to be subscribed to send emai=
l to
> > it, and there is custom on this mailing list of Cc-ing all people
> > participating in discussion; you can read git mailing list via othe=
r
> > interfaces e.g. via GMane.)
>=20
> The parenthesized part applies to general audience but not to GSoC
> students, I would think. Isn't the participation in the mentoring
> community mandatory for them?

Perhaps being subscribed to git mailing list, and participating in
#git or #git-devel IRC channel (and perhaps also #gsoc channel) is
mandatory for GSoC students (though I think if it is so it should
be stated clearly in materials such as SoC-2012-Template application
template)...

=2E..but is it required also for _prospective_ (would-be) students?=20

--=20
Jakub Narebski
Poland
