From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sat, 19 Jul 2008 23:52:53 -0700
Message-ID: <7vprp9f3ne.fsf@gitster.siamese.dyndns.org>
References: <20080719174742.GA4253@2ka.mipt.ru>
 <7vfxq521ab.fsf@gitster.siamese.dyndns.org>
 <7v8wvx211n.fsf@gitster.siamese.dyndns.org>
 <20080719195909.GA5093@2ka.mipt.ru>
 <7v8wvxzg97.fsf@gitster.siamese.dyndns.org>
 <20080720064137.GA9654@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-From: git-owner@vger.kernel.org Sun Jul 20 08:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKSoF-0004Ol-8X
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 08:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYGTGxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 02:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYGTGxD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 02:53:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYGTGxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 02:53:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3AD83CE70;
	Sun, 20 Jul 2008 02:52:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 133F33CE6F; Sun, 20 Jul 2008 02:52:55 -0400 (EDT)
In-Reply-To: <20080720064137.GA9654@2ka.mipt.ru> (Evgeniy Polyakov's message
 of "Sun, 20 Jul 2008 10:41:38 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7CFC6136-5628-11DD-AC3F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89165>

Evgeniy Polyakov <johnpol@2ka.mipt.ru> writes:

> On Sat, Jul 19, 2008 at 03:00:20PM -0700, Junio C Hamano (gitster@pobox.com) wrote:
>> > I posted it so it would be stored in archive, that old enough git
>> > version does not work with recent trees, so one should upgrade if this
>> > error occures.
>> 
>> Thanks, but you are about 5 days too late ;-)
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=88402
>
> Better late than never :)

You should have said "better redundant than never", though ;-)
