Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C35AC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8345F616ED
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhF3Jtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:49:35 -0400
Received: from dd50212.kasserver.com ([85.13.141.11]:50476 "EHLO
        dd50212.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhF3Jte (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 05:49:34 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jun 2021 05:49:34 EDT
Received: from [192.168.178.21] (unknown [94.31.99.74])
        by dd50212.kasserver.com (Postfix) with ESMTPSA id 8A96D214021F
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 11:38:21 +0200 (CEST)
To:     git@vger.kernel.org
From:   Alan Blotz <work@blotz.org>
Subject: git difftool: No such file or directory
Message-ID: <176caa21-0232-9f21-7a8d-af136754e354@blotz.org>
Date:   Wed, 30 Jun 2021 11:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DB20C9CA958667993E76390C"
Content-Language: de-DE
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------DB20C9CA958667993E76390C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


--------------DB20C9CA958667993E76390C
Content-Type: text/plain; charset=UTF-8;
 name="git-bugreport-2021-06-30-1117.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git-bugreport-2021-06-30-1117.txt"

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5z
d2VyIHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3Vy
IGlzc3VlLgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3Rl
cHMgdG8gcmVwcm9kdWNlIHlvdXIgaXNzdWUpCgpta2RpciBicm9rZW4tZGlmZgpjZCBicm9r
ZW4tZGlmZgpnaXQgaW5pdApta2RpciBkaXIxCm1rZGlyIGRpcjIKdG91Y2ggZGlyMS9vcmln
CmNkIGRpcjIvCmxuIC1zIC4uL2RpcjEvb3JpZyBzeW0KY2QgLi4KZ2l0IGFkZCBkaXIqCmdp
dCBjaSAtbSAiaW5pdCIKZ2l0IGNoZWNrb3V0IC1iIGIKZ2l0IHJtIGRpcjIvc3ltIApnaXQg
Y2kgLW0gInJlbW92ZSIKZ2l0IGRpZmZ0b29sIC1kIG1hc3RlciBIRUFECgpXaGF0IGRpZCB5
b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQoKZ2l0IGRpZmZ0b29s
IHNoYWxsIGNvbXBhcmUgYm90aCBicmFuY2hlcy4KCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8g
KEFjdHVhbCBiZWhhdmlvcikKCmdpdCBkaWZmdG9vbCBwcmludHMgYW4gZXJyb3I6CgpmYXRh
bDogY291bGQgbm90IG9wZW4gJy90bXAvZ2l0LWRpZmZ0b29sLmw0VU03ZS9sZWZ0L2RpcjIv
c3ltJyBmb3Igd3JpdGluZzogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQoKUGxlYXNlIHJl
dmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxvdy4KWW91IGNhbiBkZWxldGUg
YW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLgoKCltTeXN0ZW0gSW5mb10KZ2l0
IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMzEuMQpjcHU6IHg4Nl82NApubyBjb21taXQgYXNz
b2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNpemVfdDog
OApzaGVsbC1wYXRoOiAvYmluL3NoCnVuYW1lOiBMaW51eCA1LjEyLjEyLTMwMC5mYzM0Lng4
Nl82NCAjMSBTTVAgRnJpIEp1biAxOCAxNDozMDo1MSBVVEMgMjAyMSB4ODZfNjQKY29tcGls
ZXIgaW5mbzogZ251YzogMTEuMApsaWJjIGluZm86IGdsaWJjOiAyLjMzCiRTSEVMTCAodHlw
aWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IC9iaW4vYmFzaAoKCltFbmFibGVkIEhvb2tz
XQo=
--------------DB20C9CA958667993E76390C--
