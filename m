From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Tue, 13 Mar 2012 08:27:40 +0100
Message-ID: <4F5EF6EC.20008@viscovery.net>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com> <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com> <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <20120312071121.GA17269@burratino> <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 08:28:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7M9E-0004Ma-95
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 08:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865Ab2CMH1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 03:27:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19542 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab2CMH1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 03:27:48 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S7M8z-0007cw-6a; Tue, 13 Mar 2012 08:27:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C4C371660F;
	Tue, 13 Mar 2012 08:27:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192985>

Am 3/13/2012 2:55, schrieb Junio C Hamano:
> I'd hold making that judgement for a several weeks until my eyes get
> used to if I were you. I've seen that people (including myself)
> react really badly to _any_ change and make loud noises (including
> "we will never get used to this updated output, it is horrible!"),
> and then eventually get used to it as if nothing happened, and that
> happened often enough recently.

I can buy that. I won't mind reading the new lines in foreign projects,
but in at least one project I'm working in I prefer not to have these new
lines in the merge commit messages. Can it be opted-out?

-- Hannes
