From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/3] git-gui: update russian translation
Date: Wed, 19 Jan 2011 10:55:46 +0100
Message-ID: <AANLkTimy6C=Ts3FZwm3EMhMssx605u6ubHyPXPfuO_0V@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<eeaaba6d48de958b374cb06f1b12db3b8e0550ea.1295295897.git.raa.lkml@gmail.com>
	<20110117210855.GD27029@blimp.localdomain>
	<20110119001644.GB29212@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 10:55:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfUlc-0001KE-T5
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 10:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1ASJzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 04:55:48 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35361 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1ASJzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 04:55:47 -0500
Received: by fxm20 with SMTP id 20so664331fxm.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ad+mTTaX4la4TKKL0dbPwmRS1o/6yALn9aZV6GITHU=;
        b=BnmCO66Gf7pBlDEfMWAoO3DoPZKp3oNs61Py1DkukYuxlrJfnCVfRGUlWfnEOPcFv6
         1wBmmdHzSIOEh1eZZiUoqWxX3E6HOeWsuG5HVp0URDBv4Ph5rhXkzad6j9aIEqGY+YgB
         up7/61yBmHhIW2AE/UBjg7obmr24LNsiYyTCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KgEaS+i021p/leT+A5RyeU8Zl+33pPBjJTc1o6IKdE97WUUMxLQg8xflrnFW+7073B
         BKR5BzeevTcKMFcnl0QH/+d8RvDnpTbtQtpjIIA+xj1vZGoVnsu4Jy8jIav9/aRtD/9x
         3/FN00kmH28D94ffVP2WmTfApF2Mvl6RvDrxg=
Received: by 10.223.114.135 with SMTP id e7mr494743faq.78.1295430946179; Wed,
 19 Jan 2011 01:55:46 -0800 (PST)
Received: by 10.223.72.14 with HTTP; Wed, 19 Jan 2011 01:55:46 -0800 (PST)
In-Reply-To: <20110119001644.GB29212@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165252>

MjAxMS8xLzE5IERtaXRyeSBQb3RhcG92IDxkcG90YXBvdkBnbWFpbC5jb20+Ogo+IE9uIE1vbiwg
SmFuIDE3LCAyMDExIGF0IDEwOjA4OjU1UE0gKzAxMDAsIEFsZXggUmllc2VuIHdyb3RlOgo+PiAt
IzogZ2l0LWd1aS5zaDoxMzY3Cj4+ICsjOiBnaXQtZ3VpLnNoOjE0NTQKPj4gwqBtc2dpZCAiQ2Fs
bGluZyBwcmVwYXJlLWNvbW1pdC1tc2cgaG9vay4uLiIKPj4gwqBtc2dzdHIgItCS0YvQt9C+0LIg
0L/RgNC+0LPRgNCw0LzQvNGLINC/0L7QtNC00LXRgNC20LrQuCDRgNC10L/QvtC30LjRgtC+0YDQ
uNGPIHByZXBhcmUtY29tbWl0LW1zZy4uLiIKPgo+ICdob29rJyBpcyB1c3VhbGx5IHRyYW5zbGF0
ZWQgYXMgJ9C/0YDQvtCz0YDQsNC80LzQsCDQv9C10YDQtdGF0LLQsNGC0LAnCj4KCkR1bm5vLiBE
b2VzIG5vdCBzb3VuZCByaWdodCBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZS4KVW5sZXNzIHNvbWVv
bmUgZWxzZSBzcGVha3MgdXAgZm9yIHRoaXMgdHJhbnNsYXRpb24sIG9yCmNvbWVzIHVwIHdpdGgg
YSBiZXR0ZXIgdHJhbnNsYXRpb24gb2YgdGhlIHdob2xlIG1lc3NhZ2UsCkkgc3VnZ2VzdCB3ZSBs
ZWF2ZSBpdCBhcyBpcy4K
