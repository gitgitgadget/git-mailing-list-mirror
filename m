From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Tue, 18 Jan 2011 08:48:06 +0100
Message-ID: <AANLkTikpDb_NvQJXGiUgggjx8C9t0nzDitJeseGFpC=b@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
	<loom.20110118T083048-91@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 18 08:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf6IX-00009g-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 08:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab1ARHsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 02:48:09 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36273 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab1ARHsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 02:48:08 -0500
Received: by fxm20 with SMTP id 20so6897801fxm.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xNAJh6MC4RIjLAUOkAW9jE+NYmqsKEN87zSsCkoB7LQ=;
        b=pcZlyW9euOPLo7M69KDFrz2naAYKa3YlBoK2hV0e8/uIzlifC6D89KtvwWiIrYxaIV
         WbAZUQce71E9O3Y3nDMlYwKN0SCyUrdWIRlBTkQG96JG+2b4yJxuTJv0zAelLvDiZfnY
         ZVvEum7nqX8+9k1jSqzjHSHJMUa7GHT0O/9+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V07CJPCWo973ZllpAhLYomFa76Aqp4sh/qZ697c2YkdQmSdU2jZN0R+chDNXQitFmb
         DD+DzTsO5TkkgY5isRxkE5zW9rotcKpHkBO7d7wKAW5z4Tw4L/jK88Q3ubr+8SSruq2V
         iruZ0FER4hU6FTVTzU4M+Wkk31n1gIApc3Dic=
Received: by 10.223.113.131 with SMTP id a3mr5804791faq.135.1295336886103;
 Mon, 17 Jan 2011 23:48:06 -0800 (PST)
Received: by 10.223.72.14 with HTTP; Mon, 17 Jan 2011 23:48:06 -0800 (PST)
In-Reply-To: <loom.20110118T083048-91@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165193>

MjAxMS8xLzE4IEFsZXhleSBTaHVta2luIDx6YXBwZWRAbWFpbC5ydT46Cj4gY2hhbmdlIHRoaXMK
Pj4gwqAjLCB0Y2wtZm9ybWF0Cj4+IMKgbXNnaWQgIkZpbGUgJXMgc2VlbXMgdG8gaGF2ZSB1bnJl
c29sdmVkIGNvbmZsaWN0cywgc3RpbGwgc3RhZ2U/Igo+PiDCoG1zZ3N0ciAiIgo+ICsi0KTQsNC5
0LsgJXMg0LrQsNC20LXRgtGB0Y8g0YHQvtC00LXRgNC20LjRgiDQvdC10L7QsdGA0LDQsdC+0YLQ
sNC90L3Ri9C1INC60L7QvdGE0LvQuNC60YLRiy4KPiDQn9GA0L7QtNC+0LvQttC40YLRjCDQv9C+
0LTQs9C+0YLQvtCy0LrRgyDQuiAiCj4gwqAi0YHQvtGF0YDQsNC90LXQvdC40Y4/Igo+IHRvCj4g
KyLQpNCw0LnQuyAlcywg0LrQsNC20LXRgtGB0Y8sINGB0L7QtNC10YDQttC40YIg0L3QtdC+0LHR
gNCw0LHQvtGC0LDQvdC90YvQtSDQutC+0L3RhNC70LjQutGC0YsuCj4g0J/RgNC+0LTQvtC70LbQ
uNGC0Ywg0L/QvtC00LPQvtGC0L7QstC60YMg0LogIgo+IMKgItGB0L7RhdGA0LDQvdC10L3QuNGO
PyIKCk1heWJlIHlvdSBjYW4ganVzdCBzdWJtaXQgdGhlIHBhdGNoIHByb3Blcmx5PwpPVE9ILCBJ
J2xsIGRvIGl0IHRoaXMgZXZlbmluZywgdW5sZXNzIHlvdSBkbyBpdCBmaXJzdCwgb2YgY291cnNl
Lgo=
