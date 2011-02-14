From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 20:14:55 +0700
Message-ID: <AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org>
 <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
 <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com>
 <4D5906FD.7030502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miles Bader <miles@gnu.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 14:15:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoyHE-0005NB-KA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab1BNNP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 08:15:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51028 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab1BNNP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 08:15:26 -0500
Received: by wyb28 with SMTP id 28so4693919wyb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bKh8mfZgs32DbKm/VZx56CWJXP8A3nXVWmwYmn4MbMU=;
        b=vWrNiDeXUgkoyEotjnbGxdLAdAP6iiS1UGinVtmMVUgGXnmt6II5dXsRtur9ZpWA63
         xa10ZHmRmSrk9FmsFTcgsyCpKjIQuLlvB1PaailZpyNo4KUDCw5y7s6CXpWYpx2y4AIu
         r8uFFkOSkl9M6kB76OJDh3FE0xvQHfEQO4OTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MBXW04i3M+wzjQ77P1Gs5XKhiX1byv5qIFc42nif7eXPUDWYS4+MG4ikJ3LSokWdKu
         zRhjdlZdWjURr7/0FLGJVAQeGri0Is7NH4ZrRI2vl2YRT3Sr85hS1GuAN+4qL5a7/tvS
         pw2MdA1ENLQAkqqNbuos3Z2Rg9HsNfW9z2HeU=
Received: by 10.216.186.144 with SMTP id w16mr3194246wem.13.1297689325429;
 Mon, 14 Feb 2011 05:15:25 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 14 Feb 2011 05:14:55 -0800 (PST)
In-Reply-To: <4D5906FD.7030502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166707>

On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Full disclaimer: I have an alias "staged" for "diff --cached" myself...

Be careful with your fingers. There's a command named "git stage".
-- 
Duy
