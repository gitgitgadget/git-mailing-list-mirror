From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/8] git-merge-file --ours, --theirs
Date: Thu, 26 Nov 2009 15:37:26 +0900
Message-ID: <20091126153726.6117@nanako3.lavabit.com>
References: <cover.1259201377.git.apenwarr@gmail.com> <cover.1259201377.git.apenwarr@gmail.com> <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> <7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDY0N-0004wF-JK
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbZKZGiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZKZGiv
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:38:51 -0500
Received: from karen.lavabit.com ([72.249.41.33]:35253 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbZKZGiu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:38:50 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 7064711B8FF;
	Thu, 26 Nov 2009 00:38:56 -0600 (CST)
Received: from 9854.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 9LFXUA2NKYU4; Thu, 26 Nov 2009 00:38:56 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1lND5W+W4UeF+tPKFHy/yNduzLyP+PE+N3a4X0V2aefWxm/BTqFsTIBxgWj198F3Pm2BTYhjx78/6C5HNf2M72211os9kvypIVXY9KwADF6zO78aY88nLEpMxUNSB8t2xtwoaZ2civlPZRZLm+SN0t+OyxiPsa1I/MvVbXUqMHk=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6ltdd2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133770>

Quoting Junio C Hamano <gitster@pobox.com>

> Except for parse-optification, this one is more or less a verbatim copy of
> my patch, and I think I probably deserve an in-body "From: " line for this
> [PATCH 1/8], [PATCH 6/8] and [PATCH 8/8] to take the full authorship of
> them.

Could you give an guideline to decide when to take authorship and when to
give it to others?  The above seems somewhat arbitrary to me.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
