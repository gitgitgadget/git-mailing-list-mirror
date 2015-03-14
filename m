From: epilys <epilys@norn.io>
Subject: Re: [GSoC][PATCH v2] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 01:55:28 +0200
Message-ID: <5504CA70.2030602@norn.io>
References: <md5:Tyvg1g0l6oUcTR3FnSDstw==> <5504C533.7060304@norn.io> <20150314234718.GA612775@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, me@ikke.info, gitster@pobox.com, peff@peff.net
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Mar 15 00:54:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWvsu-0005Ef-Sp
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 00:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbCNXyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 19:54:21 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52300 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbCNXyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 19:54:20 -0400
Received: from mfilter2-d.gandi.net (mfilter2-d.gandi.net [217.70.178.140])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 26769172077;
	Sun, 15 Mar 2015 00:54:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter2-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter2-d.gandi.net (mfilter2-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id evGzTPIq8bdt; Sun, 15 Mar 2015 00:54:17 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 39D9F17208B;
	Sun, 15 Mar 2015 00:54:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150314234718.GA612775@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265468>

On 03/15/2015 01:47 AM, brian m. carlson wrote:
> It looks like you indented here with four spaces instead of a tab. 
> We prefer tabs in Git.

Messed that up. Do you think I should resubmit a v3 or am I hogging
the mailing list too much?
