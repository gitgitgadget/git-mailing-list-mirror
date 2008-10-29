From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: Some updates to refspec documentation
Date: Wed, 29 Oct 2008 21:44:12 +0100
Message-ID: <874p2vb083.fsf@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
	<878ws7b0d2.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:45:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHv1-0004BX-OD
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYJ2UoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbYJ2UoP
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:44:15 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:38936 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbYJ2UoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:44:14 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 6AC4814062
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 21:44:15 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 440171405A
	for <git@vger.kernel.org>; Wed, 29 Oct 2008 21:44:15 +0100 (CET)
In-Reply-To: <878ws7b0d2.fsf@cup.kalibalik.dk> (Anders Melchiorsen's message of "Wed\, 29 Oct 2008 21\:41\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99414>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> While this is indeed documented, you cannot blame somebody for
> thinking that a left out <src> will default to HEAD, as it does for
> so many other commands.

I actually think that <src> defaulting to HEAD would be reasonable,
but it is probably less reasonable to change the meaning at this
point.



Anders
