From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix MSVC build on cygwin
Date: Fri, 09 Oct 2009 22:53:09 +0100
Message-ID: <4ACFB0C5.1040105@ramsay1.demon.co.uk>
References: <4ACE0388.6070706@ramsay1.demon.co.uk> <7v3a5t6p1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mstormo@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 20:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwgNQ-0003LY-V6
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 20:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762054AbZJJSGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 14:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762045AbZJJSGh
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 14:06:37 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48241 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762044AbZJJSGh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Oct 2009 14:06:37 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1MwgKI-0000al-ol; Sat, 10 Oct 2009 18:05:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v3a5t6p1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129894>

Junio C Hamano wrote:
> Thanks; that's quite a detailed description to explain why -DFOO-DBAR is
> bad when -DFOO -DBAR was wanted ;-)

Heh, yeah I usually have the opposite problem; often I can't spare any
words past the one-line summary...

I suspect the unusual verbosity won't last... ;-)

ATB,
Ramsay Jones
