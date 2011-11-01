From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCHv2] Compile fix for MSVC
Date: Mon, 31 Oct 2011 19:09:27 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1110311908240.1930@bonsai2>
References: <1320088364-25916-1-git-send-email-vfr@lyx.org> <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 01:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL1vg-00010S-75
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 01:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1KAAKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 20:10:05 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:39635 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753504Ab1KAAKE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 20:10:04 -0400
Received: (qmail invoked by alias); 01 Nov 2011 00:10:02 -0000
Received: from 66-188-112-180.dhcp.mdsn.wi.charter.com (EHLO bonsai2.local) [66.188.112.180]
  by mail.gmx.net (mp070) with SMTP; 01 Nov 2011 01:10:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZhZ9oAXIZuTJwcgr1BN3IqMz2tfuJnwNOl8BUDo
	Q4PPkcw43xQIaG
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vd3dcq4s5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184547>

Hi,

On Mon, 31 Oct 2011, Junio C Hamano wrote:

> Thanks. The patch looks good from a POSIX person's point of view, and I 
> do not immediately see how this would break other variants of Windows 
> build at least from the code inspection.

As my virtual machine still ran the test suite after my latest rebasing 
merge when I left work, I could not test the MSVC stuff just yet. I wanted 
to do that tomorrow and either merge or come back with suggestions.

Ciao,
Johannes
