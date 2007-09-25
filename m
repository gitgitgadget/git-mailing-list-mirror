From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] gitweb: Fixes and improvements related to diffs
Date: Tue, 25 Sep 2007 15:16:59 -0700
Message-ID: <7vodfq4ch0.fsf@gitster.siamese.dyndns.org>
References: <8fe92b430709211431m7a93a11cp915988a57801edd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaIiT-00026G-AO
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbXIYWRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbXIYWRG
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:17:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXIYWRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:17:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B6073133FDD;
	Tue, 25 Sep 2007 18:17:22 -0400 (EDT)
In-Reply-To: <8fe92b430709211431m7a93a11cp915988a57801edd6@mail.gmail.com>
	(Jakub Narebski's message of "Fri, 21 Sep 2007 23:31:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59179>

"Jakub Narebski" <jnareb@gmail.com> writes:

> This series of patches adds fixes, simplifications and improvements
> related to diff handling in gitweb ('commit', 'commitdiff' views).
>
> Becaus I didn't have access to Internet, this series is based
> on 1e61b7640d09015213dbcae3564fa27ac6a8c151 (v1.5.3.1-1-g1e61b76).
> As I am sending it via GMail WWW interface, patches are send as
> attachements.
>
> I send this series now, even without good Internet access,
> because it contains two bugfixes, and one code fix. I'll try to
> resend it rebase on top of current master later...

I've parked the first two in 'master' and was hoping to roll
them into 'maint'.  I haven't taken a look at the other three as
I was waiting for a resend.  If you think some of them are
bugfix material for 'maint', please mark them as such.

Thanks.
