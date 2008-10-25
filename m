From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sat, 25 Oct 2008 16:35:40 -0700
Message-ID: <7vzlks6yer.fsf@gitster.siamese.dyndns.org>
References: <20081025004815.GA23851@coredump.intra.peff.net>
 <20081025005256.GD23903@coredump.intra.peff.net>
 <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
 <20081025071912.GA24287@coredump.intra.peff.net>
 <7v3aika5l7.fsf@gitster.siamese.dyndns.org>
 <20081025193554.GA27457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 01:37:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktsh0-0002hT-Tl
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 01:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYJYXf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYJYXf4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 19:35:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbYJYXfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 19:35:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 647AD746EB;
	Sat, 25 Oct 2008 19:35:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2BAA4746E2; Sat, 25 Oct 2008 19:35:47 -0400 (EDT)
In-Reply-To: <20081025193554.GA27457@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 25 Oct 2008 15:35:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA974464-A2ED-11DD-AB59-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99131>

Jeff King <peff@peff.net> writes:

> I will re-roll my latest series according to your recommendation
> (unless you are set on reverting the first part; if so, please tell me
> asap so I can work under that assumption).

No, reverting and reapplying is more work than incremental updates.
Please refine on top of what's already in.
