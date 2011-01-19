From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Wed, 19 Jan 2011 11:04:26 +0100
Message-ID: <AANLkTimt=H=MWbk7uHTXBudQ94Oqme5Gi+js8NQu0GjW@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
	<loom.20110118T083048-91@post.gmane.org>
	<20110119000735.GA29212@dpotapov.dyndns.org>
	<loom.20110119T090252-99@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfUu2-0005nl-1k
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab1ASKE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:04:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45874 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab1ASKE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:04:28 -0500
Received: by fxm20 with SMTP id 20so674088fxm.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 02:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iLuNt9msx2gM81B0QaCC1pbG/1SqsMzh38u8BUB38k8=;
        b=TQ7LjW3a4LhmoYy5F4IK0RTGGNPeyhYLwXInqDVX9sEhcyFNkKVgHZqSMy/7fzVHon
         sKUNqhPZUS0f+vajFP8n1xJIIq48f3W/XoPDX6hqxm56VjsLDdCDR23zHKlVceZc81kC
         dnaq0oa163fz1zkokVw0pXYpx0omF5Jhyqjdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XWeZQ4JsYsxgKW6a7EoUQfZf4YBze03qRhMuj7KS5SmWtJet5ZQDVNP7bV2Cx3WYO0
         tN73Q+h/Vk2OTGH2dsNBDRxvIhYGChtEXQYVcQ10gTUdKixeccFAPk0g7BzuD+7tZJjf
         CyDEm/8vkIcXJl1KEWn7VRDo1NSfAsBt1IB6Y=
Received: by 10.223.114.135 with SMTP id e7mr503831faq.78.1295431466803; Wed,
 19 Jan 2011 02:04:26 -0800 (PST)
Received: by 10.223.72.14 with HTTP; Wed, 19 Jan 2011 02:04:26 -0800 (PST)
In-Reply-To: <loom.20110119T090252-99@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165254>

T24gV2VkLCBKYW4gMTksIDIwMTEgYXQgMDk6MzYsIEFsZXhleSBTaHVta2luIDx6YXBwZWRAbWFp
bC5ydT4gd3JvdGU6Cj4gRG1pdHJ5IFBvdGFwb3YgPGRwb3RhcG92IDxhdD4gZ21haWwuY29tPiB3
cml0ZXM6Cj4+Cj4+IEluIHRoZSBhYm92ZSBzZW50ZW5jZSwgJ9C60LDQttC10YLRgdGPJyBpcyBu
b3QgYW4gaW50cm9kdWN0b3J5IHdvcmQsIGFuZCB0aHVzCj4+IG5vIGNvbW1hIGlzIHJlcXVpcmVk
LiBGb3IgZGV0YWlscywgc2VlICMyIGF0Cj4+IGh0dHA6Ly9ydS53aWt0aW9uYXJ5Lm9yZy93aWtp
LyVEMCVCQSVEMCVCMCVEMCVCNiVEMCVCNSVEMSU4MiVEMSU4MSVEMSU4Rgo+Pgo+PiBIb3dldmVy
LCBzdWNoIHVzZSBvZiAn0LrQsNC20LXRgtGB0Y8nIGlzIG1vcmUgYXBwcm9wcmlhdGUgZm9yIGNv
bGxvcXVpYWwgc3BlZWNoCj4+IHRoYW4gZm9yIGRvY3VtZW50YXRpb24gb3IgZXZlbiBjb21wdXRl
ciBtZXNzYWdlcy4gQWxzbywgSSBoYXZlIG5ldmVyIHNlZW4KPj4gJ3VucmVzb2x2ZWQgY29uZmxp
Y3RzJyBiZWluZyB0cmFuc2xhdGVkIGFzICfQvdC10L7QsdGA0LDQsdC+0YLQsNC90L3Ri9C1INC6
0L7QvdGE0LvQuNC60YLRiycuCj4+IElNSE8sIHRoZSBzdGFuZGFyZCB0ZXJtIGlzICfQvdC10YDQ
sNC30YDQtdGI0LXQvdC90YvQtSDQutC+0L3RhNC70LjQutGC0YsnLiBTbyBteSBzdWdnZXN0aW9u
IGlzOgo+Pgo+PiDQpNCw0LnQuyAlcyDQvNC+0LbQtdGCINGB0L7QtNC10YDQttCw0YLRjCDQvdC1
0YDQsNC30YDQtdGI0LXQvdC90YvQtSDQutC+0L3RhNC70LjQutGC0YsuCj4+CgpCdXQgdGhpcyB3
b3VsZCBiZSB3cm9uZy4gSXQgaXMgYWJzb2x1dGVseSBub3QgdGhlIG9yaWdpbmFsCm1lc3NhZ2Ug
dHJpZWQgdG8gc2F5LiBBbnkgZmlsZSBjYW4gY29udGFpbiB1bnJlc29sdmVkIGNvbmZsaWN0cwoo
bWFya2VycykuIFRoZSBwb2ludCBpczogdGhpcyBwYXJ0aWN1bGFyIGZpbGUgdmVyeSBsaWtlbHkg
ZG9lcy4KCj4gQXMgSSB1bmRlcnN0YW5kIGV4YWN0IG1lYW5pbmcgb2YgcGhyYXNlICJGaWxlICVz
IHNlZW1zIHRvIGhhdmUgdW5yZXNvbHZlZAo+IGNvbmZsaWN0cyIgKG5vdGUgKnNlZW1zKiB3b3Jk
IGhlcmUpIGlzIGEgc3VwcG9zaXRpb24uIEl0IGlzIG5vdAo+IGFuIGVxdWl2YWxlbnQgb2YgIm1h
eSBoYXZlIiAoYnV0ICJtYXkgbm90IGhhdmUiKS4KPiBTbywgSSBhZ3JlZSBzZW50ZW5jZSBtdXN0
IHJlcGhyYXNlZCBidXQgc3VwcG9zaXRpb24gbXVzdCBiZSByZXRhaW5lZC4KPiBTb21ldGhpbmcg
bGlrZSAi0KTQsNC50LsgJXMsINC/0L7RhdC+0LbQtSwg0YHQvtC00LXRgNC20LjRgiDQvdC10YDQ
sNC30YDQtdGI0LXQvdC90YvQtSDQutC+0L3RhNC70LjQutGC0YsiCgpXaGlsZSBJIGxpa2UgdGhp
cyBvbmUsIGl0IGlzIG5vdCBtdWNoIGJldHRlciBzZW1hbnRpY2FsbHksIHRoYW4gdGhlCnByZXZp
b3VzIHdpdGggcHVuY3R1YXRpb24gY29ycmVjdGVkLiBTbyB1bmxlc3MgdGhlcmUgYXJlIG1vcmUg
dm90ZXMKZm9yIGl0LCBJIHdpbGwgbm90IHJlc2VuZCB0aGUgdHJhbnNsYXRpb24uCkNhbm5vdCBm
b3JiaWQgeW91IGZyb20gZG9pbmcgdGhpcywgdGhvdWdoIChhbmQgcGVyc29uYWxseSB3b3VsZCBs
aWtlCnRvIHNlZSBhIG5hbWUgb2YgYW5vdGhlciBuYXRpdmUgcnVzc2lhbiBzcGVha2VyIGluIHRo
ZSBhdXRob3JzIG9mCnRyYW5zbGF0aW9ucykuCgo+IG9yIGJldHRlciAi0J/RgNC10LTQv9C+0LvQ
vtC20LjRgtC10LvRjNC90L4g0YTQsNC50LsgJXMg0YHQvtC00LXRgNC20LjRgiDQvdC10YDQsNC3
0YDQtdGI0LXQvdC90YvQtSDQutC+0L3RhNC70LjQutGC0YsiCj4gKHN0YXkgb2ZmaWNpYWwgYnV0
IHN1cHBvc2luZykKCiJTdXBwb3NlZGx5IGZpbGUgIi4uLj8K
