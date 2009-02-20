From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand explanation of the use of + in git push refspecs.
Date: Thu, 19 Feb 2009 21:10:47 -0800
Message-ID: <7veixtk814.fsf@gitster.siamese.dyndns.org>
References: <20090219180258.2C7983360A6@rincewind>
 <bd6139dc0902191020i787e56a7tbe88cedfc2cb4028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 06:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNiF-0001zU-9g
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbZBTFK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbZBTFK6
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:10:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZBTFK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:10:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A52369B91A;
	Fri, 20 Feb 2009 00:10:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5D1A59B918; Fri,
 20 Feb 2009 00:10:48 -0500 (EST)
In-Reply-To: <bd6139dc0902191020i787e56a7tbe88cedfc2cb4028@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu, 19 Feb 2009 19:20:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D99BAB6C-FF0C-11DD-94C3-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110791>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> +       branch.  *This can abandon commits in the origin repository.*
>
> I liked your wording with the commits becoming dangling better.
>
>> +That is, commits A and B would belong to an unreachable branch without a
>> +symbolic name.
>
> Perhaps it would be better to say those commits "would no longer
> belong to a branch with a symbolic name, and thus become unreachable"?

I agree with you on both counts.
