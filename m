From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 6/6] revert: Simplify passing command-line arguments around
Date: Sun, 9 Oct 2011 10:14:12 +0800
Message-ID: <CALUzUxo=xN735+=Yz9eS_VSW3fpiTeng9s-66qM0Jno40-DPXQ@mail.gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
	<1318095407-26429-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 04:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCizC-0004cq-PP
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 04:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab1JICOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 22:14:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40715 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab1JICON convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 22:14:13 -0400
Received: by bkbzt4 with SMTP id zt4so6696737bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 19:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oYOFIc94WjoZedArO5c+azRN4eLQSoqr1jEK+38b9FI=;
        b=ERz8xlfre5mZPUe0xbG7DufiwkVTb9XVNDu1IyhMWX+5X701uxAyooC70LS/PeXTJP
         jC1Ggob86S6LfbOeq0NzQrOuKlriMW9LJJnC0s+TQ2w7V7wR4QZxMyTydnfpUtrCpwz6
         Ry4HcSbFEe1vE+XJ9tyLe4bNm+TnLLSUGasR8=
Received: by 10.223.64.65 with SMTP id d1mr21767583fai.32.1318126452057; Sat,
 08 Oct 2011 19:14:12 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Sat, 8 Oct 2011 19:14:12 -0700 (PDT)
In-Reply-To: <1318095407-26429-7-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183181>

On Sun, Oct 9, 2011 at 1:36 AM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> [snip]
> [rr: minor improvements, commit message]

This "[]" could go below, under the 3-dash (but before the stat):

> [snip]
> ---
> =A0builtin/revert.c | =A0 53 +++++++++++++++++++++++++++++-----------=
-------------
> =A01 files changed, 29 insertions(+), 24 deletions(-)

--=20
Cheers,
Ray Chuan
