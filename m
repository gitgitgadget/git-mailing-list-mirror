From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH/resent 0/9] Sparse checkout (first half)
Date: Wed, 1 Oct 2008 19:09:04 +0700
Message-ID: <fcaeb9bf0810010509m4d2045e4qcc2a887c180a787@mail.gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0810010320v340230f0jb443bafc1ef05d6f@mail.gmail.com>
	 <adf1fd3d0810010425r145396b0t52cf883576da8bbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 14:10:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl0X5-0007mU-VH
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 14:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYJAMJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYJAMJH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 08:09:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:16032 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYJAMJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 08:09:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so378403fgg.17
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=w/Bl0ALyps26fGWc17U0sy8VkRdPMd30mGqrqU9Fjwo=;
        b=FPI8BPKR5ZW2Rrz6T79hCN5g/MsyU96cNMvPJHRXzG56jISlgfb5jNtr/Gxl+qSL0A
         GcJeCqjE/seoYWHX3VUtrXguhbrcSLh9XM8GDz2M+KpbTKscDx0JZFUmARcYlBH33hdt
         X2bgts970xLxJocRs0Ii6vuDfzxb/6y5rF0+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nBkngy2azebVFP10Y7/osILzKzYb6YlUeAAEPHYT6CZejHJs9qGDPsy90qaUdVuu4U
         Il+0LjRe8TYFVGU9EAFATE7dZWPgnuJbegX9mo72fRu+HNXvLEEAooKw0rFt0tdNl6aW
         TKnrZMvfYVDcf92oo6TQf5BEIaUjFalBSViiY=
Received: by 10.86.79.19 with SMTP id c19mr6941212fgb.67.1222862944863;
        Wed, 01 Oct 2008 05:09:04 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Wed, 1 Oct 2008 05:09:04 -0700 (PDT)
In-Reply-To: <adf1fd3d0810010425r145396b0t52cf883576da8bbd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97219>

T24gMTAvMS8wOCwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5hLm5ldD4gd3JvdGU6Cj4gT24g
V2VkLCBPY3QgMSwgMjAwOCBhdCAxMjoyMCBQTSwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5h
Lm5ldD4gd3JvdGU6Cj4gID4gTm90IGluIHRoaXMgaGFsZiBidXQgSSd2ZSBzZWVuIHRoYXQgeW91
IGFkZGVkIGEgLS1kZWZhdWx0LXNwYXJzZSBmbGFnCj4gID4gdG8gImdpdCBjbG9uZSIuIEkgdGhp
bmsgaXQgaXMgdXNlbGVzcyBhcyBtb3N0bHkgYWx3YXlzIHRoZSBvbmUgZ2l2ZW4KPiAgPiBpbiAt
c3BhcnNlLWNoZWNrb3V0IHNob3VsZCBiZSB1c2VkLgo+Cj4KPiBUbyBiZSBtb3JlIHByZWNpc2Us
IHdoZW5ldmVyIHlvdSBkbyAiZ2l0IGNsb25lIC0tc3BhcnNlLWNoZWNrb3V0IiB5b3UKPiAgd2ls
bCB3YW50IGl0IHRvIGJlIHRoZSBkZWZhdWx0IHNwYXJzZSBwYXR0ZXJuLgoKWWVzLCBpZiBvbmx5
IHRoZSBkZWZhdWx0IHBhdHRlcm4gZ2V0cyB1cGRhdGVkIHByb3Blcmx5IHdoZW4geW91IHVwZGF0
ZQp5b3VyIGNoZWNrb3V0IGFyZWEuIElmICJnaXQgY2xvbmUgLS1zcGFyc2UtY2hlY2tvdXQiIG1h
a2VzIHRoZSBkZWZhdWx0CnBhdHRlcm4sIHRoZW4gImdpdCBjaGVja291dCAtLXJlc2V0LXNwYXJz
ZSIgc2hvdWxkIHJlc2V0IHRoZSBkZWZhdWx0CnBhdHRlcm4gYXMgd2VsbC4gVGhlIGhhcmQgcGFy
dCBpcyBob3cgdG8gdXBkYXRlIGRlZmF1bHQgcGF0dGVybiB3aXRoCi0taW5jbHVkZS1zcGFyc2Ug
YW5kIC0tZXhjbHVkZS1zcGFyc2UuIEFsc28sIHBlb3BsZSBjYW4gdXNlICJnaXQKdXBkYXRlLWlu
ZGV4IiB0byB1cGRhdGUgY2hlY2tvdXQgYXJlYSwgd2hpY2ggc2hvdWxkIG5vdCB0b3VjaCBkZWZh
dWx0CnBhdHRlcm4gYXQgYWxsLiBNYXliZSBqdXN0IHRocm93IGEgd2FybmluZyB3aGVuIGRlZmF1
bHQgcGF0dGVybiBubwpsb25nZXIgbWF0Y2hlcyB0aGUgY2hlY2tvdXQgYXJlYSwgdGhlbiBsZXQg
dGhlbSBkZWNpZGUuCi0tIApEdXkK
