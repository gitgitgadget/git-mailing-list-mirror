From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v4] Docs: git checkout --orphan: Copyedit, and s/root
 commit/orphan branch/
Date: Thu, 29 Sep 2011 16:44:05 +0000
Message-ID: <CAMOZ1BuqC4i8UVgsRt8NyKZnqp87cbcENW5g5hBXi69_Ctyscw@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <3cba6bb85bde4f96903b2b617190a2b8-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JjS-00074E-7A
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757245Ab1I2QpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:45:03 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37130 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab1I2QpC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:45:02 -0400
Received: by ywb5 with SMTP id 5so703406ywb.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uICQvxhTTVUf4Ti5E8rd2sWjdFcES6ngX3aY+f/FIFU=;
        b=P+tb1/uJJB9WhVlIUCGOz5Ab3LVdfkA3+GOz/ZvtZPhTAAE8Jd2tBveuLSP2JKAsie
         n1j+ovr/PWgqvxAWEcKSQ5bFm3UW4GCovMthLk7NfOT1y+6rs/rVrlpvF76w9NCg3r9w
         z1Kb+XnDUXBhv5058F0/RVWK3UnkG+7bu9z5A=
Received: by 10.42.28.133 with SMTP id n5mr1094021icc.77.1317314701417; Thu,
 29 Sep 2011 09:45:01 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 29 Sep 2011 09:44:05 -0700 (PDT)
In-Reply-To: <3cba6bb85bde4f96903b2b617190a2b8-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182411>

On Thu, Sep 29, 2011 at 15:44, Michael Witten <mfwitten@gmail.com> wrote:

> Subject: [PATCH v4] Docs: git checkout --orphan: Copyedit, and s/root commit/orphan branch/

Do me the kind favor of replacing:

  s/root commit/orphan branch/

with:

  s/orphan branch/root commit/
