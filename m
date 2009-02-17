From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH] Re: Minor grammar fix in the 'Not a git repository' message
Date: Tue, 17 Feb 2009 01:17:47 +0100
Message-ID: <20090217001747.GA23278@vidovic>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de> <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de> <7vd4diez2z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDgM-0007Yf-Qo
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbZBQAR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbZBQAR5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:17:57 -0500
Received: from out2.laposte.net ([193.251.214.119]:1290 "EHLO out1.laposte.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751047AbZBQAR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:17:56 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8212.laposte.net (SMTP Server) with ESMTP id E89487000089;
	Tue, 17 Feb 2009 01:17:47 +0100 (CET)
Received: from ? (91-164-142-20.rev.libertysurf.net [91.164.142.20])
	by mwinf8212.laposte.net (SMTP Server) with ESMTP id 933277000087;
	Tue, 17 Feb 2009 01:17:47 +0100 (CET)
X-ME-UUID: 20090217001747602.933277000087@mwinf8212.laposte.net
Content-Disposition: inline
In-Reply-To: <7vd4diez2z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrtddtucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecuucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110267>


On Mon, Feb 16, 2009 at 03:33:56PM -0800, Junio C Hamano wrote:

>     "No git repository ".git" found here nor in any of the parent directories"

What about bare repositories ? 

The message
	"Not inside a git repository" 
of Wincent looks like the clearest and the fairest one.

-- 
Nicolas Sebrecht
