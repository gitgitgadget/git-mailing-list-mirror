From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 08:28:28 +0200
Message-ID: <20080819062828.GA30750@cuci.nl>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7vtzdiklbw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181839390.19665@iabervon.org> <7vy72tit90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:29:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVKj5-0003KP-44
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 08:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbYHSG2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 02:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYHSG2b
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 02:28:31 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:45272 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbYHSG2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 02:28:30 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 05AFD5465; Tue, 19 Aug 2008 08:28:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy72tit90.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92814>

Junio C Hamano wrote:
>I do not know if I like the end result, but here is a patch to make the
>traditional a/ and b/ prefix more mnemonic.

>diff: vary default prefix depending on what are compared

>diff --git i/builtin-diff.c w/builtin-diff.c

>--- i/builtin-diff.c
>+++ w/builtin-diff.c

I consider this an improvement.
-- 
Sincerely,
           Stephen R. van den Berg.
"Papers in string theory are published at a rate above the speed of light.
 This is no problem since no information is being transmitted." -- H. Kleinert
