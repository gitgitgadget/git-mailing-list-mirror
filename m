From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit.template
Date: Fri, 26 Dec 2008 15:44:37 -0800
Message-ID: <7v8wq2lcwq.fsf@gitster.siamese.dyndns.org>
References: <20081227070232.6117@nanako3.lavabit.com>
 <87tz8qsgn2.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: nanako3@lavabit.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGMPK-0002K0-C0
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 00:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbYLZXot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 18:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYLZXot
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 18:44:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbYLZXos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 18:44:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BC328ACDE;
	Fri, 26 Dec 2008 18:44:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 59A868ACDD; Fri,
 26 Dec 2008 18:44:39 -0500 (EST)
In-Reply-To: <87tz8qsgn2.fsf_-_@jidanni.org> (jidanni@jidanni.org's message
 of "Sat, 27 Dec 2008 06:42:09 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C90D374-D3A7-11DD-A261-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103961>

jidanni@jidanni.org writes:

> NS> Didn't you mean "Signed-off-by: 積丹尼 <jidanni@jidanni.org>"?
>
> No. I want in fact just to use "Signed-off-by: jidanni@jidanni.org",

That won't fly well, provided if you want your patches in git.git tree.
