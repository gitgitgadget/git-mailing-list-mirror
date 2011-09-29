From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Lack of detached signatures
Date: Thu, 29 Sep 2011 16:40:54 +0200
Message-ID: <CAGdFq_h6shMp+d4f1bG=if6L11M_5ixN5JF7KgCrZJ44QBt0QQ@mail.gmail.com>
References: <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk> <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org> <20110928222542.GA18120@sigill.intra.peff.net>
 <20110928230958.GJ19250@thunk.org> <7vd3ekxkca.fsf@alter.siamese.dyndns.org>
 <20110929015919.GL19250@thunk.org> <7vbou4uhuu.fsf@alter.siamese.dyndns.org> <20110929131845.GQ19250@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Joseph Parmelee <jparmele@wildbear.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 29 16:41:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Hnx-0002FP-6b
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 16:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab1I2Olg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 10:41:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41644 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab1I2Olg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 10:41:36 -0400
Received: by gyg10 with SMTP id 10so579428gyg.19
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hIhy8biR6zRudhSzNHSXF204fCS86oOLu+2gePq/joo=;
        b=KuFtokMG9duZABje/Y9Ne5ZfgPuKr4AxYhqXqZjXCUmlqDmWdJQ2scJbbGlAjPViJX
         NCq54n0+g8WJkyVFQYIBJu78kqTDo/vNlHsgylDr8dCWmGhLosAlaVIAG1KuL536Inf3
         bwNFlLpK9LaqwVlQFAUFy4laitRmLL2AwyfOI=
Received: by 10.68.15.70 with SMTP id v6mr33669405pbc.85.1317307294058; Thu,
 29 Sep 2011 07:41:34 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Thu, 29 Sep 2011 07:40:54 -0700 (PDT)
In-Reply-To: <20110929131845.GQ19250@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182400>

Heya,

On Thu, Sep 29, 2011 at 15:18, Ted Ts'o <tytso@mit.edu> wrote:
> Handset manufacturers such as Samsung, HTC, Motorola, etc., there wil=
l
> be many of those reprsenatives at LinuxCon Europe and CELF (Consumer
> Electronics Linux Forum) Europe conferences, which will be colocated
> with the Kernel Summit in Prague.
>
> If you are thinking of random developers located in far-flung places
> of the world who don't have any contact with other Linux developers,
> this is a previously unsolved problem. =C2=A0There are links into the
> developing Kernel GPG tree that are signed by the GPG web trust used
> by Debian, OpenSuSE, and (soon) Fedora. =C2=A0Given that people gener=
ally
> have to trust one or more of those web of trusts, that's the best we
> can do, at least as far as I know. =C2=A0If you can suggest something
> better, please let me know!

This all sounds very interesting. Where is this discussion on a new
web of trust taking place? The kernel mailing list? Do you have a
message-id / gmane.org link for me to read more about this perhaps?

--=20
Cheers,

Sverre Rabbelier
