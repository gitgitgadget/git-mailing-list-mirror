From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Replace remaining git-* calls in git stash
Date: Wed, 22 Jul 2009 15:35:01 -0700
Message-ID: <7vtz14bb3e.fsf@alter.siamese.dyndns.org>
References: <1248206777-6984-1-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1248206777-6984-2-git-send-email-mkoegler@auto.tuwien.ac.at>
 <20090723070810.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:35:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkPH-0007a6-M2
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbZGVWfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZGVWfN
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:35:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZGVWfM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:35:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01033E41D;
	Wed, 22 Jul 2009 18:35:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CF60E41C; Wed, 22 Jul 2009
 18:35:02 -0400 (EDT)
In-Reply-To: <20090723070810.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu\, 23 Jul 2009 07\:08\:10 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA7932A8-770F-11DE-AA63-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123809>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Martin Koegler <mkoegler@auto.tuwien.ac.at>:
>
>> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
>> ---
>
> Thank you. Even though 'git blame' says I am not responsible for these two (I AM responsible for the one in your other patch)...
>
> Acked-by: Nanako Shiraishi <nanako3@lavabit.com>

Thanks.
