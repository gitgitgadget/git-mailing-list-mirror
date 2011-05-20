From: "George Spelvin" <linux@horizon.com>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: 20 May 2011 16:26:27 -0400
Message-ID: <20110520202627.24966.qmail@science.horizon.com>
References: <20110520202220.24482.qmail@science.horizon.com>
Cc: git@vger.kernel.org, timmazid@hotmail.com
To: johnlumby@hotmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri May 20 22:26:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNWHJ-00062n-AC
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 22:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840Ab1ETU02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 16:26:28 -0400
Received: from science.horizon.com ([71.41.210.146]:37477 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964789Ab1ETU02 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 16:26:28 -0400
Received: (qmail 24967 invoked by uid 1000); 20 May 2011 16:26:27 -0400
In-Reply-To: <20110520202220.24482.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174079>

>> I have tried gitk.  Can you or someone tell me what the colours of
>> the nodes in the top left signifies?  Specifically, a commit of mine
>> (done since all the merging I've been asking about) shows as yellow,
>> whereas all the ones prior to that show as blue.

George Spelvin wrote, in a fit of insanity:
> Nothing.  It just tries to use different colours so you can tell the
> lines apart.  But the specific colour is no more meaningful than
> shadings on a map.

Correction: What Pual Ebermann said.  I was talking about the colour
of the LINES.  I didn't read your question carefully enough.
My apologies.
