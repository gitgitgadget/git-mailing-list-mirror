From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 03 Mar 2009 08:21:54 -0800
Message-ID: <7vhc2ad1b1.fsf@gitster.siamese.dyndns.org>
References: <49AD3E78.1050706@sneakemail.com>
 <20090303152333.GB24593@coredump.intra.peff.net>
 <49AD5164.8090507@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXP7-0003Sz-KS
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbZCCQWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbZCCQWF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:22:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbZCCQWC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:22:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F0353380;
	Tue,  3 Mar 2009 11:22:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C350337F; Tue, 
 3 Mar 2009 11:21:57 -0500 (EST)
In-Reply-To: <49AD5164.8090507@sneakemail.com> (Peter Valdemar =?utf-8?Q?M?=
 =?utf-8?Q?=C3=B8rch's?= message of "Tue, 03 Mar 2009 16:48:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C3D39B2-080F-11DE-BE52-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112106>

"Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> writes:

> How sad... From "git log -Sfoo" looking like a really cool feature,

It is a cool feature, but its coolness lies in the other parts of a
Porcelain that is still to be written.  See my other message.
