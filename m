From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Command-line options that lack documentation
Date: Thu, 21 Jul 2011 22:18:27 +0200
Message-ID: <4E288993.3030005@web.de>
References: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Nikolai Weibull <now@bitwi.se>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjzhf-0007m6-7F
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1GUUSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 16:18:34 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33791 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab1GUUSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 16:18:34 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 81BB3195EF754;
	Thu, 21 Jul 2011 22:18:27 +0200 (CEST)
Received: from [217.249.50.206] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QjzhT-0006jr-00; Thu, 21 Jul 2011 22:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX189z5ql6VS4rpaSetoHspeoBamUjYVHODhvO5nN
	LCfJsHELKE0Rmt3VPo6HChsI7UrVR/ScZDRmnCYDa3PeepXXC5
	fB3jnSXsMv77OM/5M8AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177619>

Am 21.07.2011 14:07, schrieb Nikolai Weibull:
> Hi!
> 
> The following options lack (full) documentation in the manual pages:

<snip>

> git-submodule update:
>   --init

"--init" is documented in the synopsis and under the "init" and "update"
commands. The only shortcoming is that the "--init" option isn't quoted
properly and thus doesn't get decorated like other options in the html
pages, is that what you mean?
