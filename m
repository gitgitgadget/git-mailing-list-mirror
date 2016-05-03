From: Lev <leventelist@gmail.com>
Subject: remotes
Date: Tue, 3 May 2016 18:16:24 +0200
Message-ID: <20160503181624.1504eb0a@laborpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 18:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axdXA-0007zG-Le
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbcECQun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:50:43 -0400
Received: from mail1.kabelnet.hu ([79.121.0.7]:54661 "EHLO mail.kabelnet.hu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755635AbcECQum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:50:42 -0400
X-Greylist: delayed 2048 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 May 2016 12:50:42 EDT
Received: from 5e1be956.mobile.pool.telekom.hu ([94.27.233.86] helo=chacha.levafreebsd.org)
	by mail.kabelnet.hu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <leventelist@gmail.com>)
	id 1axczr-0004TX-9L
	for git@vger.kernel.org; Tue, 03 May 2016 18:16:29 +0200
Received: from laborpc (unknown [192.168.1.179])
	by chacha.levafreebsd.org (Postfix) with ESMTPS id 23AB3E9F1B6
	for <git@vger.kernel.org>; Tue,  3 May 2016 18:16:25 +0200 (CEST)
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; i586-pc-linux-gnu)
X-Spam-Score: 3.4 (+++)
X-Spam-Report: Spam detection software, running on the system "spamd2.kabelnet.hu",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Dear List, I accidentally added a remote of another repository
    to my config file. And so I merged two different repositories together. Is
    there any real user case for this? Is there any way to prevent this happening?
    [...] 
 Content analysis details:   (3.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 FSL_HELO_NON_FQDN_1    No description available.
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail provider
                             (leventelist[at]gmail.com)
  0.0 DKIM_ADSP_CUSTOM_MED   No valid author signature, adsp_override is
                             CUSTOM_MED
  1.7 MIME_BASE64_TEXT       RAW: Message text disguised using base64 encoding
  0.8 RDNS_NONE              Delivered to internal network by a host with no rDNS
  0.9 NML_ADSP_CUSTOM_MED    ADSP custom_med hit, and not from a mailing list
X-Scan-Signature: 9524fb9e753911cde8111ed9f87fc0b5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293416>

RGVhciBMaXN0LA0KDQoNCkkgYWNjaWRlbnRhbGx5IGFkZGVkIGEgcmVtb3RlIG9mIGFub3RoZXIg
cmVwb3NpdG9yeSB0byBteSBjb25maWcgZmlsZS4gQW5kIHNvIEkNCm1lcmdlZCB0d28gZGlmZmVy
ZW50IHJlcG9zaXRvcmllcyB0b2dldGhlci4gSXMgdGhlcmUgYW55IHJlYWwgdXNlciBjYXNlIGZv
cg0KdGhpcz8gSXMgdGhlcmUgYW55IHdheSB0byBwcmV2ZW50IHRoaXMgaGFwcGVuaW5nPw0KDQpU
aGFua3MsDQpMZXYNCg==
