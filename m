From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: fetch --tags --no-tags
Date: Thu, 06 Nov 2008 04:55:13 +0100
Message-ID: <20081106045513.5jk23p2a8cck8kkg@www.elpauer.org>
References: <20081106044206.az9hgqffqccgo4gk@www.elpauer.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-15;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 04:56:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxvyl-0005Ml-F3
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 04:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbYKFDzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 22:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752902AbYKFDzF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 22:55:05 -0500
Received: from server7.vnpages.net ([64.182.139.33]:55699 "EHLO
	server7.vnpages.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbYKFDzE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 22:55:04 -0500
Received: from localhost ([127.0.0.1]:55697)
	by server7.vnpages.net with esmtpa (Exim 4.69)
	(envelope-from <pgquiles@elpauer.org>)
	id 1Kxvxi-0002oG-4x
	for git@vger.kernel.org; Wed, 05 Nov 2008 19:55:14 -0800
Received: from 81.35.100.228 ([81.35.100.228]) by www.elpauer.org (Horde
	MIME library) with HTTP; Thu, 06 Nov 2008 04:55:13 +0100
In-Reply-To: <20081106044206.az9hgqffqccgo4gk@www.elpauer.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server7.vnpages.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - elpauer.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100213>

Quoting Pau Garcia i Quiles <pgquiles@elpauer.org>:

> Hello,
>
> Why doesn't 'git fetch --tags --no-tags' not return an error?

One too many negations in that sentence :-)

Just in case the question was not clear: "why does 'git fetch --tags  
--no-tags' not return an error?"

>
> It looks like it does nothing and, in fact, allowing --tags and
> --no-tags seems a contradiction to me!
>
> Thank you.
  majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
