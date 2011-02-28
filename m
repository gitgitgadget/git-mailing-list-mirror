From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 11:03:02 +0100
Message-ID: <4D6B72D6.3060201@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>	<4D68D630.9000608@drmicha.warpmail.net>	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>	<4D6B5D09.8010806@drmicha.warpmail.net>	<vpqwrkkpkea.fsf@bauges.imag.fr>	<4D6B6F97.8030409@drmicha.warpmail.net> <AANLkTikpYAFpj8ciqkgbEyQWiphy3FVQKAW+_+mz--V_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Mon Feb 28 11:06:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzzp-0000Ga-T4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab1B1KGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 05:06:25 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40633 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188Ab1B1KGY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 05:06:24 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 39258203AF;
	Mon, 28 Feb 2011 05:06:24 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 05:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=U5fGdHOESFQIV3s+EjgZM6bnemI=; b=VY1SiXvyvdVYhPdjZK2A4wdV6IQ/wxzriowJ3WQjHNch6h4qmKOvfewu6kU/BnyaOHInDkPpX2eZdkjVP1OSQ7P3UxqKHn+bCO7iLHsOLI0NwDKei8UQHaMSjk6coBdN5HmOv1TSzUV41MJbFDKOVJ03F4cxEoPRSzPyQ8L0mA0=
X-Sasl-enc: U72Rqb11ZCWuDp88wOpd5AW48ixJkOvU2FrLo+C7cT/f 1298887583
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4EEC34485F2;
	Mon, 28 Feb 2011 05:06:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTikpYAFpj8ciqkgbEyQWiphy3FVQKAW+_+mz--V_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168095>

Tor Arntsen venit, vidit, dixit 28.02.2011 11:01:
> On Mon, Feb 28, 2011 at 10:49, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> No no, I said "add" would default to what "-u" does now (see below).
> 
> add -u adds untracked files. An explicit operation by the user. I hope
> you really don't mean that just 'git add' would add all untracked
> files? That would cause a terrible mess if someone just enters 'git
> add' (which they could very well do in other situations than just
> after 'git init', there are many casual git users out there.)

Please, go read what (thread) you're replying to, then reply. I'm not
responsible for other people cutting my posts and turning around the
rest. (Also, you are wrong about "add -u".)

Michael
