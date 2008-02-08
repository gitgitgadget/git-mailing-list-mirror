From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Work around curl-gnutls not liking to be reinitialized
Date: Sat, 9 Feb 2008 00:14:01 +0100
Organization: glandium.org
Message-ID: <20080208231401.GA28920@glandium.org>
References: <alpine.LSU.1.00.0802082250550.11591@racer.site> <1202512124-28669-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 09 00:14:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNcPz-0001JL-Mv
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 00:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbYBHXN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 18:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYBHXN3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 18:13:29 -0500
Received: from vuizook.err.no ([85.19.215.103]:54168 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYBHXN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 18:13:28 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNcQH-0000wl-Qx; Sat, 09 Feb 2008 00:14:28 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNcPx-0007Xa-MV; Sat, 09 Feb 2008 00:14:01 +0100
Content-Disposition: inline
In-Reply-To: <1202512124-28669-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73171>

And I forgot to add a v3 to the title... *sigh*.

Sorry

Mike
