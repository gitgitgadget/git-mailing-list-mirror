From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify commits affected by gitk --merge
Date: Sat, 07 Feb 2009 13:45:33 -0800
Message-ID: <7vtz75udj6.fsf@gitster.siamese.dyndns.org>
References: <20090206044053.GA6831@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv17-0007vy-UK
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbZBGVpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZBGVpk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:45:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbZBGVpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:45:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B41F997FE1;
	Sat,  7 Feb 2009 16:45:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C43CD97FE0; Sat,
  7 Feb 2009 16:45:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8B59090-F560-11DD-A434-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108884>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>  	After an attempt to merge stops with conflicts, show the commits on
>  	the history between two branches (i.e. the HEAD and the MERGE_HEAD)
> -	that modify the conflicted files.
> +	that modify the conflicted files and do not exist on all the heads
> +	being merged.

I do not understand what you are trying to add here, sorry.
