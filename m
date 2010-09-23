From: Joe Perches <joe@perches.com>
Subject: Re: threaded patch series
Date: Thu, 23 Sep 2010 02:05:38 -0700
Message-ID: <1285232738.31572.6.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: matt mooney <mfmooney@gmail.com>, kernel-janitors@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
To: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 23 11:05:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyhkW-0004t0-54
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 11:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab0IWJFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 05:05:42 -0400
Received: from mail.perches.com ([173.55.12.10]:2273 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab0IWJFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 05:05:41 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 7A28A24368;
	Thu, 23 Sep 2010 02:05:38 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156860>

On Thu, 2010-09-23 at 10:55 +0200, Julia Lawall wrote:
> I made some changes to git-send-email to get it to send mail to different 
> people, ie a different set of addresses for each patch.  Is that now 
> possible with the standard version?  If not I can submit a patch with my 
> changes at some point.

I believe it's not currently possible to have
different "to:" addresses in a git send-email
patch series and that could be a useful patch
to submit.
