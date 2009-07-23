From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: fix shallow clone when upstream revision is
	too new
Date: Wed, 22 Jul 2009 23:47:59 -0700
Message-ID: <20090723064759.GA2002@dcvr.yhbt.net>
References: <1247771532.7382.115.camel@localhost> <20090720055514.GA3229@dcvr.yhbt.net> <20090723064357.GA19062@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ka-Hing Cheung <kcheung@riverbed.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 08:48:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTs63-0006er-UR
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 08:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZGWGsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 02:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbZGWGsA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 02:48:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60231 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018AbZGWGr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 02:47:59 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id EE8AE1F78E;
	Thu, 23 Jul 2009 06:47:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090723064357.GA19062@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123851>

Eric Wong <normalperson@yhbt.net> wrote:
>  Junio: Pushed out to git://git.bogomips.org/git-svn several
>  days ago, I thought I had sent this email days ago but
>  I had to leave in a hurry and never sent it.

Wait, that patch may be botched and that's why I didn't send
before leaving the other day... Oops.

-- 
Eric Wong
