From: "David Aguilar" <davvid@gmail.com>
Subject: Are C++ contributions welcome?
Date: Fri, 20 Jun 2008 18:57:33 -0700
Message-ID: <402731c90806201857h23134f17y4189df9d6aa4585c@mail.gmail.com>
References: <4c88165dd0077363a30b4f98fed16c2f@localhost>
	 <46a038f90806200859r520d0593q367d6625a240595a@mail.gmail.com>
	 <200806201811.01444.josemaria@jmgv.org>
	 <200806201820.54585.josemaria@jmgv.org>
	 <86skv81356.fsf@lola.quinscape.zz>
	 <402731c90806201853x1c57ec5fib39bd92810072611@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 21 03:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9sN7-0000xR-6d
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 03:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbYFUB5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 21:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYFUB5g
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 21:57:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45004 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbYFUB5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 21:57:35 -0400
Received: by ug-out-1314.google.com with SMTP id h2so100118ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ktEXIHHcKi/kUjogoSxxSXIqBy0UcyYgrboMWrcOhOw=;
        b=FhHOn+3e3tR7gGffy7fYxfBGrDpQqC7sUCNYmzL11O8N0JhWe8rUW8NAP5t60wGq9V
         183gQ47v85eSR7C019mdQF+JycE4Ce5Uo2zQ5hJ304FO2/9OcP8CQuVK8xhG0qprcq/d
         UnIfJLlLn5ez6GGpr62YkR7r2u5qrrUvaFA6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T3kyMkXX8uBqHXiI7KNUmFrPKFeM2OxqR5vb/2Jo0SvE+8vDu9yY7mpwAfrFMBDuvr
         i6KBaUcCYpo+b/u95DTnTeJo75l3A72JUvJAejreZHfGaePs3ZNh8F4rDqu4QwRvB+PB
         APmWmXU9tVhIrXBWUHmzatE1U/266R05XAixg=
Received: by 10.67.29.4 with SMTP id g4mr238526ugj.73.1214013453500;
        Fri, 20 Jun 2008 18:57:33 -0700 (PDT)
Received: by 10.67.89.14 with HTTP; Fri, 20 Jun 2008 18:57:33 -0700 (PDT)
In-Reply-To: <402731c90806201853x1c57ec5fib39bd92810072611@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85688>

T24gRnJpLCBKdW4gMjAsIDIwMDggYXQgOToyOSBBTSwgRGF2aWQgS2FzdHJ1cCA8ZGFrQGdudS5v
cmc+IHdyb3RlOgo+IEpvc2UgTWFyw61hIEfDs21leiBWZXJnYXJhIDxqb3NlbWFyaWFAam1ndi5v
cmc+IHdyaXRlczoKPgo+PiBCZWZvcmUgc3RhcnRpbmcsIGRvIHlvdSBoYXZlIGFueSBwcmVmZXJl
bmNlIGZvciBRdCBvciBHdGsgaW4gR2l0LiBJIGZlZWwgcXVpdGUKPj4gY29uZm9ydGFibGUgd2l0
aCBib3RoIG9mIHRoZW0uCj4+Cj4+IFF0IC4gQysrIEdQTAo+PiBHdGsrLiBDIC0gTEdQTAo+Pgo+
PiBUaGUgcXVhbGl0eSBpcyBnb29kIGZvciBib3RoIG9mIHRoZW0KPgo+IFBsZWFzZSB0YWtlIGEg
bG9vayBhdAo+IDxVUkw6aHR0cDovL2RldmVsb3Blci5pbWVuZGlvLmNvbS9wcm9qZWN0cy9naWdn
bGU+LiAgSXQgbWlnaHQgYmUKPiB3b3J0aHdoaWxlIG5vdCB0byBzdGFydCBmcm9tIHNjcmF0Y2gg
aGVyZS4KPgo+IC0tCj4gRGF2aWQgS2FzdHJ1cAoKCkFuZCBpZiB5b3UgZG9uJ3QgbWluZCBQeXRo
b24sIFF0LCBMR1BMLi4uCgpodHRwOi8vY29sYS50dXhmYW1pbHkub3JnLwpodHRwOi8vZ2l0b3Jp
b3VzLm9yZy9wcm9qZWN0cy9naXQtY29sYS8KCmVuam95LAoKLS0KIERhdmlkCgoKCi0tIAogRGF2
aWQK
