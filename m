From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 18:54:08 +0200
Message-ID: <lo9m3f$4as$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo6tnh$p3c$1@ger.gmane.org> <53A85659.2040905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 18:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz7Vq-0007In-I8
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 18:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbaFWQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 12:54:31 -0400
Received: from plane.gmane.org ([80.91.229.3]:59823 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbaFWQya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 12:54:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wz7Vb-00078b-C9
	for git@vger.kernel.org; Mon, 23 Jun 2014 18:54:19 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 18:54:19 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 18:54:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252352>

Jens Lehmann wrote:

> Am 22.06.2014 17:45, schrieb Stephen Kelly:
>> Jens Lehmann wrote:
>> 
>>> Am 22.06.2014 16:09, schrieb Stephen Kelly:
>>> But I agree that this is suboptimal for your workflow. What about adding
>>> a "Visualize These Changes In The Submodule" menu entry for the context
>>> menu of a change in gitk just like the one git gui already has?
>> 
>> Can you tell me how to find and try that out in git gui?
> 
> Sure, you'll find that in the pop-up menu when right clicking the
> submodule summary in the diff pane (where you can choose to stage
> or unstage hunks or lines for regular files).

Thanks. I see it the feature now.
