From: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull gitk.git master branch
Date: Tue, 14 Dec 2010 20:07:07 +1100
Message-ID: <20101214090707.GA11890@brick.ozlabs.ibm.com>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
 <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
 <20101213210317.GA10027@brick.ozlabs.ibm.com>
 <7vy67txs7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 10:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSQr0-0006pK-3C
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757768Ab0LNJHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 04:07:19 -0500
Received: from ozlabs.org ([203.10.76.45]:39459 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab0LNJHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 04:07:17 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 316F01007D1; Tue, 14 Dec 2010 20:07:16 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <7vy67txs7p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163635>

On Mon, Dec 13, 2010 at 01:45:14PM -0800, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
> > If I apply this patch in my repo, is that going to cause problems in
> > yours?  Or, since the commit that adds this file is the head commit, I
> > could just rewind it and reapply with the lowercase name.  Do you see
> > problems with that?
> 
> Either way is fine by me, as the merge I pushed out last night is only on
> 'pu' that is advertised as unstable.

OK, I re-did the top commit using the lowercase name.  Please do a
git pull -f to get the new version of that commit.

Thanks,
Paul.
