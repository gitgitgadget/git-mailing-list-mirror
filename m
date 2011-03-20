From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 22:36:12 +0100
Message-ID: <vpqlj09a303.fsf@bauges.imag.fr>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
	<7vtyexv6wl.fsf@alter.siamese.dyndns.org>
	<7vpqplv65o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 22:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1QIU-0003gm-NX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 22:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab1CTVgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 17:36:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58031 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab1CTVgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 17:36:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p2KLaAUI008605
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 20 Mar 2011 22:36:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q1QIG-0007cq-FI; Sun, 20 Mar 2011 22:36:12 +0100
In-Reply-To: <7vpqplv65o.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Mar 2011 14:22:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Mar 2011 22:36:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2KLaAUI008605
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1301261771.82641@1yC1OlzATJGYZeLQVMRdXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169530>

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately
> we do not have a good way to let people who have already heard
> about the transition to squelch it yet.

How about an advice.addWithoutPath config variable to disable it?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
