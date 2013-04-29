From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/2] mingw: rename WIN32 cpp macro to GIT_NATIVE_WINDOWS
Date: Tue, 30 Apr 2013 00:22:56 +0100
Message-ID: <517F00D0.5010103@ramsay1.demon.co.uk>
References: <517C29BE.6050002@ramsay1.demon.co.uk> <20130429051059.GC8031@elie.Belkin> <7v38u9opnk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZW-0000M4-Ul
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab3D2XdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:33:19 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51192 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932572Ab3D2XdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:14 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id F08A0384083;
	Tue, 30 Apr 2013 00:33:13 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 78F92384081;
	Tue, 30 Apr 2013 00:33:13 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:33:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v38u9opnk.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222884>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Ramsay Jones wrote:

[snip]

> While I really like seeing an unfinished topic completed by tying
> its loose ends like this patch does, it feels a bit too late for the
> cycle, especially given that we _know_ the changes still need to be
> tested on a platform that the series is expected to affect.

Yes, I suspect it is low risk, but there is no need to include it
in this cycle.

ATB,
Ramsay Jones
