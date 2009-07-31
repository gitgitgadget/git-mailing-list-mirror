From: "George Spelvin" <linux@horizon.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: 31 Jul 2009 09:02:49 -0400
Message-ID: <20090731130249.27188.qmail@science.horizon.com>
References: <40aa078e0907310545k64f058b6ja936f583bdaeb120@mail.gmail.com>
Cc: git@drmicha.warpmail.net, git@vger.kernel.org
To: kusmabite@googlemail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jul 31 15:02:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrlD-0007fR-2Q
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 15:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbZGaNCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 09:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZGaNCu
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 09:02:50 -0400
Received: from science.horizon.com ([71.41.210.146]:65030 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751469AbZGaNCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 09:02:50 -0400
Received: (qmail 27189 invoked by uid 1000); 31 Jul 2009 09:02:49 -0400
In-Reply-To: <40aa078e0907310545k64f058b6ja936f583bdaeb120@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124558>

> That did the trick, thanks!
>
> Best of 6 runs on an Intel Core i7 920 @ 2.67GHz:
> 
> before (586test): 1.415
> after (x86test): 1.470

So it's slower.  Bummer. :-(  Obviously I have some work to do.

But thank you very much for the result!
