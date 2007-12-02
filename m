From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: v1.5.4 plans
Date: Mon, 3 Dec 2007 10:39:59 +1100
Message-ID: <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 00:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyyQA-0006Tm-In
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 00:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbXLBXkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 18:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbXLBXkA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 18:40:00 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:64393 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbXLBXj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 18:39:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2474973rvb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 15:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cgyrSqjRwxKQiXNFKsm/r6mXqzf9k7HVXytbE6eFK1c=;
        b=pLt5pFzMrqvbgCtOmktRk15t2UoMHnCcGOtbEvK+SO+uUWcrzNaHa3Qz9C89MUBAasuvo2q/u2foyLF4RX1iQb6esCGCOMBtC915oGFCNyQNWNGOx3UweEKTOzDXyNBfAvySJ0cMUl9OLhzOyrTAsSJyGw2BulmTKpebnTnM9Bk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RFbu8t5/Q3F5Be6W8kzqKjZMgTJ2yr17MDmOjLro2RhgeMiDrnEo3mSgbvNedhHvqdt9onWZbCeKO4/yEWOWQ7ktAVH9SD6qehMuvwaA9iM2pfHIbZSuNNnR4Bpt8BSIdI4JbfYqtaePaB6fHj4S+d/a0QZbVnV+KMFin5s5bqM=
Received: by 10.141.172.6 with SMTP id z6mr5301811rvo.1196638799445;
        Sun, 02 Dec 2007 15:39:59 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Sun, 2 Dec 2007 15:39:59 -0800 (PST)
In-Reply-To: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66837>

On Dec 3, 2007 9:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Please do not take this as the final decision made by the Emperor, whose
> subjects now must follow.  This is a sanity-check to see if everybody is
> on the same page.
>
> I am not the Emperor anyway ;-)
>

> Topics not in 'master' yet but should be in v1.5.4
> --------------------------------------------------
>
> I think the following should go in, along with what we already have in
> 'master':

Can we add the git-status/git-checkout relative path stuff that's
currently been sitting in 'next'? It would be a good step forward for
usability.


Dave.
