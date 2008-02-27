From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] send-email: fix In-Reply-To regression
Date: Wed, 27 Feb 2008 12:13:36 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20080227111336.GA25374@informatik.uni-freiburg.de>
References: <76718490802211351n1f0a6c36nb84902a624ee2120@mail.gmail.com> <1203639364-91817-1-git-send-email-jaysoffian@gmail.com> <7vejb5rdpz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>, Len Brown <lenb@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 12:14:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUKF5-0002vF-MY
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 12:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbYB0LNy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 06:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYB0LNy
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 06:13:54 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:60662 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753099AbYB0LNx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 06:13:53 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1JUKES-0005x2-DR; Wed, 27 Feb 2008 12:13:52 +0100
Received: from zeisberg by login.informatik.uni-freiburg.de with local (Exim 4.63)
	(envelope-from <zeisberg@login.informatik.uni-freiburg.de>)
	id 1JUKEC-0006bv-Ve; Wed, 27 Feb 2008 12:13:36 +0100
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>, Len Brown <lenb@kernel.org>
Content-Disposition: inline
In-Reply-To: <7vejb5rdpz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75222>

Hello Junio,

Junio C Hamano wrote:
> The patch looked Ok with my initial cursory review.  Success
> reports with Tested-by: would be appreciated.
I see you took the patch as=20

	0fb7fc7... send-email: fix In-Reply-To regression

=2E  Do you consider adding it to your maint branch?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig
