From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 20:47:13 +0300
Message-ID: <87hcjq82ce.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
	<87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
	<A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrzuC-00050Z-MJ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbXKMRtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756875AbXKMRtq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:49:46 -0500
Received: from javad.com ([216.122.176.236]:2583 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755581AbXKMRtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:49:45 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADHlI038562;
	Tue, 13 Nov 2007 17:47:19 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Irzqz-0004eM-5n; Tue, 13 Nov 2007 20:47:13 +0300
In-Reply-To: <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> (Steffen Prohaska's message of "Tue\, 13 Nov 2007 18\:16\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64818>

Steffen Prohaska <prohaska@zib.de> writes:
[...]
> It doesn't make sense to delete remote-tracking branches locally if
> they are still present at the remote.  The main purpose of a
> remote-tracking branch is to be identical to the real remote branch.

But I don't want to track those real remote branch anymore, so obviously
I don't want anything that is "identical" to it, so deleting
corresponding remote-tracking branch makes perfect sense, IMHO.

-- 
Sergei.
