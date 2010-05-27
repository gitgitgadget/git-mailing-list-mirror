From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Migrate from svn to git
Date: Thu, 27 May 2010 08:19:54 +0200
Message-ID: <4BFE0F0A.301@fechner.net>
References: <4BFD3AAF.4080403@fechner.net> <AANLkTilNlttIQxyhMJz8_wiOQX5OaL0UahsE54mv6rQ3@mail.gmail.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 08:20:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHWS6-0004nn-2p
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 08:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab0E0GUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 02:20:14 -0400
Received: from anny.lostinspace.de ([80.190.182.2]:49203 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0E0GUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 02:20:13 -0400
Received: from server.idefix.lan (ppp-93-104-103-160.dynamic.mnet-online.de [93.104.103.160])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.3/8.14.3) with ESMTP id o4R6K5hS050994
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:20:09 +0200 (CEST)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (unknown [127.0.0.1])
	by server.idefix.lan (Postfix) with ESMTP id 8A2926303
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:20:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at server.idefix.lan
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XUvfSu1uqMxq for <git@vger.kernel.org>;
	Thu, 27 May 2010 08:19:56 +0200 (CEST)
Received: from dhcp-10-27-1-64.internal.epo.org (unknown [192.168.20.6])
	by server.idefix.lan (Postfix) with ESMTPA id 9038662F0
	for <git@vger.kernel.org>; Thu, 27 May 2010 08:19:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <AANLkTilNlttIQxyhMJz8_wiOQX5OaL0UahsE54mv6rQ3@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.5 (anny.lostinspace.de [80.190.182.2]); Thu, 27 May 2010 08:20:09 +0200 (CEST)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147829>

Am 26.05.10 19:04, schrieb Nazri Ramliy:
>
> Dealing with acl sounds like a lot of work and complications to me.
> Have a look at gitolite. It is covered quite nice in the progit book [1]
>    

thanks for the link i will read the documentation to get more 
information about it, but the first look is very promising.

Matthias

-- 
"Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the universe trying to produce bigger and better idiots. So far, the universe is winning." -- Rich Cook
