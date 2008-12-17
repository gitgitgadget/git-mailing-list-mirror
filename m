From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 11:20:00 -0800
Message-ID: <7voczaobhb.fsf@gitster.siamese.dyndns.org>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
 <20081216085108.GA3031@coredump.intra.peff.net>
 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
 <alpine.DEB.1.00.0812170003540.14632@racer>
 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com>
 <alpine.DEB.1.00.0812170420560.14632@racer>
 <20081217101110.GC18265@coredump.intra.peff.net>
 <alpine.DEB.1.00.0812171233270.28560@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 20:21:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1xa-0002S0-HH
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 20:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbYLQTUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 14:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYLQTUM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 14:20:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYLQTUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 14:20:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 64FA51A7F4;
	Wed, 17 Dec 2008 14:20:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4DCE11A7EF; Wed,
 17 Dec 2008 14:20:01 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812171233270.28560@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed, 17 Dec 2008 12:38:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B78ECF2E-CC6F-11DD-B8D7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103372>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...  But the main point 
> still stands: you go from commit to note, not from note to commit.  And 
> this is in stark contrast to tags, where you go from tag to commit, _not_ 
> from commit to tag.
>
> That is a fundamental _difference_ between tags and notes, so that I 
> refuse to accept the notion of notes being a generalized form of tags.

Hmm, how would you explain things like "git describe" (and "name-rev")?
