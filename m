From: David Brown <git@davidb.org>
Subject: Re: [PATCH 1/1] diff: support making output friendlier for fine,
	grand users
Date: Wed, 29 Oct 2008 08:07:31 -0700
Message-ID: <20081029150731.GA9942@linode.davidb.org>
References: <1225257832-29086-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>, Jeff King <peff@peff.net>,
	"J.H." <warthog19@eaglescrag.net>, Sam Vilain <sam@vilain.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:41:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvD8d-0001sA-5J
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYJ2PiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYJ2Ph7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:37:59 -0400
Received: from linode.davidb.org ([72.14.176.16]:55839 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbYJ2Ph7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:37:59 -0400
X-Greylist: delayed 1824 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2008 11:37:59 EDT
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KvCdv-0002dA-H1; Wed, 29 Oct 2008 08:07:31 -0700
Content-Disposition: inline
In-Reply-To: <1225257832-29086-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99373>

On Tue, Oct 28, 2008 at 10:23:52PM -0700, Petr Baudis wrote:

>+	}
>+	else if (!strcmp(arg, "--pirate")) {
>+		printf("Arrrr!  These be yer fine changes, me 'earty!!\n");

We need to wait until Sept 19 to apply this patch, however.

David
