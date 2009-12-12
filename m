From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/3] commit/status: "git add <path>" is not necessarily how to resolve
Date: Sat, 12 Dec 2009 18:19:25 +0900
Message-ID: <20091212181925.6117@nanako3.lavabit.com>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com> <1260608523-15579-2-git-send-email-gitster@pobox.com> <1260608523-15579-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 10:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJO9W-0008JG-4k
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbZLLJUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758094AbZLLJUZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:20:25 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39395 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbZLLJUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:20:24 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 3333D11B883;
	Sat, 12 Dec 2009 03:20:29 -0600 (CST)
Received: from 1073.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id YLKYMOMGHB0U; Sat, 12 Dec 2009 03:20:29 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=6Awn+SZVebA5S6AOmQf1sg75ymoZeCqY3h1nCnPDcVMHkcquHJXQafj9sDFPquB5QbVXzfGKgQMBYVfoi8rYVuHEtpOW9TROaO/lwlxqZTUe7jT9Qy1fvvKVQ7Ha9aV8bmZGahLCTyMY+09vAaGYmcR9jSBlLXQV/5ivCxg/K5M=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1260608523-15579-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135131>

Quoting Junio C Hamano <gitster@pobox.com>

>  # On branch side
>  # Unmerged paths:
>  #   (use "git reset HEAD <file>..." to unstage)
> -#   (use "git add <file>..." to mark resolution)
> +#   (use "git add/rm <file>..." as appropriately to mark resolution)

Shouldn't this either be "as appropriate" or just "appropriately"?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
