From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 00/23] remote-helper improvements
Date: Sat, 23 Jul 2011 13:28:00 +0200
Message-ID: <CAGdFq_h6ci03fztEe-FOzCUNmWrN_dKS8z6qcrCOrGa613R7=w@mail.gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com> <20110718032829.GA2468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 23 13:28:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkaNw-0006Mr-Pt
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 13:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190Ab1GWL2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 07:28:40 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35070 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1GWL2k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 07:28:40 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so5105924pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nmCQWL2bkqYHMiDgt/eO4zR7D+Pscoa/R6ow1at/nJs=;
        b=K04DBH5zB15THdNmtuUt/zkIdy51cVNM09vg7oX7vJUwT1IXbmsLIi1Ln4A1mLxBWQ
         OmLthWZ26Uyvuk9U2WtsHod+jxU2QgGbVHO8eLwz9GNWL+Qqgdr3RHpXv+df5qNl+Cz4
         CiehhGI0n9k1zM1iSNY4ieovp6g7CtlayIYmo=
Received: by 10.68.19.66 with SMTP id c2mr78716pbe.109.1311420520035; Sat, 23
 Jul 2011 04:28:40 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Sat, 23 Jul 2011 04:28:00 -0700 (PDT)
In-Reply-To: <20110718032829.GA2468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177688>

Heya,

On Mon, Jul 18, 2011 at 05:28, Jeff King <peff@peff.net> wrote:
> The patches up to 21 (i.e., not the RFD ones) all made sense to me. At
> least, the goals from the commit messages looked sane, and the patches
> seemed to implement the goals reasonably.

Thanks for reviewing :).

-- 
Cheers,

Sverre Rabbelier
