From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 23:48:11 +0200
Message-ID: <20080720214811.GF32184@machine.or.cz>
References: <20080720205125.GP10347@genesis.frugalware.org> <7vsku44679.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgmH-00045k-E3
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYGTVsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 17:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbYGTVsO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:48:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53412 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbYGTVsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:48:13 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 49268393B31D; Sun, 20 Jul 2008 23:48:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsku44679.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89242>

On Sun, Jul 20, 2008 at 02:05:30PM -0700, Junio C Hamano wrote:
> I could make "What's cooking" not a follow-up to the previous issue, or
> perhaps add "(volume 1.6.0, issue 28)" at the end of the Subject.

> But I think it is a good idea to change the subject when responding to one
> part of the message to say which topic your response is about.
> 
> I do not know if stripping "In-reply-to" is a great idea, though.  They
> are responses, aren't they?

I think responses to the what's cooking mails per se should certainly
have in-reply-to set properly. I'm rather wondering if there's some
specific reasons why do you keep all the "What's cooking" mails in a
single thread? If there is nothing particular, keeping each "What's
cooking" report in a separate mail might be easier on a portion of
readers. I will use break-thread now (thanks, didn't know about it!) but
the practice seems strange to me.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
