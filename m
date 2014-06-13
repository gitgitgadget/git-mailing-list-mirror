From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/5] submodule config lookup API
Date: Fri, 13 Jun 2014 09:13:23 +0200
Message-ID: <539AA493.5030106@web.de>
References: <20140605060425.GA23874@sandbox-ub> <xmqqtx7p4wee.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:13:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLgB-0007zH-0D
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbaFMHNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:13:34 -0400
Received: from mout.web.de ([212.227.15.14]:64610 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaFMHNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:13:34 -0400
Received: from [192.168.178.41] ([79.193.74.201]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MUF4Q-1XLEYy0Nvu-00QyOB; Fri, 13 Jun 2014 09:13:30
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqtx7p4wee.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:4tNo7H3ROAYVHfQwtmsjnv7iXUDML9SOR+7AEZGTilwDanT9y0+
 PGn44pBYft1YeqosrnjaH6tlNfOI6PBvtsh5hzGJV3YLsiITZOfBco4Ywm5vPBMBP+yVsBv
 IkYHlJYfLo24+SYmS2SLtyd3E50sjp/nSFsNi3kRBsPv3MUNoc7vPpQkb2OaFortzEwa+s7
 /4rD2FDcrln5W6lIhjWig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251521>

Am 13.06.2014 00:04, schrieb Junio C Hamano:
> Hmph, this seems to conflict in a meaningful (and painful) way with
> Jens's "jl/submodule-recursive-checkout".

Then you might wanna drop my series for now, I need to rebase it
above Heiko's series myself to make new submodules work anyway.
