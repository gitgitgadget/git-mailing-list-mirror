From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Thu, 9 Jul 2009 20:11:44 +0200
Message-ID: <200907092011.45302.j6t@kdbg.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> <200907082242.51495.j6t@kdbg.org> <20090708211201.GA21600@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOy6C-0004rZ-4K
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 20:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbZGISLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 14:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZGISLv
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 14:11:51 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53764 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbZGISLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 14:11:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 073D92C400C;
	Thu,  9 Jul 2009 20:11:46 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C320342787;
	Thu,  9 Jul 2009 20:11:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090708211201.GA21600@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122999>

On Mittwoch, 8. Juli 2009, Jeff King wrote:
>   2. Better error messages. This would have been much more obvious to
>      diagnose if it had said:
>
>         trace: exec("git") failed: No such file or directory
>
>      Johannes, I saw you just posted some related improvements to
>      run_command; do they improve this?

No.

-- Hannes
