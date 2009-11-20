From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] gitk: add --no-replace-objects option
Date: Fri, 20 Nov 2009 22:15:11 +0100
Message-ID: <200911202215.11974.chriscool@tuxfamily.org>
References: <20091120194046.4469.53971.chriscool@tuxfamily.org> <200911202142.39520.chriscool@tuxfamily.org> <7v1vjsx6f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 22:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBamu-0002Qp-NQ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 22:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbZKTVMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 16:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbZKTVMw
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 16:12:52 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55197 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbZKTVMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 16:12:52 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 33909818174;
	Fri, 20 Nov 2009 22:12:49 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4D1BA818050;
	Fri, 20 Nov 2009 22:12:47 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vjsx6f5.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133381>

On vendredi 20 novembre 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> >> I wonder if this switch deserves run-time flippability, though...
> >
> > The following patch in master added run-time flippability to many
> > commands:
>
> What I meant was not that.  I was wondering if the user wants to flip
> from the gitk GUI without restarting gitk.

Ah ok, yes this would be nice. But anyway I think the current patch is a 
first good step.

Thanks,
Christian.
