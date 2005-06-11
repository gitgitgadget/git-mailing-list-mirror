From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Cogito: split Makefile targets of Cogito/git
Date: Sat, 11 Jun 2005 22:06:51 +0200
Message-ID: <20050611200651.GA12763MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <20050611195033.GA22713@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 22:11:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhCKC-0002Vi-7F
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 22:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVFKUPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 16:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVFKUPT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 16:15:19 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:65495 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261810AbVFKUO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 16:14:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 3B0DA33F5A
	for <git@vger.kernel.org>; Sat, 11 Jun 2005 22:14:26 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 9550733F59
	for <git@vger.kernel.org>; Sat, 11 Jun 2005 22:14:24 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 810964C0D1
	for <git@vger.kernel.org>; Sat, 11 Jun 2005 22:14:24 +0200 (CEST)
Received: (qmail 5990 invoked by uid 500); 11 Jun 2005 20:06:51 -0000
To: Kay Sievers <kay.sievers@vrfy.org>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050611195033.GA22713@vrfy.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 11, 2005 at 09:50:33PM +0200, Kay Sievers wrote:
> +.PHONY: all it cogito

I suppose this should be

+.PHONY: all git cogito

skimo
