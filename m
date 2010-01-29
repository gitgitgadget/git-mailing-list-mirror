From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Questions about branches in git
Date: Fri, 29 Jan 2010 09:03:45 +0900
Message-ID: <20100129090345.6117@nanako3.lavabit.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com> <4B6201BC.9030800@web.de> <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 01:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaeLZ-0000yS-3j
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 01:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab0A2AET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 19:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595Ab0A2AET
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 19:04:19 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50444 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326Ab0A2AES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 19:04:18 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 5C14A11B868;
	Thu, 28 Jan 2010 18:04:18 -0600 (CST)
Received: from 5742.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 0DAIJL6GKPUZ; Thu, 28 Jan 2010 18:04:18 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JLg2ydkQl3X8YFx/UN5o7/M5ng9+R9jRca4Yxja/LNBwtPnPtVoJwTei4DScDtoudReqGDpy9FxktwOyNNvLhuIgT+SYZihZjDiBUFL/u3toxxPiwbGk/Ece8WPWoC+AwKD+VR9Cm/TUpSsK/YDduS5AHpJO8u2e7WYBrrbPpnw=;
  h=From:To:Cc:Subject:Date:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <69b754db1001281338l58eb4b84t5a5725de294b6cc5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138287>

Quoting Mike Linck <mgl@absolute-performance.com>

> Could anyone point me to a good book that actually describes the style
> of code management that git was intended to support?

You may want to add the result of googling 

  "Fun with" site:gitster.livejournal.com

to the list of Git documents you read. "Fork from the oldest branch" is one of the techniques Junio teaches often and many of his other techiniques are built upon.

He not just teaches useful techniques but explains a lot about the reasoning behind them in his Git book. His blog articles have similar explanations on many topics I saw in his book but not in other places. It is a useful substitute until his book gets translated to English for people who don't read Japanese.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
