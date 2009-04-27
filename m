From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add Russian translation to gitk
Date: Mon, 27 Apr 2009 10:10:52 +0200
Message-ID: <81b0412b0904270110n74a01e40ufe70422bf49ba89e@mail.gmail.com>
References: <20090426132452.GB30825@blimp.localdomain>
	 <20090427075134.GA15723@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 13:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyLvb-0001Hb-V2
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 10:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZD0IKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 04:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZD0IKy
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 04:10:54 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47708 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbZD0IKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 04:10:53 -0400
Received: by fxm2 with SMTP id 2so2137746fxm.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3x0ZiYUiYpTKZgcOHXRlj9lHBb+pc01XipgWjgIUHeE=;
        b=UjgRMovg1QMgyU1xwUUHsg6z1WNeZj6hlZs7JCiwrYgfFVxapboExJKhmBfIGILl1F
         3t21sQ/S/YWtCoIGmNmc4YNX46CO3GK+wUTmRoAQBuAbMpByES1nJAJZNgEhucQNHiy7
         aTZUpF0n6nu8mW2SlUXbjPfYQ9s81mpAuWVtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qWbrMhguwNagnl+LyJNNQgacQP+DORMeqMKq9stYDOSBANmNOr0l6e0X9JqVJzOj7R
         qRVdageS/VaPhGiyBruoYxDks0V1sIP5iwuVQYtA0nx4dfOxGwlS3ez8cUaKRNy+s6Z6
         sjX8N+fgA8Y5btqyiLwAsvyj643nrbMBG0rpk=
Received: by 10.204.52.72 with SMTP id h8mr5071861bkg.30.1240819852126; Mon, 
	27 Apr 2009 01:10:52 -0700 (PDT)
In-Reply-To: <20090427075134.GA15723@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117658>

MjAwOS80LzI3IERtaXRyeSBQb3RhcG92IDxkcG90YXBvdkBnbWFpbC5jb20+Ogo+IE9uIFN1biwg
QXByIDI2LCAyMDA5IGF0IDAzOjI0OjUyUE0gKzAyMDAsIEFsZXggUmllc2VuIHdyb3RlOgo+PiAr
IzogZ2l0azoxOTE3Cj4+ICttc2dpZCAiUmVyZWFkIHJlZmVyZW5jZXMiCj4+ICttc2dzdHIgItCe
0LHQvdC+0LLQuNGC0Ywg0YHQv9C40YHQvtC6INCy0LXRgtCy0LXQuSIKPgo+IHJlZmVyZW5jZSAt
PiDRgdGB0YvQu9C60LAKPiBicmFuY2ggLT4g0LLQtdGC0LLRjCwg0LLQtdGC0LrQsAo+Cj4gU28s
IGl0IHNob3VsZCBiZTogItCe0LHQvdC+0LLQuNGC0Ywg0YHQv9C40YHQvtC6INGB0YHRi9C70L7Q
uiIKPgo+PiArCj4+ICsjOiBnaXRrOjE5MTgKPj4gK21zZ2lkICJMaXN0IHJlZmVyZW5jZXMiCj4+
ICttc2dzdHIgItCh0L/QuNGB0L7QuiDQstC10YLQstC10LkiCj4KPiAi0KHQv9C40YHQvtC6INGB
0YHRi9C70L7QuiIKPgoKT2gsIHRoZXNlLi4uIEkgd2FzIG1pc2xlYWQgYnkgdGhlIGZhY3QsIHRo
YXQgdGhlICJyZWZlcmVuY2UiCmlzIGNsb3NlbHkgcmVsYXRlZCB0byB0aGUgZW5nbGlzaCBtZWFu
aW5nIG9mICJwb2ludGVyIiBpbgpydXNzaWFuLXNwZWFraW5nIGNvbXB1dGluZywgYW5kIGNob3Nl
IHRvIGRpdmVydCBiYWNrIHRvCml0cyBicmFuY2h5IG1lYW5pbmcuIE9uIHRoZSBzZWNvbmQgdGhv
dWdodCwgSSBhZ3JlZSB3aXRoIHlvdS4KCkknbGwgcmVzZW5kLiBQYXVsLCBwbGVhc2UgZG9uJ3Qg
YXBwbHkgdGhpcyB0cmFuc2xhdGlvbiBqdXN0IHlldC4K
