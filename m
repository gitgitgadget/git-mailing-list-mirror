From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 12:48:32 +0200
Message-ID: <adf1fd3d0809200348h1170e8cm302e92043da8995d@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 12:49:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh024-0003Nq-WA
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYITKsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 06:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbYITKsg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:48:36 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:39273 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYITKsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:48:35 -0400
Received: by mu-out-0910.google.com with SMTP id g7so659113muf.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:48:32 -0700 (PDT)
Received: by 10.103.238.4 with SMTP id p4mr934306mur.66.1221907712621;
        Sat, 20 Sep 2008 03:48:32 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Sat, 20 Sep 2008 03:48:32 -0700 (PDT)
In-Reply-To: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96354>

T24gU2F0LCBTZXAgMjAsIDIwMDggYXQgMTI6MDEgUE0sIE5ndXnhu4VuIFRow6FpIE5n4buNYyBE
dXkKPHBjbG91ZHNAZ21haWwuY29tPiB3cm90ZToKPgo+IE5ndXnhu4VuIFRow6FpIE5n4buNYyBE
dXkgKDE0KToKPiAgRXh0ZW5kIGluZGV4IHRvIHNhdmUgbW9yZSBmbGFncwo+ICBJbnRyb2R1Y2Ug
Q0VfTk9fQ0hFQ0tPVVQgYml0Cj4gIGxzLWZpbGVzOiBhZGQgb3B0aW9ucyB0byBzdXBwb3J0IHNw
YXJzZSBjaGVja291dAo+ICB1cGRhdGUtaW5kZXg6IHJlZmFjdG9yIG1hcmtfdmFsaWQoKSBpbiBw
cmVwYXJhdGlvbiBmb3IgbmV3IG9wdGlvbnMKPiAgdXBkYXRlLWluZGV4OiBhZGQgLS1jaGVja291
dC8tLW5vLWNoZWNrb3V0IHRvIHVwZGF0ZSBDRV9OT19DSEVDS09VVCBiaXQKPiAgbHMtZmlsZXM6
IEFkZCB0ZXN0cyBmb3IgLS1zcGFyc2UgYW5kIGZyaWVuZHMKPiAgUHJldmVudCBkaWZmIG1hY2hp
bmVyeSBmcm9tIGV4YW1pbmluZyB3b3JrdHJlZSBvdXRzaWRlIHNwYXJzZSBjaGVja291dAo+ICBj
aGVja291dF9lbnRyeSgpOiBDRV9OT19DSEVDS09VVCBvbiBjaGVja2VkIG91dCBlbnRyaWVzLgo+
ICBncmVwOiBza2lwIGZpbGVzIG91dHNpZGUgc3BhcnNlIGNoZWNrb3V0IGFyZWEKPiAgbHMtZmls
ZXM6IHN1cHBvcnQgInNwYXJzZSBwYXR0ZXJucyIsIHVzZWQgdG8gZm9ybSBzcGFyc2UgY2hlY2tv
dXQgYXJlYXMKPiAgdW5wYWNrX3RyZWVzKCk6IGFkZCBzdXBwb3J0IGZvciBzcGFyc2UgY2hlY2tv
dXQKPiAgY2xvbmU6IHN1cHBvcnQgc3BhcnNlIGNoZWNrb3V0IHdpdGggLS1uYXJyb3ctcGF0aCBv
cHRpb24KPiAgY2hlY2tvdXQ6IGFkZCBuZXcgb3B0aW9ucyB0byBzdXBwb3J0IHNwYXJzZSBjaGVj
a291dAo+ICB3dC1zdGF0dXM6IFNob3cgb3JwaGFuZWQgZW50cmllcyBpbiAiZ2l0IHN0YXR1cyIg
b3V0cHV0Cj4KCkkgd291bGQgbGlrZSB0byB0ZXN0IGl0LCBkbyB5b3UgaGF2ZSBhIHB1YmxpYyBy
ZXBvIHRvIGZldGNoIGl0PwoKU2FudGkK
