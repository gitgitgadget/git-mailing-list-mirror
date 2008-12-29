From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: some git-commands --help don't act like git commands --help
Date: Mon, 29 Dec 2008 19:29:03 +0900
Message-ID: <20081229192903.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 11:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHFPM-0006sO-US
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 11:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbYL2KaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 05:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbYL2KaK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 05:30:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:43118 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbYL2KaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 05:30:09 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id EC83AC8428;
	Mon, 29 Dec 2008 04:30:08 -0600 (CST)
Received: from 7206.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id U87CZ99FVQA8; Mon, 29 Dec 2008 04:30:08 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Jq5h+IWkUinzaJowo9itCzJ6GUP3yBUbL3dDnrwbRp4hVVMdTRwES3Z+Qjezh+VvGEJ9egN/tUtmtWs2CQMr66TznhsVk8Yr/4SEstIwbnaqAsrRm52nzVAWUDB7RwLBQ6zhzB9KIEgrejFXwccv3nX4Laaxpr+J5XpAEqelAYQ=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104095>

Quoting Junio C Hamano <gitster@pobox.com>:

> I think he is comparing "git am" and "git-am" the latter of which is now
> deprecated and largely removed from the end user.
>
> IOW, the seeming inconsistency is not an issue anymore in practice in the
> post 1.6.0 era.

Ah, I misread that distinction in the OP's message.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
