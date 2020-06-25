Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68C7C433E2
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2C4207E8
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405189AbgFYNqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:46:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404714AbgFYNqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:46:23 -0400
Received: from mail.ifta.com ([80.152.142.24]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPA (Nemesis) id
 1MekGB-1jEIZd4AIX-00ai6t; Thu, 25 Jun 2020 15:46:21 +0200
Received: from mail.ifta.com [127.0.0.1] by mail.ifta.com with David.fx (0554.4743464A4E474B484A52);
 25 Jun 2020 13:46:21 UT
From:   "Daniel Dyk" <Daniel.Dyk@ifta.com>
Subject: Re-2: Capital letters do not work when using vi as git editor
To:     "Philip Oakley" <philipoakley@iee.email>, <git@vger.kernel.org>
Date:   Thu, 25 Jun 2020 13:46:21 +0000
X-Priority: 3 (Normal)
Importance: normal
X-Mailer: david by Tobit.Software, Germany (0554.4743464A4E474B484A52), Mime Converter 101.20
X-David-Sym: 0
X-David-Flags: 0
Message-ID: <000232E3.5EF4C6CC@mail.ifta.com>
MIME-Version: 1.0
In-Reply-To: <1eccf3a5-cce2-2109-5e04-ed9f43105a57@iee.email>
References: <000232C3.5EF496D0@mail.ifta.com>
 <1eccf3a5-cce2-2109-5e04-ed9f43105a57@iee.email>
Content-Type: text/plain;
 charset="utf-8"
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:2Ck3ye+lmV8gyevuHE2NR/wPANLZDbAc1SLS/eDIwY04/fC5Cg9
 jvDDutE9KCAMIEaTjksp7dBKCqoyyGEL9dh7Gg1TYEKwKHgzKxl3McJ/sUSCbuY5FcH21Kg
 27m68b7xzvkBRZiJ/HFyQHaeafB3lHsXfLfmR6DF0/OFAVkKY+Hbg47lpMEkpx4cOiKPCiW
 sl4BpVLNkbiSAk+/jc2eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i+k4DUsNbPI=:qe5tS9CXcJp+8JeA79fLxi
 hCMoRPTEONYOvrfy98J1nxoUUeAgALNdS6JdWX6cZhLKR5lUUzfLmd3kAP5dZPPGjOJ0HcayV
 5/h37zVwV2Cpd4qUxOJagLsBbQUPRtpTQiWXRBRKBeweuDKIz3V7I1KdpJAeHBMG+o8pU2WpE
 k8jCOuptXff7Bh/Nv7+vxkIam9RFZzrQ6zGDyj27iQQoaldCVSAT3uFkeV2sNtnjHDRdy+Xkl
 knq7oxpRRO4g4A716UCqbDZAZT6Vv9xH4+9drNicd5To8KC4AyM0IKACkhjiLHGYvOjBN3rlG
 k7AbKT+Qrj6X9PHwG7qd8rtCjT5Skjm8Yd02hZcagCtfCp84XtMeEx900mCjZIpcaAZ9NtqG9
 UnUVBmPqfjLiIXQL5pQV2NLNNEK/lMuUnbEzcz9SWk17YkuzpxCQeo7es4sr2VxaRCE+DLCiU
 L90MtzLBf5rr6aPghMoTI50+ZN0xRBWn69QxMTh+Wx0fTwYp2jqpZj7QYPcJ0r27eA9XAVxDt
 irJXjnJVwZO67G+T8wtY0e/gtFsDuqA6dIHvi6FUORHqoi5ckls9/1SY/E0luoX7MoX/ASsPT
 RlaD/2bzluFm362p8bECFJW4HEmUf0PHw7eQGARX664a+rgKpk+jdb0XwTCJRLJSmyVww6F8h
 pVLqtBDfv/wgpsHmtu/6EdFoVdH9+gLKPKfgKilA4xvizV5i1sC9dkrvo5CsXWuGWVQa447n+
 xVCDgx6I1Ipmj8nJky3jAQxh6hwXgKI5CD5ZSEvgrKIjcAQt/uxRo9dYJgDeeYGhFAVw84M4x
 RXPXEOBTjD5nijPbVOVRvGt26vaGInDBq/gSywYQRRhJ/RTQNmCW1NDDFhAgtjz7s/BPm9n
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpJbnN0YWxsaW5nIHRoZSBsYXRlc3Qgc25hcHNob3QgcmVzb2x2ZWQgaXQsIHRoYW5rcy4gDQoN
CkRhbmllbA0KDQotLS0tLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tLS0tDQpCZXRyZWZmOiBS
ZTogQ2FwaXRhbCBsZXR0ZXJzIGRvIG5vdCB3b3JrIHdoZW4gdXNpbmcgdmkgYXMgZ2l0IGVkaXRv
ciAoMjUuIEp1bmkgMjAyMCwgMTU6MzkpDQpWb246ICAgICBQaGlsaXAgT2FrbGV5IDxwaGlsaXBv
YWtsZXlAaWVlLmVtYWlsPg0KQW46ICAgICAgRGFuaWVsIER5ayA8RGFuaWVsLkR5a0BpZnRhLmNv
bT4NCiAgICAgICAgIGdpdEB2Z2VyLmtlcm5lbC5vcmcgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+DQoN
Cj4gT24gMjUvMDYvMjAyMCAxMToyMSwgRGFuaWVsIER5ayB3cm90ZToNCj4gPiBIaSBnaXQtZGV2
cywNCj4gPg0KPiA+DQo+ID4gSSBpbnN0YWxsZWQgZ2l0IDIuMjcuMCBvbiBhIGZyZXNoIFdpbmRv
d3MgMTAgc3lzdGVtLCB0aGVyZSB3aGVyZSBubyBvbGQgDQo+ID4gaW5zdGFsbGF0aW9ucyBvZiBt
aW5ndyBvciBnaXQuIFVuZm9ydHVuYXRseSBJIGhhdmUgZW5jb3VudGVyZWQgYSBidWcgd2l0aCAN
Cj4gPiB2aW0gd2hlbiBkb2luZyAnZ2l0IHJlYmFzZSAtaScgb3IgJ2dpdCBjb21taXQnOg0KPiA+
DQo+ID4gSSBhbSBub3QgYWJsZSB0byB0eXBlIGNhcGl0YWwgbGV0dGVycywgc28gY29tbWFuZHMg
Zm9yIHNlbGVjdGluZyByb3dzICg8DQo+ID4gU2hpZnQ+ViksIHBhc3RpbmcgYWJvdmUgKDxTaGlm
dD5QKSBldGMgYXJlIG5vdCB3b3JraW5nLiBJIGFtIGFsc28gbm90IGFibGUgDQo+ID4gdG8gdHlw
ZSAnQUJDREUnIGluIGluc2VydGlvbiBtb2RlLiBTbWFsbCBsZXR0ZXJzIGFuZCBjYXBpdGFsIHVt
bGF1dHMgKMOEw5bDnCkgDQo+ID4gd29yay4gSWYgSSBvcGVuIHRoZSB2aSB3aXRob3V0IGdpdCwg
SSBjYW4gdHlwZSB0aGUgY2FwaXRhbCBsZXR0ZXJzLiBJZiBJIA0KPiA+IHVzZSBuYW5vIGFzIGVk
aXRvciwgSSBjYW4gdHlwZSBjYXBpdGFsIGxldHRlcnMgYXMgd2VsbC4gDQo+ID4NCj4gPiBEb3du
Z3JhZGluZyB0byBnaXQgMi4yNC4xLjIgc29sdmVkIHRoZSBwcm9ibGVtIGZvciBub3cgKEkgZG91
YmxlIGNoZWNrZWQgDQo+ID4gYW5kIHJlaW5zdGFsbGVkIDIuMjcuMCBhZ2FpbiA9PiBzYW1lIGlz
c3VlKS4NCj4gPg0KPiBJZiBJIHJlbWVtYmVyIGNvcnJlY3RseSB0aGlzIG9jY3VycmVkIGJlY2F1
c2Ugb2YgY2hhbmdlcyB0byB0aGUgdGVybWluYWwNCj4gc3VwcG9ydCB1c2VkLiBJdCdzIGJlZW4g
cmVwb3J0ZWQgb24gdGhlIEdpdC1mb3ItV2luZG93cyBJc3N1ZXMgWzFdIGxpc3QNCj4gYW5kIGEg
ZnJlc2ggc25hcHNob3QgWzJdIGNyZWF0ZWQgdGhhdCByZXNvbHZlcyB0aGUgcHJvYmxlbSAuDQo+
IA0KPiBQaGlsaXANCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vZ2l0LWZvci13aW5kb3dz
L2dpdC9pc3N1ZXMvMjY4OQ0KPiBbMl0gaHR0cHM6Ly93aW5naXQuYmxvYi5jb3JlLndpbmRvd3Mu
bmV0L2ZpbGVzL2luZGV4Lmh0bWwNCg0KDQpUbzogcGhpbGlwb2FrbGV5QGllZS5lbWFpbA0KICAg
IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCg==


