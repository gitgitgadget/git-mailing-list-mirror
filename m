From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv5 0/4] Support ref namespaces
Date: Fri, 3 Jun 2011 16:48:06 -0700
Message-ID: <20110603234806.GB2170@leaf>
References: <1307136593-16306-1-git-send-email-jamey@minilop.net>
 <7v8vtia489.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSe6P-0005eK-8C
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 01:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab1FCXsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 19:48:24 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46286 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab1FCXsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 19:48:24 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 3320B17207B;
	Sat,  4 Jun 2011 01:48:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id TMquYtVc9YfK; Sat,  4 Jun 2011 01:48:21 +0200 (CEST)
X-Originating-IP: 131.252.242.54
Received: from leaf (host-242-54.pubnet.pdx.edu [131.252.242.54])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 135A1172087;
	Sat,  4 Jun 2011 01:48:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vtia489.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175042>

On Fri, Jun 03, 2011 at 04:24:06PM -0700, Junio C Hamano wrote:
> Overall the series look much more understandable than the previous one ;-)

Thanks!  And thanks for all the feedback; the namespace mechanism we've
ended up with seems a lot nicer than our originally proposed prefix
system.

- Josh Triplett
