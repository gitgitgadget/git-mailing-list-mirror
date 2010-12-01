From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 01 Dec 2010 17:52:06 +0100
Message-ID: <4CF67D36.9020908@drmicha.warpmail.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net> <7vd3pmw9n5.fsf@alter.siamese.dyndns.org> <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net> <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com> <20101201160503.GB26120@burratino> <m3aakp4g5o.fsf@localhost.localdomain> <20101201163406.GD26120@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 17:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNpws-0007E8-3x
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 17:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab0LAQyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 11:54:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49563 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754548Ab0LAQyX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 11:54:23 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2E9893DB;
	Wed,  1 Dec 2010 11:54:23 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 01 Dec 2010 11:54:23 -0500
X-Sasl-enc: E3acYNv/7F0fgj8dypWfNaq+jF1AnO7FcucdDjx9B43L 1291222462
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E4DB4035ED;
	Wed,  1 Dec 2010 11:54:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101201163406.GD26120@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162549>

So you guys are going to break current behaviour (for "cvsimport.r" etc.)?

I hate it when simple things get held up like this. Time to go home for
today... Food deprivation makes grumpy.

Michael
