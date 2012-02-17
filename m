From: "Valentin Laskov" <laskov@festa.bg>
Subject: Window generator in git - new feature request
Date: Fri, 17 Feb 2012 11:00:05 +0200
Message-ID: <E00EEF83EF994A3D9CFE4BDA494E1E5D@festa.bg>
Reply-To: Fedora Translation Project List <trans@lists.fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Fedora Translation Project List <trans@lists.fedoraproject.org>
To: <git@vger.kernel.org>
X-From: trans-bounces@lists.fedoraproject.org Fri Feb 17 10:00:19 2012
Return-path: <trans-bounces@lists.fedoraproject.org>
Envelope-to: rh-i18n-list@gmane.org
Received: from bastion01.fedoraproject.org ([209.132.181.2] helo=bastion.fedoraproject.org)
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <trans-bounces@lists.fedoraproject.org>)
	id 1RyJfu-0008Te-9b
	for rh-i18n-list@gmane.org; Fri, 17 Feb 2012 10:00:18 +0100
Received: from lists.fedoraproject.org (collab03.vpn.fedoraproject.org [192.168.1.70])
	by bastion01.phx2.fedoraproject.org (Postfix) with ESMTP id 087BB20B3B;
	Fri, 17 Feb 2012 09:00:16 +0000 (UTC)
Received: from collab03.fedoraproject.org (localhost [127.0.0.1])
	by lists.fedoraproject.org (Postfix) with ESMTP id BC23C40B09;
	Fri, 17 Feb 2012 09:00:13 +0000 (UTC)
X-Original-To: trans@lists.fedoraproject.org
Delivered-To: trans@lists.fedoraproject.org
Received: from smtp-mm02.fedoraproject.org (smtp-mm02.fedoraproject.org
	[66.35.62.164])
	by lists.fedoraproject.org (Postfix) with ESMTP id 74E0040B08
	for <trans@lists.fedoraproject.org>;
	Fri, 17 Feb 2012 09:00:12 +0000 (UTC)
Received: from ns.festa.bg (ns.festa.bg [84.43.164.58])
	by smtp-mm02.fedoraproject.org (Postfix) with ESMTP id E95DC41A52
	for <trans@lists.fedoraproject.org>;
	Fri, 17 Feb 2012 09:00:13 +0000 (UTC)
Received: from sysadmin (admin.festa.bg [192.168.10.137])
	by ns.festa.bg (8.14.1/8.14.1) with SMTP id q1H9050h031658;
	Fri, 17 Feb 2012 11:00:06 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Festa-MailScanner-Information: Please contact the ISP for more information
X-Festa-MailScanner-ID: q1H9050h031658
X-Festa-MailScanner: Found to be clean
X-Festa-MailScanner-From: laskov@festa.bg
X-Spam-Status: No
X-BeenThere: trans@lists.fedoraproject.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Fedora Translation Project List <trans.lists.fedoraproject.org>
List-Unsubscribe: <https://admin.fedoraproject.org/mailman/options/trans>,
	<mailto:trans-request@lists.fedoraproject.org?subject=unsubscribe>
List-Archive: <http://lists.fedoraproject.org/pipermail/trans/>
List-Post: <mailto:trans@lists.fedoraproject.org>
List-Help: <mailto:trans-request@lists.fedoraproject.org?subject=help>
List-Subscribe: <https://admin.fedoraproject.org/mailman/listinfo/trans>,
	<mailto:trans-request@lists.fedoraproject.org?subject=subscribe>
Sender: trans-bounces@lists.fedoraproject.org
Errors-To: trans-bounces@lists.fedoraproject.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190940>

SGkgZ2l0IHRlYW0hCkhpIGZlZG9yYSB0cmFuc2xhdG9ycyB0ZWFtIQoKSSBoYXZlIGFuIGlkZWEg
YW5kIHdhbnQgdG8gc2hhcmUgd2l0aCB5b3UuCgpJIGRvbid0IGtub3cgd2hhdCBpcyBnaXQgaW4g
ZGV0YWlscy4gSSdtIHRyYW5zbGF0aW5nIEdVSSBhbmQgZG9jdW1lbnRhdGlvbiBvZiBkaWZmZXJl
bnQgcHJvZ3JhbXMgdG8gQnVsZ2FyaWFuLgpJIGFuZCB0cmFuc2xhdG9ycyBoYXZlIGEgcHJvYmxl
bSBhbmQgSSB0aGluayBnaXQgYW5kIHlvdSBjYW4gcmVzb2x2ZSBpdCBpbiBhIGZ1dHVyZSByZWxl
YXNlLgoKSW4gdHJhbnNsYXRpbmcgd2UgaGF2ZSBhIG51bWJlciBvZiBzZW50ZW5jZXMuIFdoZW4g
dGhpcyBpcyBhIGRvY3VtZW50YXRpb24sIGl0J3MgZWFzeSB0byB0cmFuc2xhdGUsIGVzcGVjaWFs
bHkgaWYgdGhlIHRyYW5zbGF0b3IgCmtub3dzIGhvdyBwcm9ncmFtIHdvcmtzLiBCdXQgaWYgdGV4
dCBpcyBmcm9tIGEgR1VJIHdpbmRvdywgdHJhbnNsYXRvciBtdXN0IGtub3cgY29udGV4dCB1c2Vk
IGZvciBlYWNoIHRleHQgLSBpcyB0aGlzIGlzIGEgY29tbWFuZCBvciAKc3RhdGUgZGVzY3JpcHRp
b247IHRleHQgb24gYSBidXR0b24gb3IgcG9wLXVwIGhpbnQgZm9yIHRoaXMgYnV0dG9uLi4uID8g
RXZlbiB0cmFuc2xhdG9yIGtub3dzIGhvdyBwcm9ncmFtIHdvcmtzLCBpdCBpcyBwb3NzaWJsZSB0
byAKaGF2ZSB0ZXh0cyBhbmQgd2luZG93cyBoZSBuZXZlciBzZWVuLgoKSW1hZ2luZSB0aGF0IGJh
c2VkIG9uIGEgc291cmNlIGNvZGUsIGdpdCBjYW4gZ2VuZXJhdGUgd2luZG93cyBvZiBHVUkgcHJv
Z3JhbSB3aXRoIGFsbCBjb250cm9scyBhbmQgdGV4dHMgbWF5IGFwcGVhciBvbiB0aGVtIGFuZCAK
dGhlc2Ugd2luZG93cyBjYW4gYmUgc2VlbiBvbiBhIHdlYiBzaXRlISBUaGlzIHdpbGwgYmUgYSBn
cmVhdCBmZWF0dXJlIGZvciB0cmFuc2xhdG9ycyEKCi4uLiBvciB0aGlzIG1heSBiZSBpbXBsZW1l
bnRlZCBpbiBhIG5ldyBwcm9qZWN0PyBPciBtYXkgYmUgYSB2aXJ0dWFsIG1hc2hpbmUsIGFjY2Vz
c2VkIGJ5IHdlYiwgd2l0aCBhbGwgImluc3RhbGxlZCIgcHJvZ3JhbXMgd2l0aCAKIndvcmtpbmci
IGNvbnRyb2xzIGJ1dCB3aXRob3V0IHJlYWwgYWN0aW9ucy4uLgoKQ2hlZXJzIQpWYWxlbnRpbiBM
YXNrb3YKCi0tCnRyYW5zIG1haWxpbmcgbGlzdAp0cmFuc0BsaXN0cy5mZWRvcmFwcm9qZWN0Lm9y
ZwpodHRwczovL2FkbWluLmZlZG9yYXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vdHJhbnM=
