From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 09:33:08 -0500
Message-ID: <HUCQtsE3HvgGu_KDktGNx0KyijzaFKOESHnzFagEbf4erQlMxjgVNQ@cipher.nrlssc.navy.mil>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com> <1225238368-98594-1-git-send-email-dsymonds@gmail.com> <20081029003931.GA7291@sigill.intra.peff.net> <20081029010107.GB12065@leksak.fem-net> <20081029010534.GA8833@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 15:35:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvC8S-00081S-HL
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 15:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYJ2Odm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 10:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbYJ2Odm
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 10:33:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50867 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbYJ2Odm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 10:33:42 -0400
Received: by mail.nrlssc.navy.mil id m9TEX8CY017658; Wed, 29 Oct 2008 09:33:08 -0500
In-Reply-To: <20081029010534.GA8833@sigill.intra.peff.net>
X-OriginalArrivalTime: 29 Oct 2008 14:33:08.0641 (UTC) FILETIME=[43477910:01C939D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99366>

Jeff King wrote:
> On Wed, Oct 29, 2008 at 02:01:07AM +0100, Stephan Beyer wrote:
> 
>> I'm still not understanding, what it's for.
>> Usability? Because doing
>> 	git config --global alias.staged 'diff --cached'
>> is lame?
> 
> You are missing some of the context,

Yeah, it would have been nice if there was audio.
Anyone take minutes, possibly?

btw the term "staged" makes perfect sense to me, whereas "cached"
was not intuitively obvious to me.

-brandon
