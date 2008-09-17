From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Wed, 17 Sep 2008 14:45:32 -0700
Message-ID: <18641.31356.147503.708394@cargo.ozlabs.ibm.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 23:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4uP-00038L-Pt
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbYIQVsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbYIQVsb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:48:31 -0400
Received: from ozlabs.org ([203.10.76.45]:42492 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbYIQVsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:48:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 23016DDF5D; Thu, 18 Sep 2008 07:46:02 +1000 (EST)
In-Reply-To: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96147>

Alexander Gavrilov writes:

> Currently GUI tools don't provide any support for
> viewing files that contain non-ASCII characters.

Well, that's just not true, at least as far as gitk is concerned.

If you feel there are deficiencies in how gitk handles encodings (and
I'm quite willing to believe there are, since ASCII is sufficient for
my needs), then please give us a detailed explanation of what you
would like it to do or specifically what is wrong with what it does at
the moment.  I'd like to see several paragraphs, not just the one or
two sentences you have put in the descriptions for patches 6-8.

Thanks,
Paul.
