From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: What's cooking in git.git (Jun 2016, #02; Mon, 6)
Date: Tue, 7 Jun 2016 10:55:20 +0000 (UTC)
Message-ID: <loom.20160607T124159-111@post.gmane.org>
References: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:00:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAEkG-0004Yn-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbcFGLAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:00:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:46688 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932502AbcFGLAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bAEju-0004K2-Bk
	for git@vger.kernel.org; Tue, 07 Jun 2016 13:00:06 +0200
Received: from bl13-157-91.dsl.telepac.pt ([85.246.157.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:00:06 +0200
Received: from vascomalmeida by bl13-157-91.dsl.telepac.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:00:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.246.157.91 (Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296625>

Junio C Hamano <gitster <at> pobox.com> writes:

> * va/i18n-even-more (2016-05-26) 22 commits
>  - t5523: use test_i18ngrep for negation

[snip because of gmane]

>  - i18n: advice: mark string about detached head for translation
>  - i18n: builtin/remote.c: fix mark for translation
> 
>  More markings of messages for i18n, with updates to various tests
>  to pass GETTEXT_POISON tests.
> 
>  Is everybody happy with this version?

I'm not. I've re-rolled this series, adding more patches on top of these and
have changed, for instance, patch "i18n: advice: mark string about detached
head for translation" which is the second one from down.
Also, I'm going to send yet another re-roll today (v4).
