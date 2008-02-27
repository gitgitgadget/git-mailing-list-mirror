From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: fix In-Reply-To regression
Date: Wed, 27 Feb 2008 11:48:50 -0800
Message-ID: <7v3aretc2l.fsf@gitster.siamese.dyndns.org>
References: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com>
 <1203639364-91817-1-git-send-email-jaysoffian@gmail.com>
 <7vejb5rdpz.fsf@gitster.siamese.dyndns.org>
 <20080227111336.GA25374@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>, Len Brown <lenb@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSIj-00063F-C0
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286AbYB0TtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 14:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757297AbYB0TtL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:49:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757008AbYB0TtK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 14:49:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0256D2520;
	Wed, 27 Feb 2008 14:49:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 00289251C; Wed, 27 Feb 2008 14:48:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75294>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> I see you took the patch as=20
>
> 	0fb7fc7... send-email: fix In-Reply-To regression
>
> .  Do you consider adding it to your maint branch?

Thanks for a reminder.  Done.
