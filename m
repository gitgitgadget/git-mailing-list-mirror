From: Ray Lee <ray@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 18:43:11 -0700
Organization: http://madrabbit.org/
Message-ID: <1113874991.23938.113.camel@orca.madrabbit.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	 <20050418122011.GA13769@abridgegame.org>
	 <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:39:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhhq-00016q-7y
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDSBnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDSBnO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:43:14 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:16101 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261257AbVDSBnM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 21:43:12 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id C01D14C1442; Mon, 18 Apr 2005 18:43:11 -0700 (PDT)
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-04-19 at 02:55 +0200, Juliusz Chroboczek wrote:
> > But avoiding "mv" patches would be downright silly.
> 
> Aye, that will require some metadata on the git side (the hack,
> suggested by Linus, of using git hashes to notice moves won't work).

Okay, I'm coming to believe I missed something. So, why won't it work?

Ray

