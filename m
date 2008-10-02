From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix two 'uninitialized value' varnings in git_tree()
Date: Thu, 02 Oct 2008 17:02:30 +0200
Message-ID: <gc2nq7$fhh$1@ger.gmane.org>
References: <20081002144602.19247.4434.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 17:08:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPio-0007bm-Ti
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbYJBPCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYJBPCu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:02:50 -0400
Received: from main.gmane.org ([80.91.229.2]:34296 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584AbYJBPCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:02:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KlPhS-0004pf-PQ
	for git@vger.kernel.org; Thu, 02 Oct 2008 15:02:42 +0000
Received: from nat.ct.ingv.it ([193.206.223.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 15:02:42 +0000
Received: from giuseppe.bilotta by nat.ct.ingv.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 15:02:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat.ct.ingv.it
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97352>

On Thursday 02 October 2008 16:50, Jakub Narebski wrote:

> gitweb: Fix two 'uninitialized value' varnings in git_tree()

Vat's a varning?

-- 
Giuseppe "Oblomov" Bilotta
