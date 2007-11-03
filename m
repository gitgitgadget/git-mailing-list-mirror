From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Make git-blame fail when working tree is needed and
	we're not in one
Date: Sat, 3 Nov 2007 13:30:31 +0100
Organization: glandium.org
Message-ID: <20071103123031.GA7425@glandium.org>
References: <1194092575-7133-1-git-send-email-mh@glandium.org> <1194092575-7133-2-git-send-email-mh@glandium.org> <1194092575-7133-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 13:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoIAB-0000OC-Fd
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbXKCMbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbXKCMbW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:31:22 -0400
Received: from vawad.err.no ([85.19.200.177]:49604 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbXKCMbV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:31:21 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoI9l-0002Tf-Tj; Sat, 03 Nov 2007 13:31:20 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoI91-0001wz-7E; Sat, 03 Nov 2007 13:30:31 +0100
Content-Disposition: inline
In-Reply-To: <1194092575-7133-3-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63257>

Oops, I forgot -n to format-patch. Wasn't there a proposal to have -n
automatically set when outputing several patches ?

Mike
