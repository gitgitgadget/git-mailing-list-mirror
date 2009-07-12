From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git svn: allow uppercase UUIDs from SVN
Date: Sun, 12 Jul 2009 14:15:34 -0700
Message-ID: <7vtz1hli15.fsf@alter.siamese.dyndns.org>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com>
 <20090710033133.GA23082@dcvr.yhbt.net>
 <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com>
 <20090710203322.GA18051@dcvr.yhbt.net> <20090712185821.GA26749@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Esben Skovenborg <esskov@oncable.dk>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6Po-00043r-72
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZGLVQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbZGLVQr
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:16:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZGLVQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:16:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BF80727D4A;
	Sun, 12 Jul 2009 17:16:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F24B427D34; Sun,
 12 Jul 2009 17:15:35 -0400 (EDT)
In-Reply-To: <20090712185821.GA26749@dcvr.yhbt.net> (Eric Wong's message of
 "Sun\, 12 Jul 2009 11\:58\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CA21498-6F29-11DE-9CE0-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123158>

Eric Wong <normalperson@yhbt.net> writes:

>   Junio: pushed out to git://git.bogomips.org/git-svn along with
>          some patches I think I forgot to tell you about:

Thanks, will pull.
