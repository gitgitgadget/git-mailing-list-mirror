From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Sat, 14 Nov 2009 22:14:03 +1100
Message-ID: <19198.37115.314162.750365@cargo.ozlabs.ibm.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 12:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Gga-0000Dr-Ev
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 12:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061AbZKNLUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 06:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbZKNLUo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 06:20:44 -0500
Received: from ozlabs.org ([203.10.76.45]:54597 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbZKNLUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 06:20:37 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 67ABAB7B65; Sat, 14 Nov 2009 22:20:41 +1100 (EST)
In-Reply-To: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132869>

Sitaram Chamarty writes:

> This prevents a lot of detached HEAD commits by new users.
> 
> Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>

Thanks, applied.

Paul.
