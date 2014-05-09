From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH v1 18/25] contrib: remove 'emacs'
Date: Fri, 09 May 2014 16:50:00 +0200
Message-ID: <87d2fnropz.fsf@wine.dyndns.org>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
	<1399597116-1851-19-git-send-email-felipe.contreras@gmail.com>
	<CAFcZeCqbF54-KjHU1R3pC6XgWi21KcpRGB7HcbfSGyvTScQU2A@mail.gmail.com>
	<536c91f079e71_2bf0e952f0a@nysa.notmuch>
	<CAFcZeCo5mCfnUN1uBiaZnD6DL6y8hPhK5MPts5raLCTGwJX9Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri May 09 17:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimPQ-0003Xv-CU
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbaEIPIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 11:08:20 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:47705 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaEIPIU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 11:08:20 -0400
X-Greylist: delayed 1088 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 May 2014 11:08:19 EDT
Received: from xdsl-188-155-88-142.adslplus.ch ([188.155.88.142] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <julliard@winehq.org>)
	id 1Wim7j-00082T-ML; Fri, 09 May 2014 09:50:09 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 20B15204431; Fri,  9 May 2014 16:50:00 +0200 (CEST)
In-Reply-To: <CAFcZeCo5mCfnUN1uBiaZnD6DL6y8hPhK5MPts5raLCTGwJX9Gg@mail.gmail.com>
	("David =?utf-8?Q?K=C3=A5gedal=22's?= message of "Fri, 9 May 2014 10:42:51
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248566>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> 2014-05-09 10:29 GMT+02:00 Felipe Contreras
> <felipe.contreras@gmail.com>:
>
>     David K=C3=A5gedal wrote:
>     > What problem does this removal solve?
>    =20
>    =20
>     Please do not top post.
>    =20
>     a) What problem does it solve by staying?
>     b) Where are the tests?
>     c) Why it cannot be moved to an outside repository like may other
>     git-related tools?
>
> Fair enough. I guess the target should rather be to get it into the
> emacs distribution.

It's already in Emacs in a different form, as part of the generic VC
support. And nowadays, users are probably better served by using
something like Magit anyway. As far as my code is concerned I have no
objections to removing it.

--=20
Alexandre Julliard
julliard@winehq.org
