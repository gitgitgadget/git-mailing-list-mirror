From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 23:54:40 -0800
Message-ID: <7vk58fvpa7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
 <20090127062512.GA10487@coredump.intra.peff.net>
 <alpine.DEB.1.00.0901271728130.3586@pacific.mpi-cbg.de>
 <20090128073059.GD19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5HV-0003Ol-FV
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbZA1Hyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZA1Hyv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:54:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZA1Hyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:54:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C32E1D718;
	Wed, 28 Jan 2009 02:54:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13FB91D716; Wed,
 28 Jan 2009 02:54:41 -0500 (EST)
In-Reply-To: <20090128073059.GD19165@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 28 Jan 2009 02:30:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EFDB4E86-ED10-11DD-89D2-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107501>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 27, 2009 at 05:31:02PM +0100, Johannes Schindelin wrote:
>
>> I like the patch series, well designed and concise (especially with the 
>> fixes Hannes proposed).

The series looks quite sane and clean.  Will queue once I finish wrapping
up the push with ".have" thing.
