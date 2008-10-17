From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: Weird filename encoding issue
Date: Fri, 17 Oct 2008 12:08:04 +0400
Message-ID: <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30645_29969461.1224230885025"
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 10:09:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqkOj-0003lL-21
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 10:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYJQIIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 04:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYJQIIJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 04:08:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:27702 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYJQIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 04:08:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so425557rvb.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type:references;
        bh=gtGC/4wKcSnqOSFqKJO5Z0GNrYIs1zNXFAZmPOrY+Ss=;
        b=Ds9BoAy+oqHxY1L4ZAgbY2rQ3jYCJ6/wydQq+2nOMZv7SdKJZZ+QtU4bTVh+/hJfxl
         84yoogqVkBNwUHHB9lSlTpn7IE0COO9bqxKoTf/IGEMRXA7DSjeWhxSprONdX8puAuPw
         0BQl0dx3smneJg2OexqfWoR95nNFfGzRMPK2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:references;
        b=Djsix3sF3goMRhB5Y+YuAPfwAVwLNM04oyjvUrao1b4ijrffOgsN57dIctmmOO5752
         1MLAj+FD65TfKDFOrKCAoctRW85r1UH7UdSYThKNkybICAOuX043g0VKMJKXh608olGx
         5oyM/+PapJ9wVvdntJ2evrB4yOG+TN89XaW48=
Received: by 10.140.201.15 with SMTP id y15mr2319752rvf.145.1224230885020;
        Fri, 17 Oct 2008 01:08:05 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Fri, 17 Oct 2008 01:08:04 -0700 (PDT)
In-Reply-To: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98457>

------=_Part_30645_29969461.1224230885025
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: base64
Content-Disposition: inline

T24gRnJpLCBPY3QgMTcsIDIwMDggYXQgMTE6NTkgQU0sIEFsZXhhbmRlciBHbGFkeXNoIDxhZ2xh
ZHlzaEBnbWFpbC5jb20+IHdyb3RlOgo+IEhpLCBhbGwhCj4KPiBPUyBYIDEwLjUuNSAoRW5nbGlz
aCBsb2NhbGUpLCBHaXQgMS41LjUuMQo+IFdpbmRvd3MgWFAgU1AyIChSdXNzaWFuKSwgbXN5c0dp
dCAxLjUuNi4xLjEwNzEuZzc2ZmIKCk15IGFwb2xvZ2llcywgR21haWwgZWF0ZW4gcGFydCBvZiBt
eSBtZXNzYWdlLgoKU29ycnkgZm9yIHN1Y2ggb2xkIEdpdCB2ZXJzaW9ucywgSSBjYW4gbm90IHVw
Z3JhZGUgcmlnaHQgbm93LiBQZXJoYXBzCml0IHdhcyBmaXhlZCBpbiAxLjYueD8KClN0ZXBzIHRv
IHJlcHJvZHVjZToKCjEuIENyZWF0ZSBnaXQgcmVwbyBvbiBXaW5kb3dzIG1hY2hpbmUsIGFkZCB0
aGVyZSBmaWxlLCBuYW1lZAoi68/QydEudHh0IiAoUnVzc2lhbiBmb3IgQ29weS50eHQpIGluIENQ
MTI1MSAoTk9UIFVURi04KS4gSnVzdCBpbgpjYXNlLCBob3BlZnVsbHkgY29ycmVjdGx5IG5hbWVk
IGZpbGUgaXMgYXR0YWNoZWQuCgpGaWxlIG11c3QgYmUgYWRkZWQgYW5kIGNvbW1pdHRlZCBmcm9t
IGdpdCBndWksIG5vdCBmcm9tIGNvbW1hbmQgbGluZS4KCiQgbWtkaXIgdGVzdCAmJiBjZCB0ZXN0
CiQgZ2l0IGluaXQKPHB1dCBmaWxlIHRoZXJlPgokIGdpdCBndWkKCjIuIFNoYXJlIHRoZSByZXBv
IHNvbWV3aGVyZSwgc28gaXQgd291bGQgYmUgYWNjZXNzaWJsZSBmcm9tIE9TIFggKHJlcG8Kc2hv
dWxkIHN0aWxsIGJlIG9uIFdpbmRvd3MgbWFjaGluZSkuCgozLiBDbG9uZSByZXBvIHRvIE9TIFgg
bWFjaGluZSBhbmQgc2VlIHRoZSB3ZWlyZCBiZWhhdmlvdXIuIEdpdCBzdGF0dXMKY2FuJ3QgZGVj
aWRlIGhvdyBmaWxlIHNob3VsZCBiZSBuYW1lZCwgIiVDQSVFRSVFRiVFOCVGRi50eHQiIG9yCiJc
MzEyXDM1NlwzNTdcMzUwXDM3Ny50eHQiLgoKJCBnaXQgY2xvbmUgL1ZvbHVtZXMvRXhjaGFuZ2Uv
dGVzdC8KSW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL1VzZXJzL2FnbGFkeXNo
L3Rlc3QvLmdpdC8KJCBjZCB0ZXN0CiQgZ2l0IHN0YXR1cwojIE9uIGJyYW5jaCBtYXN0ZXIKIyBV
bnRyYWNrZWQgZmlsZXM6CiMgICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBp
biB3aGF0IHdpbGwgYmUgY29tbWl0dGVkKQojCiMJJUNBJUVFJUVGJUU4JUZGLnR4dApub3RoaW5n
IGFkZGVkIHRvIGNvbW1pdCBidXQgdW50cmFja2VkIGZpbGVzIHByZXNlbnQgKHVzZSAiZ2l0IGFk
ZCIgdG8gdHJhY2spCiQgbHMKJUNBJUVFJUVGJUU4JUZGLnR4dAokIGdpdCBjbGVhbiAtZmQKUmVt
b3ZpbmcgJUNBJUVFJUVGJUU4JUZGLnR4dAokIGdpdCBzdGF0dXMKIyBPbiBicmFuY2ggbWFzdGVy
CiMgQ2hhbmdlZCBidXQgbm90IHVwZGF0ZWQ6CiMgICAodXNlICJnaXQgYWRkL3JtIDxmaWxlPi4u
LiIgdG8gdXBkYXRlIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpCiMKIwlkZWxldGVkOiAgICAiXDMx
MlwzNTZcMzU3XDM1MFwzNzcudHh0IgojCm5vIGNoYW5nZXMgYWRkZWQgdG8gY29tbWl0ICh1c2Ug
ImdpdCBhZGQiIGFuZC9vciAiZ2l0IGNvbW1pdCAtYSIpCgpBbGV4YW5kZXIuCg==
------=_Part_30645_29969461.1224230885025
Content-Type: application/zip; name=Copy.zip
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmeisni70
Content-Disposition: attachment; filename=Copy.zip

UEsDBAoAAAAAAGdZUTkAAAAAAAAAAAAAAAAJAAAAiq6vqO8udHh0UEsBAhQACgAAAAAAZ1lROQAA
AAAAAAAAAAAAAAkAAAAAAAAAAAAgAAAAAAAAAIqur6jvLnR4dFBLBQYAAAAAAQABADcAAAAnAAAA
AAA=
------=_Part_30645_29969461.1224230885025--
