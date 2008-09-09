From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/t91XX git-svn tests: run "git svn" not "git-svn"
Date: Mon, 08 Sep 2008 21:27:21 -0700
Message-ID: <7vod2yaqqe.fsf@gitster.siamese.dyndns.org>
References: <20080908190208.6117@nanako3.lavabit.com>
 <20080909015445.GB15974@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 06:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcuqp-0004UU-UO
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 06:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbYIIE1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 00:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbYIIE1e
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 00:27:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbYIIE1c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 00:27:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FE7F7926A;
	Tue,  9 Sep 2008 00:27:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 656F179269; Tue,  9 Sep 2008 00:27:23 -0400 (EDT)
In-Reply-To: <20080909015445.GB15974@yp-box.dyndns.org> (Eric Wong's message
 of "Mon, 8 Sep 2008 18:54:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D6E2B26-7E27-11DD-A0E0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95334>

Eric Wong <normalperson@yhbt.net> writes:

> Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> This replaces 'git-svn' with 'git svn' in the tests.
>> 
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> Thanks, this series is
>
> Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks, both of you.
