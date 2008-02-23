From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 22 Feb 2008 16:29:30 -0800
Message-ID: <7v4pc07bx1.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802211024200.17164@racer.site>
 <47BF18DF.6050100@nrlssc.navy.mil>
 <7vhcg07hmd.fsf@gitster.siamese.dyndns.org>
 <47BF669F.4070803@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:30:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSiHr-0007rs-4p
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbYBWA3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbYBWA3r
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:29:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbYBWA3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:29:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13CD04BFF;
	Fri, 22 Feb 2008 19:29:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2F0054BF9; Fri, 22 Feb 2008 19:29:38 -0500 (EST)
In-Reply-To: <47BF669F.4070803@nrlssc.navy.mil> (Brandon Casey's message of
 "Fri, 22 Feb 2008 18:19:43 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74770>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>
>> We might need to introduce "stash push" which would be a synonym
>> for "stash pop" for symmetry.
>
> I like "stash push" if you mean _antonym_ and not _synonym_.

Heh, I obviously meant synonym "push == save", to give feeling
of symmetry between "push" and "pop", instead of "save" and "pop".
