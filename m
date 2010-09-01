From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Wed, 01 Sep 2010 18:07:05 +0200
Message-ID: <4C7E7A29.9090003@drmicha.warpmail.net>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Sep 01 18:07:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqpqB-0005A4-Up
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 18:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab0IAQHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 12:07:05 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57035 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755263Ab0IAQHC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 12:07:02 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6EAA1449;
	Wed,  1 Sep 2010 12:07:02 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 01 Sep 2010 12:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=KmqA2x7s1xIjCJM/VXeAjLPlFC4=; b=NsGhUiA8KPaEO70XqyvuHupZmC1uR9uo3r2uhSg+firTNruFG839JbSDJiBjh0wOZ2QTSvZfwAW3frmFPOgkLUYJv6lFNuld1BZMN2bKw9yygzLDDr+rTNjIAByhgDfDk4SJ5bodaZ4z2njLFqJlBvOyG+KK446f0PE/rr1FoQI=
X-Sasl-enc: 9ysIH3QPVHVNQmHiv2dyl4T2svOWKa0oR5agsFKYQYah 1283357222
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CADBB5E358E;
	Wed,  1 Sep 2010 12:07:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155056>

Michael J Gruber venit, vidit, dixit 01.09.2010 18:02:
> 46bac90 (Do not install shell libraries executable, 2010-01-31) changed
> the executable bits of shell variables in order to avoid false reports

Umpf, s/variables/libraries/
