From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Mon, 12 May 2014 14:19:14 +0200
Message-ID: <CAGK7Mr7wMAaoL1EvNoJM-vA00Q0XSHY-rk3d7Srt9N4CWDj_cg@mail.gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com> <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com> <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com> <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 14:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjpCv-0003UH-8E
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbaELMTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 08:19:46 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:48004 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbaELMTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 08:19:45 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so8067687oag.34
        for <git@vger.kernel.org>; Mon, 12 May 2014 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9qxQbczFGA8OD9rBe1nUZ/wSZDIfdosHCYu1V7nVe3w=;
        b=Mhq2OzWkgrM7MdOqR1GoRXcxmphetua6nurPBGdYtjU1eoL2XDVDP67Pn8K1du6DHH
         mgF/1wCh1dsIOztx75nOvSg9bs3/ezOmJiHC9UQPRfGl6eTRK5b7I+xNiQI40cB1rHh9
         LBdlMipfnVv2Xw2oRd1uHDVSMsHwaG662b/1d4rnJOH7MWfuYg9m0/BKg0Y/hDj0dH6K
         2oumggfNHU8TpQC+HCwk3bFuhbenEpRWykRz2FH5JwfBHDJILdID+4vz3cHTii1ad6sU
         Tyn30HkbRIcw+0/0/dHHCSLhKeghRKSauSQp9Bj/ffUdrj1Kx+FhWe8+z0MbsBjs89Zj
         bScg==
X-Received: by 10.182.28.104 with SMTP id a8mr32816883obh.30.1399897184640;
 Mon, 12 May 2014 05:19:44 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Mon, 12 May 2014 05:19:14 -0700 (PDT)
In-Reply-To: <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248702>

Nevermind, it'd be more efficient to cover this in the other main
thread started by Felipe. You can answer my questions there instead as
it'll likely benefit a wider audience.

Philippe
