From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Sat, 26 Sep 2009 22:55:19 +0100
Message-ID: <e5bfff550909261455g4eef8432jbb90048417deecba@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909251304g53202e1fna50afabf93722ce5@mail.gmail.com>
	 <23e749600909251507m345ab66aq74730d1ada75cb7b@mail.gmail.com>
	 <e5bfff550909260217l7f6e8766te072decee1bbbbf3@mail.gmail.com>
	 <4ABDE6FF.2090008@gmail.com>
	 <e5bfff550909260309x1ef007a0k8a1ab85f78fe5c5e@mail.gmail.com>
	 <23e749600909260500i5e04864bsc845b9f20a11141@mail.gmail.com>
	 <e5bfff550909260553v38243faaic53860d20322232d@mail.gmail.com>
	 <e5bfff550909260858u71df1487va569262fc9819415@mail.gmail.com>
	 <23e749600909261128v4e398dadhc8be096f2500b17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d1c25df7abd0474821e86
Cc: git@vger.kernel.org
To: alexandrul cuza <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrfEp-00059X-QI
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbZIZVzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 17:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbZIZVzS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:55:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:18542 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbZIZVzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 17:55:16 -0400
Received: by ey-out-2122.google.com with SMTP id d26so781870eyd.19
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8aoLKcE/iBbhfMd78t8CGnS5l6TLMVXxykzCoLuzNdI=;
        b=J+yiDcvjdlRuVOQQiyfPlEMQKeIpuFnboZPq5luDgWnb5xT1uneveKZxwZz4DzWRhf
         CMBTv9CJGQC3fEDfNl0lerwlJGrzbu6RMpko81jU0Mxq5K9NxpZEpcjYN697pALH8Hpv
         k6EdyHVvoAT9kJensml+jzZSp3Kh+4E3c1pB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jxd5Vlg1nni8/Mxd/PRwc2tWua8w6l1qi6FuiOm9hawxXnshoyluG/C762AABk8y2e
         BJskRj7FTRXTDHbsfF+YWpbev8g708aGFwR3sCFNfR0ls3TB9Nis/GDKIVJq/P3CYaYC
         HpDiQ1/ZA+QOecuru/M/SofcJJSAIb1RjL6J8=
Received: by 10.216.3.207 with SMTP id 57mr374495weh.53.1254002119375; Sat, 26 
	Sep 2009 14:55:19 -0700 (PDT)
In-Reply-To: <23e749600909261128v4e398dadhc8be096f2500b17e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129185>

--0016364d1c25df7abd0474821e86
Content-Type: text/plain; charset=UTF-8

Hi Alexandrul,

Now it works !!!! :-)  :-)

It was a virus !  I have run Malwarebytes Anti-malware 1.41 and it
found some virus (I send you the logs in attachment), after removing
them the problem disappeared.

I have Kaspersky as antivirus, but, although a very good antivirus it
failed to identify them.

I didn't know this Malwarebytes, but it seems very powerful.

Thanks anyhow for your exceptional help, I have really appreciated that !!!!


Thanks again
Marco

--0016364d1c25df7abd0474821e86
Content-Type: text/plain; charset=US-ASCII; name="mbam-log-2009-09-26 (22-26-18).txt"
Content-Disposition: attachment; 
	filename="mbam-log-2009-09-26 (22-26-18).txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g02we5zl2

TWFsd2FyZWJ5dGVzJyBBbnRpLU1hbHdhcmUgMS40MQ0KRGF0YWJhc2UgdmVyc2lvbjogMjg2Mw0K
V2luZG93cyA2LjAuNjAwMiBTZXJ2aWNlIFBhY2sgMg0KDQoyNi8wOS8yMDA5IDIyLjI2LjE4DQpt
YmFtLWxvZy0yMDA5LTA5LTI2ICgyMi0yNi0xOCkudHh0DQoNClNjYW4gdHlwZTogRnVsbCBTY2Fu
IChDOlx8RDpcfCkNCk9iamVjdHMgc2Nhbm5lZDogMzQxNzAzDQpUaW1lIGVsYXBzZWQ6IDEgaG91
cihzKSwgMjYgbWludXRlKHMpLCAxNCBzZWNvbmQocykNCg0KTWVtb3J5IFByb2Nlc3NlcyBJbmZl
Y3RlZDogMA0KTWVtb3J5IE1vZHVsZXMgSW5mZWN0ZWQ6IDANClJlZ2lzdHJ5IEtleXMgSW5mZWN0
ZWQ6IDMNClJlZ2lzdHJ5IFZhbHVlcyBJbmZlY3RlZDogMQ0KUmVnaXN0cnkgRGF0YSBJdGVtcyBJ
bmZlY3RlZDogMA0KRm9sZGVycyBJbmZlY3RlZDogMg0KRmlsZXMgSW5mZWN0ZWQ6IDYNCg0KTWVt
b3J5IFByb2Nlc3NlcyBJbmZlY3RlZDoNCihObyBtYWxpY2lvdXMgaXRlbXMgZGV0ZWN0ZWQpDQoN
Ck1lbW9yeSBNb2R1bGVzIEluZmVjdGVkOg0KKE5vIG1hbGljaW91cyBpdGVtcyBkZXRlY3RlZCkN
Cg0KUmVnaXN0cnkgS2V5cyBJbmZlY3RlZDoNCkhLRVlfQ0xBU1NFU19ST09UXENMU0lEXHtiYTYw
MzIxNS0yM2YyLTQyYWQtZjRlNC0wMGFhYzM5Y2FhNTN9IChUcm9qYW4uRXJ0Zm9yKSAtPiBRdWFy
YW50aW5lZCBhbmQgZGVsZXRlZCBzdWNjZXNzZnVsbHkuDQpIS0VZX0NVUlJFTlRfVVNFUlxTT0ZU
V0FSRVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHRcU3RhdHNce2JhNjAzMjE1
LTIzZjItNDJhZC1mNGU0LTAwYWFjMzljYWE1M30gKFRyb2phbi5FcnRmb3IpIC0+IFF1YXJhbnRp
bmVkIGFuZCBkZWxldGVkIHN1Y2Nlc3NmdWxseS4NCkhLRVlfTE9DQUxfTUFDSElORVxTT0ZUV0FS
RVxNaWNyb3NvZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxCcm93c2VyIEhlbHBl
ciBPYmplY3RzXHtiYTYwMzIxNS0yM2YyLTQyYWQtZjRlNC0wMGFhYzM5Y2FhNTN9IChUcm9qYW4u
RXJ0Zm9yKSAtPiBRdWFyYW50aW5lZCBhbmQgZGVsZXRlZCBzdWNjZXNzZnVsbHkuDQoNClJlZ2lz
dHJ5IFZhbHVlcyBJbmZlY3RlZDoNCkhLRVlfTE9DQUxfTUFDSElORVxTT0ZUV0FSRVxNaWNyb3Nv
ZnRcV2luZG93c1xDdXJyZW50VmVyc2lvblxFeHBsb3JlclxTaGFyZWRUYXNrU2NoZWR1bGVyXHti
YTYwMzIxNS0yM2YyLTQyYWQtZjRlNC0wMGFhYzM5Y2FhNTN9IChUcm9qYW4uRXJ0Zm9yKSAtPiBR
dWFyYW50aW5lZCBhbmQgZGVsZXRlZCBzdWNjZXNzZnVsbHkuDQoNClJlZ2lzdHJ5IERhdGEgSXRl
bXMgSW5mZWN0ZWQ6DQooTm8gbWFsaWNpb3VzIGl0ZW1zIGRldGVjdGVkKQ0KDQpGb2xkZXJzIElu
ZmVjdGVkOg0KQzpcUkVDWUNMRVJcUy0xLTUtMjEtMDI0MzkzNjAzMy0zMDUyMTE2MzcxLTM4MTg2
MzMwOC0xODExIChUcm9qYW4uQWdlbnQpIC0+IFF1YXJhbnRpbmVkIGFuZCBkZWxldGVkIHN1Y2Nl
c3NmdWxseS4NCkM6XFJFQ1lDTEVSXHMtMS01LTIxLTAyNDM5MzYwMzMtMzA1MjExNjM3MS0zODE4
NjMzMDgtMTg1OCAoV29ybS5BdXRvcnVuKSAtPiBRdWFyYW50aW5lZCBhbmQgZGVsZXRlZCBzdWNj
ZXNzZnVsbHkuDQoNCkZpbGVzIEluZmVjdGVkOg0KQzpcYnFlZ2guZXhlIChUcm9qYW4uRHJvcHBl
cikgLT4gUXVhcmFudGluZWQgYW5kIGRlbGV0ZWQgc3VjY2Vzc2Z1bGx5Lg0KQzpcV2luZG93c1xT
eXN0ZW0zMlxiZWVwLnN5cyAoUm9vdGtpdC5BZ2VudCkgLT4gUXVhcmFudGluZWQgYW5kIGRlbGV0
ZWQgc3VjY2Vzc2Z1bGx5Lg0KQzpcV2luZG93c1xTeXN0ZW0zMlxzZXJmaW5nLmRsbCAoUm9vdGtp
dC5BZ2VudCkgLT4gRGVsZXRlIG9uIHJlYm9vdC4NCkM6XFdpbmRvd3NcU3lzdGVtMzJcZHJpdmVy
c1xzZXJmaW5nLnN5cyAoUm9vdGtpdC5BZ2VudCkgLT4gUXVhcmFudGluZWQgYW5kIGRlbGV0ZWQg
c3VjY2Vzc2Z1bGx5Lg0KQzpcUkVDWUNMRVJcUy0xLTUtMjEtMDI0MzkzNjAzMy0zMDUyMTE2Mzcx
LTM4MTg2MzMwOC0xODExXERlc2t0b3AuaW5pIChUcm9qYW4uQWdlbnQpIC0+IFF1YXJhbnRpbmVk
IGFuZCBkZWxldGVkIHN1Y2Nlc3NmdWxseS4NCkM6XFJFQ1lDTEVSXHMtMS01LTIxLTAyNDM5MzYw
MzMtMzA1MjExNjM3MS0zODE4NjMzMDgtMTg1OFxEZXNrdG9wLmluaSAoV29ybS5BdXRvcnVuKSAt
PiBRdWFyYW50aW5lZCBhbmQgZGVsZXRlZCBzdWNjZXNzZnVsbHkuDQo=
--0016364d1c25df7abd0474821e86--
