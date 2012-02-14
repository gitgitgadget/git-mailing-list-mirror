From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Wed, 15 Feb 2012 00:36:44 +0200
Message-ID: <CAMP44s1adDHvDVCBpPGUb5YpwyLkqB8LcqjAou4b2EzJL7kmYQ@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<CAMP44s3YRHgMPX2Hzydm_TLB27OABWETjABMcwrHmDk-=pN2hw@mail.gmail.com>
	<20120214211552.GA9651@burratino>
	<CAMP44s1mV2cE=R49qYSLd8eZPhCpRx0hRnnG_-K3iBxp_YQEpQ@mail.gmail.com>
	<20120214222128.GA24544@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:36:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQzS-00047v-QC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab2BNWgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:36:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46248 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932081Ab2BNWgp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:36:45 -0500
Received: by lagu2 with SMTP id u2so463489lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dVFhmw6cKWzL+aGe7skH9J1k+G+Q3/3BDT9u+TFOpAo=;
        b=LtJ9C2Jl/6HBmEcDjFopHMpbZVvTyi7Wg1ctCjNBbon5NRBOxlbmZZ2GJirta08OqB
         spUmzYcEV0XO/vgyvJXRZLR3HXpfYYepfzL9QKn0ZMXTF6zMyLZi0HE0gwCDusOsuKeO
         wrXHSPh5Fc9ZE4tyBg45IRYq5bfyR6jdFYbuQ=
Received: by 10.112.28.169 with SMTP id c9mr7942846lbh.42.1329259004061; Tue,
 14 Feb 2012 14:36:44 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:36:44 -0800 (PST)
In-Reply-To: <20120214222128.GA24544@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190786>

On Wed, Feb 15, 2012 at 12:21 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Now I have offered some suggestions for improving some of your
> patches. =C2=A0Applying these suggestions would be effortless, since =
I sent
> them in patch form. =C2=A0What is your response? =C2=A0You send a poi=
nt-by-point
> rebuttal explaining how each detail of my suggestions is bad, bad,
> bad, and then resend the original with comparatively small changes.

That's a difference of opinion. And I didn't say the where 'bad'; I
just didn't agree with them.

> Can you see how this might indicate a stronger difference of opinion
> than you have mentioned? =C2=A0And how a reviewer might make the mist=
ake of
> thinking his comments were unwelcome after such an experience?

Your comments are welcome. My comments back are not?

--=20
=46elipe Contreras
