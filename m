From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Optional grouping of projects by category
Date: Wed, 03 Dec 2008 13:14:38 -0800
Message-ID: <7vabbdc669.fsf@gitster.siamese.dyndns.org>
References: <87wsei1uvp.wl%seb@cine7.net>
 <200812030036.13562.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastien Cevey <seb@cine7.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>,
	Gustavo Sverzut Barbieri <barbieri@profusion.mobi>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7z4s-0000eq-9M
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 22:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbYLCVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYLCVOv
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 16:14:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYLCVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 16:14:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 41303180A0;
	Wed,  3 Dec 2008 16:14:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C8BF51809A; Wed, 
 3 Dec 2008 16:14:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B152FEE-C17F-11DD-888A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102290>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 2 Dec 2008, Sebastien Cevey wrote:
> ...
>> I submitted a previous version of this patch on July 27, but was told
>> to wait for the end of the feature freeze.  I submitted it again on
>> September 5, but didn't get any reply.  Hope to be luckier this time!
>
> Unfortunately it looks like you hit the edge of feature freeze again.

Freeze for 1.6.1 by itself does not have to stop you or anybody to review
the patch and Ack for queuing for 'next' ;-)
