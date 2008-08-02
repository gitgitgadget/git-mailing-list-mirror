From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add ruby funcname pattern
Date: Fri, 01 Aug 2008 20:50:22 -0700
Message-ID: <7vbq0cqdmp.fsf@gitster.siamese.dyndns.org>
References: <1217488908-19692-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vmyjxtco3.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0808010111j29e2085etd58150037b55063c@mail.gmail.com>
 <7v4p65tadh.fsf@gitster.siamese.dyndns.org>
 <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 05:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP89W-0002On-9v
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 05:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbYHBDub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 23:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYHBDub
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 23:50:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYHBDua (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 23:50:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 61D7F46A81;
	Fri,  1 Aug 2008 23:50:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E1AF46A7E; Fri,  1 Aug 2008 23:50:24 -0400 (EDT)
In-Reply-To: <0C57339C-50EF-4199-A14B-AFF04C92EF87@sb.org> (Kevin Ballard's
 message of "Fri, 1 Aug 2008 17:31:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 257C23D8-6046-11DD-AECB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91130>

Kevin Ballard <kevin@sb.org> writes:

>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>> ...
>>> I wasn't sure about the completeness of the regexp myself, which is
>> ...
> As a Ruby user, the regex for the funcname looks fine to me.

Thanks, will apply.
