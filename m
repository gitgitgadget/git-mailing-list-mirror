From: Johan Laenen <johan.laenen@gmail.com>
Subject: Re: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Date: Wed, 21 Oct 2015 08:09:16 +0200
Message-ID: <CAA2R5K6fej+QQp-NLveUGAnrbfSVJ0Msp=ns_nRridUENiQv5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c358de42b2070522973add
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 08:10:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zomb3-00039n-K6
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 08:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbbJUGJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 02:09:57 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35535 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbJUGJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 02:09:56 -0400
Received: by obctp1 with SMTP id tp1so6596146obc.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ZSIe5UoBIqP7KrO/xpIbuwmRpYjvX1K4nVOGhRLQIEc=;
        b=GjD0pgUMp8d5c9k5+BxOiVKoTiv2fTbjt5bNaZaMAcIjl0qELItbVzGg+pzV3uA9Wn
         StICdwgoxRKwX6VOQ5v7u8JDlKD+0kMn15ef7P9jLoeQN5vISjsNKyDE9z26xcn4SiT6
         sbOk16RVSdUcEDAe3oEf8io8iaB0yHo1YHNPJZ5MiJ/rtWcZVLBE/yBMWVuSTkdliN4q
         x1GYNtjai/EqZNWai0oFX0VT/ovw1fhF7RpxwVHSGPvXTRb2AUOo08qDFwRBdhyVkzsI
         i7ap9WdIEuUJ8DQbINcm5X+RTOVZydbhpbWKYsk6aXfMmqIxCbpQMjZn8lW4eVM7wMII
         We8A==
X-Received: by 10.60.47.199 with SMTP id f7mr4724765oen.54.1445407796399; Tue,
 20 Oct 2015 23:09:56 -0700 (PDT)
Received: by 10.202.168.200 with HTTP; Tue, 20 Oct 2015 23:09:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279970>

--001a11c358de42b2070522973add
Content-Type: text/plain; charset=UTF-8

Enrique Tobis <Enrique.Tobis <at> twosigma.com> writes:

> run GIT_CURL_VERBOSE=1 git pull and send the output. That should show the failing authentication method.



Please see the file in attachment,

greetings,

Johan

--001a11c358de42b2070522973add
Content-Type: text/plain; charset=US-ASCII; name="git.txt"
Content-Disposition: attachment; filename="git.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig0efuow0

JCBHSVRfQ1VSTF9WRVJCT1NFPTEgL2Jpbi9naXQgcHVsbAoqIFNUQVRFOiBJTklUID0+IENPTk5F
Q1QgaGFuZGxlIDB4MjAwODFiZDA7IGxpbmUgMTA5MCAoY29ubmVjdGlvbiAjLTUwMDApCiogQ291
bGRuJ3QgZmluZCBob3N0IGdpdGh1Yi5jb20gaW4gdGhlIC5uZXRyYyBmaWxlOyB1c2luZyBkZWZh
dWx0cwoqIEFkZGVkIGNvbm5lY3Rpb24gMC4gVGhlIGNhY2hlIG5vdyBjb250YWlucyAxIG1lbWJl
cnMKKiAgIFRyeWluZyAxMC4xOTIuNDUuMTQ5Li4uCiogU1RBVEU6IENPTk5FQ1QgPT4gV0FJVENP
Tk5FQ1QgaGFuZGxlIDB4MjAwODFiZDA7IGxpbmUgMTE0MyAoY29ubmVjdGlvbiAjMCkKKiBDb25u
ZWN0ZWQgdG8gbXlwcm94eSAoMTAuMTkyLjQ1LjE0OSkgcG9ydCA4MDgwICgjMCkKKiBTVEFURTog
V0FJVENPTk5FQ1QgPT4gV0FJVFBST1hZQ09OTkVDVCBoYW5kbGUgMHgyMDA4MWJkMDsgbGluZSAx
MjQwIChjb25uZWN0aW9uICMwKQoqIEVzdGFibGlzaCBIVFRQIHByb3h5IHR1bm5lbCB0byBnaXRo
dWIuY29tOjQ0Mwo+IENPTk5FQ1QgZ2l0aHViLmNvbTo0NDMgSFRUUC8xLjEKSG9zdDogZ2l0aHVi
LmNvbTo0NDMKVXNlci1BZ2VudDogZ2l0LzIuNS4zClByb3h5LUNvbm5lY3Rpb246IEtlZXAtQWxp
dmUKCiogUmVhZCByZXNwb25zZSBpbW1lZGlhdGVseSBmcm9tIHByb3h5IENPTk5FQ1QKPCBIVFRQ
LzEuMSA0MDcgUHJveHkgQXV0aGVudGljYXRpb24gUmVxdWlyZWQKPCBQcm94eS1BdXRoZW50aWNh
dGU6IE5FR09USUFURQo8IFByb3h5LUF1dGhlbnRpY2F0ZTogTlRMTQo8IFByb3h5LUF1dGhlbnRp
Y2F0ZTogQkFTSUMgcmVhbG09IlBPU1RfQUQiCjwgQ2FjaGUtQ29udHJvbDogbm8tY2FjaGUKPCBQ
cmFnbWE6IG5vLWNhY2hlCjwgQ29udGVudC1UeXBlOiB0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgK
PCBQcm94eS1Db25uZWN0aW9uOiBjbG9zZQo8IENvbm5lY3Rpb246IGNsb3NlCjwgQ29udGVudC1M
ZW5ndGg6IDEwMjUKPAoqIElnbm9yZSAxMDI1IGJ5dGVzIG9mIHJlc3BvbnNlLWJvZHkKKiBDb25u
ZWN0IG1lIGFnYWluIHBsZWFzZQoqIEFMUE4sIG9mZmVyaW5nIGh0dHAvMS4xCiogQ2lwaGVyIHNl
bGVjdGlvbjogQUxMOiFFWFBPUlQ6IUVYUE9SVDQwOiFFWFBPUlQ1NjohYU5VTEw6IUxPVzohUkM0
OkBTVFJFTkdUSAoqIHN1Y2Nlc3NmdWxseSBzZXQgY2VydGlmaWNhdGUgdmVyaWZ5IGxvY2F0aW9u
czoKKiAgIENBZmlsZTogL2V0Yy9wa2kvdGxzL2NlcnRzL2NhLWJ1bmRsZS5jcnQKICBDQXBhdGg6
IG5vbmUKKiBVbmtub3duIFNTTCBwcm90b2NvbCBlcnJvciBpbiBjb25uZWN0aW9uIHRvIGdpdGh1
Yi5jb206NDQzCiogQ3VybF9kb25lCiogQ2xvc2luZyBjb25uZWN0aW9uIDAKKiBUaGUgY2FjaGUg
bm93IGNvbnRhaW5zIDAgbWVtYmVycwoqIFNUQVRFOiBXQUlUUFJPWFlDT05ORUNUID0+IENPTk5F
Q1QgaGFuZGxlIDB4MjAwODFiZDA7IGxpbmUgMTIyMyAoY29ubmVjdGlvbiAjLTUwMDApCiogQ291
bGRuJ3QgZmluZCBob3N0IGdpdGh1Yi5jb20gaW4gdGhlIC5uZXRyYyBmaWxlOyB1c2luZyBkZWZh
dWx0cwoqIEFkZGVkIGNvbm5lY3Rpb24gMS4gVGhlIGNhY2hlIG5vdyBjb250YWlucyAxIG1lbWJl
cnMKKiBIb3N0bmFtZSBteXByb3h5IHdhcyBmb3VuZCBpbiBETlMgY2FjaGUKKiAgIFRyeWluZyAx
MC4xOTIuNDUuMTQ5Li4uCiogU1RBVEU6IENPTk5FQ1QgPT4gV0FJVENPTk5FQ1QgaGFuZGxlIDB4
MjAwODFiZDA7IGxpbmUgMTE0MyAoY29ubmVjdGlvbiAjMSkKKiBDb25uZWN0ZWQgdG8gbXlwcm94
eSAoMTAuMTkyLjQ1LjE0OSkgcG9ydCA4MDgwICgjMSkKKiBTVEFURTogV0FJVENPTk5FQ1QgPT4g
V0FJVFBST1hZQ09OTkVDVCBoYW5kbGUgMHgyMDA4MWJkMDsgbGluZSAxMjQwIChjb25uZWN0aW9u
ICMxKQoqIEVzdGFibGlzaCBIVFRQIHByb3h5IHR1bm5lbCB0byBnaXRodWIuY29tOjQ0Mwo+IENP
Tk5FQ1QgZ2l0aHViLmNvbTo0NDMgSFRUUC8xLjEKSG9zdDogZ2l0aHViLmNvbTo0NDMKVXNlci1B
Z2VudDogZ2l0LzIuNS4zClByb3h5LUNvbm5lY3Rpb246IEtlZXAtQWxpdmUKCiogUmVhZCByZXNw
b25zZSBpbW1lZGlhdGVseSBmcm9tIHByb3h5IENPTk5FQ1QKPCBIVFRQLzEuMSA0MDcgUHJveHkg
QXV0aGVudGljYXRpb24gUmVxdWlyZWQKPCBQcm94eS1BdXRoZW50aWNhdGU6IE5FR09USUFURQoq
IGdzc19pbml0X3NlY19jb250ZXh0KCkgZmFpbGVkOiA6IFNQTkVHTyBjYW5ub3QgZmluZCBtZWNo
YW5pc21zIHRvIG5lZ290aWF0ZQo8IFByb3h5LUF1dGhlbnRpY2F0ZTogTlRMTQo8IFByb3h5LUF1
dGhlbnRpY2F0ZTogQkFTSUMgcmVhbG09IlBPU1RfQUQiCjwgQ2FjaGUtQ29udHJvbDogbm8tY2Fj
aGUKPCBQcmFnbWE6IG5vLWNhY2hlCjwgQ29udGVudC1UeXBlOiB0ZXh0L2h0bWw7IGNoYXJzZXQ9
dXRmLTgKPCBQcm94eS1Db25uZWN0aW9uOiBjbG9zZQo8IENvbm5lY3Rpb246IGNsb3NlCjwgQ29u
dGVudC1MZW5ndGg6IDEwMjUKPAoqIFJlY2VpdmVkIEhUVFAgY29kZSA0MDcgZnJvbSBwcm94eSBh
ZnRlciBDT05ORUNUCiogRXhwaXJlIGNsZWFyZWQKKiBDdXJsX2RvbmUKKiBDbG9zaW5nIGNvbm5l
Y3Rpb24gMQoqIFRoZSBjYWNoZSBub3cgY29udGFpbnMgMCBtZW1iZXJzCmZhdGFsOiB1bmFibGUg
dG8gYWNjZXNzICdodHRwczovL2dpdGh1Yi5jb20vZ2FyZ2xlL2ZyZW5jaC8nOiBVbmtub3duIFNT
TCBwcm90b2NvbCBlcnJvciBpbiBjb25uZWN0aW9uIHRvIGdpdGh1Yi5jb206NDQzCg==
--001a11c358de42b2070522973add--
