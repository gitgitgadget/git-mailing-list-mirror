From: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Subject: diff-tree and does not respect grafts
Date: Mon, 21 Nov 2005 12:54:39 +0100
Message-ID: <87lkzi1aio.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 21 12:55:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeAEn-0002GW-AF
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 12:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVKULxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 06:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVKULxa
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 06:53:30 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:15581 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932268AbVKULx3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 06:53:29 -0500
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jALBrIZ23179
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 12:53:23 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12439>

Hello:

        diff-tree decode directly the commit, so it does not take into
        account the graft file. Is this the expected behaviour?

        Santi
