From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] show-ref.c: Add missing call to git_config()
Date: Thu, 04 Jul 2013 19:25:44 +0100
Message-ID: <51D5BE28.9040703@ramsay1.demon.co.uk>
References: <51BCCE98.3070201@ramsay1.demon.co.uk> <7vppvlighf.fsf@alter.siamese.dyndns.org> <51C0A939.8030200@ramsay1.demon.co.uk> <7vtxkeaq06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 20:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuoHy-0006RT-08
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab3GDS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 14:29:50 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:49984 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756657Ab3GDS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 14:29:49 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id DF73F18CABC;
	Thu,  4 Jul 2013 19:29:48 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4463718CA7E;
	Thu,  4 Jul 2013 19:29:48 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Thu,  4 Jul 2013 19:29:47 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vtxkeaq06.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229608>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Yes, I will send a v2 (soon-ish, I hope).
> 
> Ping?
> 
> No need to hurry, but just to make sure this didn't disappear from
> everybody's radar.

Yep, this is still on my TODO list.

Sorry for being tardy on these patches. :(

ATB,
Ramsay Jones
