From: "Andreas Jellinghaus [c]" <aj@dungeon.inka.de>
Subject: Re: [PATCH] debian/ binary package dependency fix. [u]
Date: Mon, 25 Jul 2005 10:52:37 +0200
Message-ID: <200507251052.37618.aj@dungeon.inka.de>
References: <7vackbz9g5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 11:10:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwyyW-0002fz-HA
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 11:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGYJKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 05:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVGYJKH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 05:10:07 -0400
Received: from quechua.inka.de ([193.197.184.2]:4055 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261155AbVGYJKF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 05:10:05 -0400
Received: from dungeon.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1DwyyK-0002rW-00; Mon, 25 Jul 2005 11:10:04 +0200
Received: from simulacron (localhost [127.0.0.1])
	by dungeon.inka.de (Postfix) with ESMTP id 7C80C20FCC;
	Mon, 25 Jul 2005 10:51:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.7.2
In-Reply-To: <7vackbz9g5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

rsync should be Recommended: or Suggested: only,
as git can be used local only as well, and then
rsync is not needed, right?

Regards, Andreas
