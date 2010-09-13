From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: Is there an updated version of git-vcs-p4?
Date: Mon, 13 Sep 2010 22:18:24 +0200
Message-ID: <AANLkTi=2iHCcTM-x9_BjPLXsZuX+QaSasd7TmNiBLs6t@mail.gmail.com>
References: <AANLkTi=okJRFeBhbURB8Ez4Vb65fNdacKeko+4sx9ihy@mail.gmail.com>
	<AANLkTi=x7T+VgnC0s7L+un5UORc2LwisSF-EPrh8RAE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git mailing list <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 22:18:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvFU1-0006za-2b
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 22:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab0IMUS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 16:18:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34890 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab0IMUSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 16:18:25 -0400
Received: by gwj17 with SMTP id 17so2162144gwj.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aeVWtoVg7GJoLosP+bHLJWsaYH2Ij4jS2CPEguY3PB8=;
        b=WeSwgp2V48ttwXIpI2y7SiIgMl0BuTbCYj8bsCm1SdOyNM0v3m/CiZLHToZOJ+MT1h
         8phkl/KCByPPsqTDzo94O4CnnSfyQwENNBRAcIiRQBq0HntXPypcxTRXpo0oU+VhpfJD
         z/jpjpIxfsFQvMLZuEzs5SyigSES6snIE2PI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EV9CF3alAvRoTiBJYgylbDriWVSQ5S7RgdCm30u9b9OTX+uuP6/8uJtt3neoGiG6Eb
         QRtHUqwDaa3+BvkNBqcKPngEShKaF7jzDquQdXoUghgdrUGMFHfK7CjL/sd2KRqYNF6d
         Eb0Qks3jFSCw1r12NcWlNNU7u8UG01iX4X4Ls=
Received: by 10.150.32.20 with SMTP id f20mr932456ybf.320.1284409104448; Mon,
 13 Sep 2010 13:18:24 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Mon, 13 Sep 2010 13:18:24 -0700 (PDT)
In-Reply-To: <AANLkTi=x7T+VgnC0s7L+un5UORc2LwisSF-EPrh8RAE0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156126>

On Mon, Sep 13, 2010 at 8:53 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> The export capability that is now in git is different from the one
> Daniel sketched initially. It's not really done for prime time anyway
> (see my email to Shawn about it not working). If you're interested in
> working on the git remote-helper infrastructure, let me know, and I
> can tell you more about how it works in #git-devel on freenode.net for
> example :).

Hi! Yeah, well I'm interested in getting it to work, and I'm happy to
do smallish patches and testing. But my C knowledge is basic'ish (as
in - used it a bit at school, almost never after that), and my
knowledge of the git core code is almost non-existant :-/

But shoot away, and I'll try and see if I get a feel for it :)

I'll hang out at #git-devel (as torarvid).

See you there :)

-Tor Arvid-
