From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] allow '%d' pretty format specifier to show
 decoration
Date: Wed, 20 Aug 2008 13:21:10 -0700
Message-ID: <7vzln7phe1.fsf@gitster.siamese.dyndns.org>
References: <20080820175325.GD27773@sigill.intra.peff.net>
 <20080820180034.GB32005@sigill.intra.peff.net>
 <alpine.LNX.1.10.0808202138340.4070@pollux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:22:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuCE-0003Ic-Hg
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYHTUVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbYHTUVS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:21:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbYHTUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:21:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B250D537D1;
	Wed, 20 Aug 2008 16:21:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0C15C537D0; Wed, 20 Aug 2008 16:21:12 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0808202138340.4070@pollux> (Michael Dressel's
 message of "Wed, 20 Aug 2008 21:51:18 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AE30986-6EF5-11DD-B01A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93032>

Michael Dressel <MichaelTiloDressel@t-online.de> writes:

> I use it in a script to extract the log title of commits between certain
> tags.

"git shortlog"?
