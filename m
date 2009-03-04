From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.2
Date: Wed, 04 Mar 2009 02:50:58 -0800
Message-ID: <7vr61d5zot.fsf@gitster.siamese.dyndns.org>
References: <7veixd7iac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 11:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeoiM-0003LW-NX
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477AbZCDKvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbZCDKvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:51:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCDKvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:51:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C2393D41;
	Wed,  4 Mar 2009 05:51:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2C6393D37; Wed, 
 4 Mar 2009 05:50:59 -0500 (EST)
In-Reply-To: <7veixd7iac.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Mar 2009 01:23:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BDBEB86-08AA-11DE-AF25-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112202>

I've pushed out only 'master' which is at v1.6.2 tonight; I also have
prepared the other integration branches, rebased js/notes as promised, and
have already rewound 'next', but it appears that I may not have my git
Wednesday tomorrow, and I'd like to do a bit more sanity checks on the
result, so the public repositories will likely to stay the same for a day.
