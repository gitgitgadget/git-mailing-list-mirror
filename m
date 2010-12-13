From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #04; Mon, 13)
Date: Mon, 13 Dec 2010 09:42:44 +0100
Message-ID: <AANLkTikuahTgKb84bX18m62XHN4Rskkg8_D7fxTsg7RR@mail.gmail.com>
References: <7v7hfe5awz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 09:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS401-0005SU-72
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 09:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab0LMInH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 03:43:07 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42934 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab0LMInF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 03:43:05 -0500
Received: by yxt3 with SMTP id 3so3131991yxt.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 00:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1DTNNAZ/57vDONFxkheflB/OHV4u1u9EI1UzMF7BFsM=;
        b=YmdL0dO8YGW+qPfzPKX4QZ6QHxDLc3lGBmA/U6xFek39GTVBDKeBGQ9Ra8+oHdtm5P
         Zzk2z0UxG3ci2Yh7m/n1cowJnm8Lh3oIFMWmcmK1NYMIDaHJhTPk+JBxD2X8NjM19Ww8
         JMH1usXHtj2Ieb74EuYv/DPEPZZONz3TBd2+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q5rC2edCIjhY73T4PwQtaKFgDU5c3SV3hdGcT5WRZJ2Na2BGnbxR0Qbpe+i4u8EHTC
         8nTdhjHsJy3bfh8E0sDrHYX9M9EoyU9HbAxjzZP25Ug5j0dUTxrv0ayDqF57n8OiflH9
         qpOTztXnUWocG445NBQa+uNbpTNxkdBaZHtZg=
Received: by 10.150.178.15 with SMTP id a15mr5398476ybf.382.1292229785152;
 Mon, 13 Dec 2010 00:43:05 -0800 (PST)
Received: by 10.151.150.17 with HTTP; Mon, 13 Dec 2010 00:42:44 -0800 (PST)
In-Reply-To: <7v7hfe5awz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163526>

Heya,

On Mon, Dec 13, 2010 at 09:34, Junio C Hamano <gitster@pobox.com> wrote:
> * ab/i18n (2010-10-07) 161 commits

[snip]

> It is getting ridiculously painful to keep re-resolving the conflicts with
> other topics in flight, even with the help with rerere.
>
> Needs a bit more minor work to get the basic code structure right.

Can we perhaps get this into such a shape that it can be merged to
next as the first order of business after the next release?

-- 
Cheers,

Sverre Rabbelier
