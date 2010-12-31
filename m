From: Mike Doherty <doherty@cs.dal.ca>
Subject: Re: git rebase -i doesn't respect rebase.autosquash
Date: Thu, 30 Dec 2010 19:39:26 -0500
Message-ID: <4D1D263E.4080600@cs.dal.ca>
References: <4D1D1A38.9090305@cs.dal.ca> <alpine.DEB.1.10.1012301929221.7175@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 01:39:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYT1l-0004Bd-N8
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 01:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab0LaAjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 19:39:25 -0500
Received: from hammer.CS.Dal.Ca ([129.173.22.32]:53933 "EHLO hammer.cs.dal.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab0LaAjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 19:39:24 -0500
Received: from [10.0.1.5] (node-7061.tor.pppoe.execulink.com [67.158.75.150])
	by hammer.cs.dal.ca (Postfix) with ESMTP id 3C0A94F2B6;
	Thu, 30 Dec 2010 20:39:17 -0400 (AST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <alpine.DEB.1.10.1012301929221.7175@debian>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164376>

On 10-12-30 01:37 PM, Martin von Zweigbergk wrote:
> I also have rebase.autosquash enabled and it works for me. Does it 
> autosquash as you expect if you pass '--autosquash' on the command 
> line? Which version of Git are you running?

Yes, it does. I'm using 1.7.0.4

-Mike
