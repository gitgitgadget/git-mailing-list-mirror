From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Thu, 26 Jun 2008 00:28:50 -0700
Message-ID: <7vy74sslhp.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
 <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org>
 <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org>
 <7vod5q8c25.fsf@gitster.siamese.dyndns.org> <486342F8.2060406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 09:30:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBlvc-0006zj-P4
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 09:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbYFZH3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 03:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYFZH3E
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 03:29:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYFZH3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 03:29:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C6C8F094;
	Thu, 26 Jun 2008 03:29:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AF161F092; Thu, 26 Jun 2008 03:28:57 -0400 (EDT)
In-Reply-To: <486342F8.2060406@viscovery.net> (Johannes Sixt's message of
 "Thu, 26 Jun 2008 09:19:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B8CCA18-4351-11DD-A15D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86408>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> I'll queue the patch to 'master' and I suspect that this will make 31d6632
>> (Windows: Change the name of hook scripts to make them not executable.,
>> 2007-11-30) unnecessary.
>
> I've updated
>
> git://repo.or.cz/git/mingw/j6t.git for-junio
>
> and the interdiff to the previous version is merely the reverse of
> 31d6632. For your convenience I've merged it into current next:
>
> git://repo.or.cz/git/mingw/j6t.git merge-mingw-into-next

Thanks.  This round I am looking forward to very much being able to merge
this to 'next' for real, not just parking in 'pu', but it is getting late
so it may have to wait til tomorrow.
