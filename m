From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used
 subcommands
Date: Thu, 05 Jun 2008 14:17:16 -0700
Message-ID: <7v63sn1t0j.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
 <20080605081911.GA5946@mithlond.arda.local>
 <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
 <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Mqn-0000NM-7d
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYFEVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYFEVRc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 17:17:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbYFEVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 17:17:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43DF43E32;
	Thu,  5 Jun 2008 17:17:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6237E3E2B; Thu,  5 Jun 2008 17:17:22 -0400 (EDT)
In-Reply-To: <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl> (Pieter de
 Bie's message of "Thu, 5 Jun 2008 20:38:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDB05030-3344-11DD-A458-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83985>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On 5 jun 2008, at 20:13, Junio C Hamano wrote:
>
>> See 'man git' and 'git help' for more information.
>
> I'd like to see something more like
>
> See 'git help COMMAND' for more information on a specific command

Yeah, I think that is so far the best color of the shed I suggested
"Perhaps like this".
