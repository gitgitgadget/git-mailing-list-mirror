From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
Date: Tue, 23 Oct 2007 18:29:38 -0400
Message-ID: <20071023222938.GE1115@fieldses.org>
References: <20071014142938.d722299c.chriscool@tuxfamily.org> <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkSG6-0003zq-Eb
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 00:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXJWW3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXJWW3p
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 18:29:45 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41366 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbXJWW3o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 18:29:44 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IkSFm-0002QG-Nh; Tue, 23 Oct 2007 18:29:38 -0400
Content-Disposition: inline
In-Reply-To: <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62166>

On Tue, Oct 23, 2007 at 03:13:12PM -0700, Junio C Hamano wrote:
> Sort of offtopic, but is "factorise" a correct verb here?  I
> thought "factorise" is to express a non prime number as the
> product of prime numbers.

"Factor" is a perfectly good verb on its own, no need for the "ise"
normally.

--b.
