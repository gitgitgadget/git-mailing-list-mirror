From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this
	version of git
Date: Fri, 7 Dec 2007 08:22:04 -0800
Message-ID: <20071207162204.GB25490@old.davidb.org>
References: <87hciv7jkt.fsf@osv.gnss.ru> <Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de> <87d4ti7qu1.fsf@osv.gnss.ru> <7vodd23i1v.fsf@gitster.siamese.dyndns.org> <20071207161919.GA25490@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Junio C Hamano <gitster@pobox.com>, Sergei Organov <osv@javad.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 17:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0fyE-00084X-Es
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbXLGQWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 11:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbXLGQWK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 11:22:10 -0500
Received: from mail.davidb.org ([66.93.32.219]:44610 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbXLGQWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 11:22:09 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J0fxk-0006kn-KG; Fri, 07 Dec 2007 08:22:04 -0800
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Sergei Organov <osv@javad.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071207161919.GA25490@old.davidb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67435>

On Fri, Dec 07, 2007 at 08:19:19AM -0800, David Brown wrote:

> Or, git gets installed out of path in its own tree, and then the 'git'
> executable itself is symlinked somewhere into the path.  I know this
> happens, because this is what IT ended up doing.

   This is what IT ended up doing, where I work.

I haven't run into the problem this patch fixes because the strange
out-of-path git is the only version of git available on the systems.

Dave
