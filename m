From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Tue, 4 Oct 2011 22:16:38 -0500
Message-ID: <20111005031638.GB10317@elie>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
 <20111003220659.GA19537@elie>
 <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
 <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Marcin =?utf-8?Q?Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 05:17:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBHyd-0005Tm-RT
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 05:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277Ab1JEDQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 23:16:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37362 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933162Ab1JEDQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 23:16:44 -0400
Received: by ywb5 with SMTP id 5so1168986ywb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yV7ZukJZnUvW4RfvTL0FwrcEjjIfvKUmNl/xfHClo/g=;
        b=cG8C11eW5VraDqkDQtmzvyh5SCWp0g1nG0IgpRp8cCaL4eIhowT71kQNn3B4pI1/QR
         NFVahWq2523PjnMx7X0LjcU9QsLrtNaIEDjmLuDFbX918fvXrkq7j1GEzIoXQ+CABzop
         Eg4R4YqbsuXmFkjeuSe67faoRFz5iPJdL+JE4=
Received: by 10.236.191.170 with SMTP id g30mr10832252yhn.110.1317784603402;
        Tue, 04 Oct 2011 20:16:43 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id s77sm368625yhe.22.2011.10.04.20.16.41
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Oct 2011 20:16:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182820>

Junio C Hamano wrote:

> I _suspect_ that Jonathan might
> have been hinting me to eject everything under the current po/ directory,
> and bind that part of the tree as a submodule from another repository,
> which would give us "git log -p" cleanliness automatically.

Hinting, in the sense that I didn't think of it at all, but I like the
idea very much.  Thanks!
