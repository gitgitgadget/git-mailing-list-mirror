From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Force listingblocks to be monospaced in manpages with
	xsl
Date: Sun, 19 Aug 2007 23:45:59 +0200
Organization: glandium.org
Message-ID: <20070819214559.GA4692@glandium.org>
References: <20070819210317.GA3202@glandium.org> <20070819211438.GA3326@glandium.org> <20070819213205.GA3904@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 23:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMsbN-0002Va-89
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 23:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbXHSVqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbXHSVqZ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 17:46:25 -0400
Received: from vawad.err.no ([85.19.200.177]:44277 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbXHSVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 17:46:25 -0400
Received: from aputeaux-153-1-37-169.w82-124.abo.wanadoo.fr ([82.124.129.169] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IMsbK-0004EP-F9
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:46:26 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IMsat-0001OF-AZ
	for git@vger.kernel.org; Sun, 19 Aug 2007 23:45:59 +0200
Content-Disposition: inline
In-Reply-To: <20070819213205.GA3904@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56154>

On Sun, Aug 19, 2007 at 11:32:05PM +0200, Mike Hommey <mh@glandium.org> wrote:
> Still insert a ".ft C" before and ".ft" after, but do it in a more
> docbook-xsl'ish way.

Forget it, it fails with docbook-xsl 1.73.1...

Sorry for the noise.

Mike
