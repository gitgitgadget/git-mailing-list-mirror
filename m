From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: add a double quiet option to hide git commits
Date: Wed, 01 Apr 2009 22:24:55 -0700
Message-ID: <7vk563k4pk.fsf@gitster.siamese.dyndns.org>
References: <49CFCD5A.1080801@simon.arlott.org.uk>
 <20090329224324.GB20675@dcvr.yhbt.net>
 <7vvdprjyrc.fsf@gitster.siamese.dyndns.org>
 <49D1100D.8010206@simon.arlott.org.uk> <20090331065231.GA32142@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Arlott <simon@fire.lp0.eu>, git@vger.kernel.org,
	mdpoole@troilus.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpFRn-00040T-6M
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 07:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbZDBFZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 01:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbZDBFZG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 01:25:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbZDBFZD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 01:25:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EB78B61D;
	Thu,  2 Apr 2009 01:25:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B10DDB61B; Thu, 
 2 Apr 2009 01:24:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D595B18-1F46-11DE-B630-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115441>

Eric Wong <normalperson@yhbt.net> writes:

> Simon Arlott <simon@fire.lp0.eu> wrote:
>> People may expect/prefer -q to still show git commits,
>> so this change allows a second -q to hide them.
>> 
>> Signed-off-by: Michael Poole <mdpoole@troilus.org>
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>
> Thanks,
>   Acked-by: Eric Wong <normalperson@yhbt.net>
> and pushed out to git://git.bogomips.org/git-svn

Thanks, and pulled.
