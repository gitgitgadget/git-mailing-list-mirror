From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: is gitosis secure?
Date: Sun, 18 Jan 2009 12:48:51 +0100
Message-ID: <873afgsul8.fsf@mid.deneb.enyo.de>
References: <200812090956.48613.thomas@koch.ro>
	<1228813453.28186.73.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 13:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWgu-0004C9-H7
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501AbZARMW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbZARMWY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:22:24 -0500
Received: from mail.enyo.de ([212.9.189.167]:38693 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913AbZARMWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:22:24 -0500
X-Greylist: delayed 2010 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jan 2009 07:22:24 EST
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1LOW95-0001cP-LE
	for git@vger.kernel.org; Sun, 18 Jan 2009 12:48:51 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1LOW95-0002Gs-3k
	for git@vger.kernel.org; Sun, 18 Jan 2009 12:48:51 +0100
In-Reply-To: <1228813453.28186.73.camel@maia.lan> (Sam Vilain's message of
	"Tue, 09 Dec 2008 22:04:13 +1300")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106182>

* Sam Vilain:

> Restricted unix shells are a technology which has been proven secure for
> decades now.

Huh?  Things like scponly and rssh had their share of bugs, so I can
see that there is some concern.  (And restricted shells used to be
circumvented by things like Netscape's print dialog.)
