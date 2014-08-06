From: Bruce Ferrell <bferrell@baywinds.org>
Subject: Re: Apple violating git LGPL?
Date: Wed, 06 Aug 2014 12:53:56 -0700
Message-ID: <53E287D4.1050106@baywinds.org>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com> <20140806184304.GB21254@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Robert P Fischer <rpf2116@columbia.edu>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF7dt-000238-3z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbaHFUQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:16:56 -0400
Received: from 50-196-187-251-static.hfc.comcastbusiness.net ([50.196.187.251]:35105
	"EHLO rr-iv.baywinds.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaHFUQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:16:55 -0400
X-Greylist: delayed 1365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Aug 2014 16:16:55 EDT
Received: from [192.0.2.130] (rr-iii.baywinds.org [192.0.2.130])
	by rr-iv.baywinds.org (8.14.5/8.14.5/SuSE Linux 0.8) with ESMTP id s76JruVh031878;
	Wed, 6 Aug 2014 12:53:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140806184304.GB21254@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254901>

On 08/06/2014 11:43 AM, Jeff King wrote:

snippage here 8< >8
> As it happens, though, they _do_ modify the git that they distribute. I know at least that they bake-in the osxkeychain helper config in away that the user cannot turn off. There 
> may be more changes, but I haven't done a full diff. And they do provide the source: https://www.opensource.apple.com/source/Git/
Is that a plugin?  if not what about proprietary plugins? How are they affected by the license is this case?
