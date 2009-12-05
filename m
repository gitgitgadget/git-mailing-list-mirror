From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH RESEND] git gui: make current branch default in "remote
 delete branch" merge check
Date: Sat, 05 Dec 2009 14:19:53 +0100
Message-ID: <4B1A5DF9.70203@web.de>
References: <20091204212648.GA3979@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Dec 05 14:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGuYM-0004Ji-12
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 14:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZLENTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 08:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbZLENTu
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 08:19:50 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:36794 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096AbZLENTu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 08:19:50 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 389AF13FC2FB6;
	Sat,  5 Dec 2009 14:19:56 +0100 (CET)
Received: from [80.128.81.202] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NGuYG-0002Xr-00; Sat, 05 Dec 2009 14:19:56 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <20091204212648.GA3979@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/qO9khMLulEJ2fPNoDEabyriKmadMOIT8GILM8
	UZNpLjjEhbwR9x9IDDoPAqCIMOoazVo1CZgL8s0fWNSNABYmgf
	jFmOngQ/jLihFX4K216Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134601>

Heiko Voigt schrieb:
> We already do the same when locally deleting a branch.

+1

This is very useful in a workflow where the reviewer deletes the remote
feature branch right after merging and pushing it.


Jens
