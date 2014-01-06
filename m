From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: [PATCH v2] git-svn: workaround for a bug in svn serf backend
Date: Mon, 06 Jan 2014 16:51:03 +0100
Organization: FutureLAB
Message-ID: <52CAD0E7.2050606@futurelab.ch>
References: <20131226202805.GV20443@google.com>	<1388131515-3015-1-git-send-email-rkagan@mail.ru>	<20131227200708.GD20443@google.com>	<20131227203443.GA9189@dcvr.yhbt.net>	<7veh4yj5mm.fsf@alter.siamese.dyndns.org> <CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:24:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CyZ-0007eR-9L
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbaAFQYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:24:22 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:60841 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461AbaAFQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:24:21 -0500
X-Greylist: delayed 1987 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2014 11:24:20 EST
Received: from astricker.futurelab.ch (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id s06Fp3Pe003418;
	Mon, 6 Jan 2014 16:51:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CANiYKX4fjYYRneqPxFDmpPg7e5ge9-hNktBvXVLQ=JxtM56tAQ@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240024>

Hi Roman

>>>   git-svn: workaround for a bug in svn serf backend (2013-12-27 20:22:19 +0000)
> Thanks!

Well thanks to you for finding and fixing this bug that really annoyed
me just before Christmas again. Your bug analysis proved my observation
that even a fresh checkout (as I suggested in my last message) didn't
fix this issue.

And thanks to the reviewers too. Awesome!

~Andy
