From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: Really remove a file ?
Date: Fri, 10 Oct 2008 13:50:00 -0700
Message-ID: <d4bc1a2a0810101350h17856074qfe397078b734eb85@mail.gmail.com>
References: <8CAF851B91FEF07-660-20E9@webmail-da15.sysops.aol.com>
	 <81b0412b0810091156v15dea27an95050a06cfb4f8df@mail.gmail.com>
	 <d4bc1a2a0810091643u3903a1f4h44d3579b98fe6922@mail.gmail.com>
	 <8CAF8D313562BEE-1588-259E@webmail-da15.sysops.aol.com>
	 <20081010143249.GE3671@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: marcreddist@aim.com, git@vger.kernel.org
To: "=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 10 22:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoOxA-0002FX-Ki
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 22:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483AbYJJUuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 16:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758716AbYJJUuE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 16:50:04 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:34915 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754AbYJJUuB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 16:50:01 -0400
Received: by gxk9 with SMTP id 9so1338754gxk.13
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pj04w1UhkLLvGajEn3JfWDEsyI5MIU/o33pxqukMJk8=;
        b=qZUzMR9nAHAic7IqaCFfnaFi2/wpxmIxGNRvw0/GAPqGes9sBT2mdpeNglKFRoEZnE
         4m/ZZ3L4yT2AzT64kvp7/wOvta6yVJz6Kd9qXi39KdgaYTDULSBFE3b6LIcUfBJO6ho9
         pQl810BhV+0vL4tpwLdGAYVQ3RzwZHMk6yAFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AZmrH6FZQBcQSrS2b8pQKkVIgWkBoq6nr4DngGTI3mj7m+SRltVUNr5EeV6xRcYX4f
         3JLRR7xdNjE1AJzf7QTm5PS1tQbKHfxh2t7pzr4vVt0Pt1bUY1h86MaK4FnedtdbEQEk
         /JF4EtDzdvklIjQi0iRPOdvwEbYfBbpezaztY=
Received: by 10.100.254.5 with SMTP id b5mr2940307ani.57.1223671800148;
        Fri, 10 Oct 2008 13:50:00 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Fri, 10 Oct 2008 13:50:00 -0700 (PDT)
In-Reply-To: <20081010143249.GE3671@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97954>

PiBCdXQgZG9uJ3QgZG8gdGhlIHBydW5pbmcgdW50aWwgeW91J3JlIGFic29sdXRlbHkgc3VyZSB0
aGF0IHlvdSBkb24ndAo+IHJlcXVpcmUgdGhlIG9sZCBzdHVmZiBhbnltb3JlLgoKT3IsIG9mIGNv
dXJzZSwgeW91IGNvdWxkIGp1c3Qga2VlcCBhbiBpbmRlcGVuZGVudCBjb3B5IG9mIHRoZSB3aG9s
ZQpyZXBvIHByZS1maWx0ZXItYnJhbmNoLgoKT24gRnJpLCBPY3QgMTAsIDIwMDggYXQgNzozMiBB
TSwgQmrDtnJuIFN0ZWluYnJpbmsgPEIuU3RlaW5icmlua0BnbXguZGU+IHdyb3RlOgo+Cj4gT24g
MjAwOC4xMC4xMCAwNTozODoyNSAtMDQwMCwgbWFyY3JlZGRpc3RAYWltLmNvbSB3cm90ZToKPiA+
PiBZb3UnbGwgcHJvYmFibHkgYWxzbyB3YW50IHRvIHJ1biAiZ2l0IGdjIiBvbiB5b3VyIHJlcG8g
dG8gYWN0dWFsbHkKPiA+PiBnZXQgcmlkIG9mIHRoZSBodWdlIG9iamVjdCB0aGF0IHdhcyBhZGRl
ZCAob3IgZG9lcyBmaWx0ZXItYnJhbmNoIGRvCj4gPj4gdGhpcyBhdXRvbWF0aWNhbGx5PykuCj4g
Pgo+ID4gSSdtIG5vdCBzdXJlIGl0J3MgcmVxdWlyZWQgYnkgZ2l0LWZpbHRlci1icmFuY2ggYWxv
bmUuIEluIHRoaXMgY2FzZSA6Cj4gPgo+ID4gZ2l0LWdjIHNhdmVzIGFsbW9zdCA1JSBhZnRlciB0
aGUgZmlsZSBkZWxldGlvbgo+ID4KPiA+IGl0IHNhdmVzIDQuNSUgYmVmb3JlIHRoZSBmaWxlIGRl
bGV0aW9uCj4gPgo+ID4gSWYgSSBydW4gZ2l0IGdjIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIGdpdCBm
aWx0ZXItYnJhbmNoLCBpdCBzYXZlcyA0LjUlCj4gPiBhbmQgdGhlbiAwLjIlLgo+Cj4gRGlkIHlv
dSBjbGVhciB0aGUgcmVmcy9vcmlnaW5hbCBuYW1lc3BhY2UgYW5kIHlvdXIgcmVmbG9ncz8gT3Ro
ZXJ3aXNlLAo+IHRoZSBodWdlIG9iamVjdCBpcyBtb3N0IGxpa2VseSBzdGlsbCByZWZlcmVuY2Vk
IGFuZCB0aHVzIHdvbid0IGdldAo+IHBydW5lZC4gQWxzbywgSSB1c3VhbGx5IHByZWZlciAiZ2l0
IHJlcGFjayAtYWRmIiBvdmVyICJnaXQgZ2MiIGluIHN1Y2gKPiBzaXR1YXRpb25zLCBidXQgdGhh
dCdzIHByb2JhYmx5IGp1c3QgYmVjYXVzZSBJIGRvbid0IGtub3cgdGhlIHJpZ2h0Cj4gd2F5IHRv
IGZvcmNlICJnaXQgZ2MiIHRvIGltbWVkaWF0ZWx5IHBydW5lIHN0dWZmIGp1c3Qgb25jZS4KPgo+
IEJ1dCBkb24ndCBkbyB0aGUgcHJ1bmluZyB1bnRpbCB5b3UncmUgYWJzb2x1dGVseSBzdXJlIHRo
YXQgeW91IGRvbid0Cj4gcmVxdWlyZSB0aGUgb2xkIHN0dWZmIGFueW1vcmUuCj4KPiBCasO2cm4K
PiAtLQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1
YnNjcmliZSBnaXQiIGluCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2Vy
Lmtlcm5lbC5vcmcKPiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwu
b3JnL21ham9yZG9tby1pbmZvLmh0bWwK
