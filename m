From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git-remote SEGV on t5505 test.
Date: Fri, 18 Jul 2008 02:13:37 -0700
Message-ID: <7vk5fj8shq.fsf@gitster.siamese.dyndns.org>
References: <g5osl6$4g3$1@ger.gmane.org>
 <7vsku7es3n.fsf@gitster.siamese.dyndns.org> <48802DCD.2090704@posdata.co.kr>
 <7vsku7d8ak.fsf_-_@gitster.siamese.dyndns.org>
 <7vk5fjd7x5.fsf@gitster.siamese.dyndns.org> <48805D65.1060704@posdata.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SungHyun Nam <namsh@posdata.co.kr>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:14:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJm31-0007Sj-B6
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYGRJNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbYGRJNn
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:13:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbYGRJNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:13:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A10CB2B156;
	Fri, 18 Jul 2008 05:13:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25E642B154; Fri, 18 Jul 2008 05:13:39 -0400 (EDT)
In-Reply-To: <48805D65.1060704@posdata.co.kr> (SungHyun Nam's message of
 "Fri, 18 Jul 2008 18:07:49 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D092B302-54A9-11DD-B847-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89015>

SungHyun Nam <namsh@posdata.co.kr> writes:

>> SungHyun, I did not test this patch myself (all my shells grok $() command
>> substitutions), so I won't be committing this until/unless I see a "tested
>> on system X and works fine".
>
> I tested it on Solaris and works fine. ^^

Thanks.
