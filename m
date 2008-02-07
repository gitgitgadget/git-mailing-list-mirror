From: Mike Hommey <mh@glandium.org>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 7 Feb 2008 10:05:01 +0100
Organization: glandium.org
Message-ID: <20080207090500.GA2296@glandium.org>
References: <20080205211044.GP26392@lavos.net> <7vodatqu6w.fsf@gitster.siamese.dyndns.org> <ve51w5yb.fsf@blue.sea.net> <7vsl05p46n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN2hU-0000BW-QQ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbYBGJFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYBGJFK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:05:10 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:56572 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbYBGJFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:05:03 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1912.orange.fr (SMTP Server) with ESMTP id 2991E1C0C15D
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 10:05:02 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-42-109.w82-124.abo.wanadoo.fr [82.124.6.109])
	by mwinf1912.orange.fr (SMTP Server) with ESMTP id 00ACE1C08E05;
	Thu,  7 Feb 2008 10:05:02 +0100 (CET)
X-ME-UUID: 20080207090502386.00ACE1C08E05@mwinf1912.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JN2gn-0000so-As; Thu, 07 Feb 2008 10:05:01 +0100
Content-Disposition: inline
In-Reply-To: <7vsl05p46n.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72911>

On Thu, Feb 07, 2008 at 12:21:36AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Maybe you run a much newer Gnus, and Lars taught "C-u g" to
> unmangle them.  After all, gmane and Gnus are both his
> creations, so it _is_ possible.  But somehow I doubt it.

If that can be unmangled, what would be the purpose of mangling in the first
place ? If the mangling is any useful, it can't be unmangled. If it can, it
should just be removed.

Mike
