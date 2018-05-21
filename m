Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAFE1F42D
	for <e@80x24.org>; Mon, 21 May 2018 10:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeEUKLM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 06:11:12 -0400
Received: from mail-io0-f205.google.com ([209.85.223.205]:48095 "EHLO
        mail-io0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeEUKLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 06:11:11 -0400
Received: by mail-io0-f205.google.com with SMTP id f9-v6so11783728iob.14
        for <git@vger.kernel.org>; Mon, 21 May 2018 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accudbgroup.com; s=google;
        h=mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=hQPiFOi8B2G/o710Ci+t5/oNaAtVMA8O/0TgJrHft9A=;
        b=oNMu0p4sOtUqHMKsKRQAI2Zw0LgmjKv0IyR115GPLJrAvueK5ndBFVh56Rx/rNDoyC
         CcqPtTYbnanXNXLZnR6MuJkSc6HMmmsOHMxsazPmPdWyQBGNN5CqWARlN0Ubw/bnTfvQ
         gOMb9p8weX+uY+6Q3+p3xeP9RyyEZzXhR9cSXt1ZupOW5vydsQoRaqIVBL2BNVk4T4Zt
         08SwQZ/LxC1J8ZnVtaI0bgglg09xZ0gaxyvQ18RQbhy3xcFT0AQz3YJI0sjeEyW5yu01
         TdxsIDz1ArpP2T+jFo2A/rO+mFTKW3EVSUfyWyDKtw5uqweF+zDScjmbEX7hLW8NmF2a
         yhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:message-id:date:subject:from:to
         :content-transfer-encoding;
        bh=hQPiFOi8B2G/o710Ci+t5/oNaAtVMA8O/0TgJrHft9A=;
        b=c50a7D3+DLxiyzrR4oppICVdqZLIgGp+Wonl7MoRAzX8nKTTc8wWs4STp9blUxA0eE
         +qZmsH2kyzLtWWS9Yr4jxPsHkeDxDY5SX27cVfcMEs17L1+iA7tHTQ463iRotopGifmi
         j2rBzhLcWuV3iTRGnP3lsu4ahjFKwlOAabgbeZT6ILbO6LM0czvnMM9krBGpKd/LNuwe
         k80dNyBPn6JHMoojpWbUAA+vHKX7oHg1zv4nOJ+JpsSwfNds9fXoElMKfUavVLnJbwSv
         XXltJ2ydt1IKGeP48zVbhxAoEySjlEHsVTy6ROJa+zJAccfIWv7YoeFO4w8NCA3tShG3
         Yc6g==
X-Gm-Message-State: ALKqPwfI+yFJpumkEEyGOqJBAarV1cPqGs0uW66XGW+DvGCiS+xoc8eB
        arRqh194UYkDLRo465vYVmNdNtub5QSm
X-Google-Smtp-Source: AB8JxZrAc806HFe3qDmu4Fx1EcOTjYSV0RCqZmWWnWfF1OmQhkafB6QtKZl9ETMV1KmFaEreq9YKkMuMtg==
MIME-Version: 1.0
X-Received: by 2002:a6b:e215:: with SMTP id z21-v6mr10574752ioc.121.1526897471117;
 Mon, 21 May 2018 03:11:11 -0700 (PDT)
Message-ID: <0000000000005fde85056cb485db@google.com>
Date:   Mon, 21 May 2018 10:11:11 +0000
Subject: Opt-in MSPs Contact List
From:   cheryl.goode@accudbgroup.com
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

IkhpIHRoZXJlLA0KDQpIb3BlIHRoaXMgbWFpbCBmaW5kcyB5b3Ugd2VsbC4NCg0KSSBhbSB3cml0
aW5nIHRoaXMgZW1haWwgdG8gaW5mb3JtIHlvdSB0aGF0IHdlIGhhdmUgZnJlc2ggdXBkYXRlZCBN
YW5hZ2VkICANClNlcnZpY2UgUHJvdmlkZXJzLShNU1BzKSBjb250YWN0cyB0byBpbmNyZWFzZSB5
b3VyIDIwMTggc2FsZXMuDQoNCllvdSBjYW4gdXNlIHRoZXNlIGRhdGFiYXNlIGZvciBkaXJlY3Qg
bWFpbGluZyBjYW1wYWlnbnMsIGVtYWlsIGNhbXBhaWducywgIA0KY29sZCBjYWxsaW5nLCBhbmQg
dG8gc2hhcmUgbmV3c2xldHRlci4NCg0KTGlzdCBDb250YWluczogTmFtZXMsIFRpdGxlLCBFbWFp
bCwgUGhvbmUsIENvbXBhbnkgTmFtZSwgQ29tcGFueSBVUkwsICANCkNvbXBhbnkgcGh5c2ljYWwg
YWRkcmVzcywgSW5kdXN0cnksIHdlYnNpdGUsIENvbXBhbnkgU2l6ZSwgUmV2ZW51ZSBhbmQgIA0K
RW1wbG95ZWUgRXRjLg0KDQrigKIgQWxsIGNvbXBhbnkgc2l6ZXMgYXZhaWxhYmxlLg0K4oCiIEFs
bW9zdCAxN2srIHRlY2hub2xvZ3kvdmVuZG9yIHVzZXJzIGF2YWlsYWJsZS4NCuKAoiBWZXJ5IGdv
b2QgY292ZXJhZ2UgZnJvbSBVUywgRU1FQSwgQVBBQyBhbmQgZXZlbiBMQVRBTS4NCuKAoiBDdXN0
b21pemF0aW9uIGFzIHBlciA4LTEwIGZpbHRlcnMuDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gZ2V0
IGJhY2sgdG8gbWUgd2l0aCB5b3VyIHRhcmdldCBjcml0ZXJpYSwgaWYgeW91ciAgDQpjcml0ZXJp
YSBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgYWJvdmUgbWVudGlvbmVkIGFwcGxpY2F0aW9ucyBsZXQg
bWUga25vdyB3ZSAgDQpoYXZlIGNsb3NlIHRvIDE3aysgdGVjaG5vbG9neSBpbnN0YWxsYXRpb25z
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpDaGVyeWwgR29vZGUNCk1hcmtldGluZyBBbmFseXN0DQoNCk5v
dGU6IFRoaXMgZW1haWwgaXMgbm90IGV4cGVjdGVkIHRvIGJlIGEgc3BhbS4gSXQgd291bGQgYmUg
aWRlYWwgaWYgeW91ICANCmFja25vd2xlZGdlIG91ciBjb25jaWxpYXRvcnkgc2VudGltZW50cyBh
bmQgYW5zd2VyIGluIHRoZSBzdWJqZWN0IHRha2luZyAgDQp3aXRoIGxlYXZlIG9mZiB0byBiZSBl
eHBlbGxlZCBmcm9tIG91ciBNYWlsaW5nIGxpc3QuIFdoeSBub3QgdHJ5IGl0L3VzIG91dD8NCiIN
Cg==
