From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 20 Jul 2008 11:27:14 -0700
Message-ID: <7vmykc8l8d.fsf@gitster.siamese.dyndns.org>
References: <7vwsknyz9m.fsf@gitster.siamese.dyndns.org>
 <7vlk0z9k5f.fsf@gitster.siamese.dyndns.org>
 <7vej6oipea.fsf@gitster.siamese.dyndns.org>
 <7vabh93lk6.fsf@gitster.siamese.dyndns.org>
 <7vwsk4g5py.fsf@gitster.siamese.dyndns.org>
 <7vr6a7fhwh.fsf@gitster.siamese.dyndns.org>
 <7v1w25xfd6.fsf@gitster.siamese.dyndns.org>
 <7vmykljahl.fsf@gitster.siamese.dyndns.org>
 <7vabgiwlj5.fsf@gitster.siamese.dyndns.org>
 <7vwsjhgvtn.fsf@gitster.siamese.dyndns.org>
 <20080720112034.GA27984@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdeE-00011l-U0
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbYGTS1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbYGTS1c
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:27:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYGTS1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:27:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 02930345DE;
	Sun, 20 Jul 2008 14:27:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F2B90345DD; Sun, 20 Jul 2008 14:27:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C7B7C0E-5689-11DD-9544-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89207>

Lars Noschinski <lars-2008-1@usenet.noschinski.de> writes:

> * Junio C Hamano <gitster@pobox.com> [08-07-20 03:59]:
>>Lars Noschinski (2):
>>  cvsserver: Add support for packed refs
>>  cvsserver: Add cvs co -c support
>
> Any specific reason why you did not merge the test for packed refs
> support? Was it considered superfluous?

No, it was not even considered.  This phenomenon is called "lost in the
noise" ;-)

Thanks for reminding.  Applied.
