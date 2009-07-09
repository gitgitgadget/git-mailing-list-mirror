From: Junio C Hamano <gitster@pobox.com>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 09 Jul 2009 09:43:38 -0700
Message-ID: <7vskh53iyt.fsf@alter.siamese.dyndns.org>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
 <m3my7evhky.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 18:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwiy-0003DF-KP
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316AbZGIQnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757792AbZGIQnp
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:43:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZGIQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:43:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C1FE02680A;
	Thu,  9 Jul 2009 12:43:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1714326809; Thu, 
 9 Jul 2009 12:43:39 -0400 (EDT)
In-Reply-To: <m3my7evhky.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed\, 08 Jul 2009 17\:13\:57 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA26DB8C-6CA7-11DE-A183-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122990>

Jakub Narebski <jnareb@gmail.com> writes:

>         one = show -s --pretty='format:%h (%s)'

If you use "git one" for quoting a commit in the log message, please use a
format that shows the date as well (I think I posted mine to the list in
the past).
