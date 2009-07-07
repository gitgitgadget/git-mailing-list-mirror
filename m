From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 0/4] First set of improvements to git-svn user doc
Date: Tue, 7 Jul 2009 15:22:33 +0200
Message-ID: <20090707132233.GA6568@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1246831397-19489-1-git-send-email-ydirson@altern.org> <20090706222028.GB11043@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 15:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOAdB-0005uR-Uv
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 15:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbZGGNWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 09:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbZGGNWV
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 09:22:21 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58821 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757506AbZGGNWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 09:22:20 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id F2B41940159;
	Tue,  7 Jul 2009 15:22:12 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8824794010B;
	Tue,  7 Jul 2009 15:22:09 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 98EC41F09C; Tue,  7 Jul 2009 15:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090706222028.GB11043@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122844>

mOn Mon, Jul 06, 2009 at 03:20:28PM -0700, Eric Wong wrote:
> On a side note, what kind of machine is needed to build documentation at
> non-painful speeds these days?

Well, working myself on an nearly 10-years 1GHz machine (but still a
bipro, who do you think I am ;), I also find it quite painful, so I
just build the doc I'm working on:
 
make -C Documentation/ git-svn.html
