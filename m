From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Initial Japanese gitk translation
Date: Mon, 6 Apr 2009 16:01:17 +0300
Message-ID: <94a0d4530904060601o16fe8200m83423eec94d0ced9@mail.gmail.com>
References: <FD6CAD0757FA434C91E904C1F202CBA1@DELL300>
	 <7vws9ymudz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: FORS Luis <l-fors@cerca-jp.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoTX-0006WQ-2a
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbZDFNBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbZDFNBV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:01:21 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37660 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbZDFNBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:01:20 -0400
Received: by fxm2 with SMTP id 2so1872746fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jX4Rv1EJtT/cYf3r67ycUuwV2x25cakmIIes/aiaxXg=;
        b=maFj3JpIwygz/12jPawnJA6bj2lwbI1TzPuywPKvqsoO060naiBnyZIdmvX4PC1eq3
         lu0tbP+n6MzVK1znOz6xof8kyu510K8TlGL7nZnJngX461tLR2lw6gUJRlBoLw/fQfOc
         KkJuTYzbFKZcJuILahkTNO4kL9/E1ApYuO1dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g1WerUSfr7BNDxvJscJaPTNPHJTyJfZxnSlPXZKCSngNj2lzHKZlUjEiNQ9N06ljic
         w0nyqxNA8SE8oedm0AnyGDzyGpunMx0RHLtmuum67qq+gtntaecesnjE6L4pxJbktarc
         CoPnEalh7Q1DeqJnGjdTancyLfIT471OK7XTM=
Received: by 10.86.61.13 with SMTP id j13mr3165900fga.68.1239022877139; Mon, 
	06 Apr 2009 06:01:17 -0700 (PDT)
In-Reply-To: <7vws9ymudz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115817>

T24gTW9uLCBBcHIgNiwgMjAwOSBhdCA0OjQwIEFNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyb3RlOgo+ICJGT1JTIEx1aXMiIDxsLWZvcnNAY2VyY2EtanAuY29tPiB3cml0
ZXM6Cj4+ICsjOiBnaXRrOjM0MAo+PiArbXNnaWQgIk5vIGZpbGVzIHNlbGVjdGVkOiAtLW1lcmdl
IHNwZWNpZmllZCBidXQgbm8gZmlsZXMgYXJlIHVubWVyZ2VkLiIKPj4gK21zZ3N0ciAi44OV44Kh
44Kk44Or44GM6YG45oqe44GV44KM44Gm44GE44G+44Gb44KT77yaLS1tZXJnZeOCquODl+OCt+OD
p+ODs+OBjOaMh+WumuOBleOCjOOBn+OBruOBq+acquODnuODvOOCuOODleOCoeOCpOODq+OBr+OB
guOCiuOBvuOBm+OCk+OAgiIKPj4gKwo+PiArIzogZ2l0azozNDMKPj4gK21zZ2lkICJObyBmaWxl
cyBzZWxlY3RlZDogLS1tZXJnZSBzcGVjaWZpZWQgYnV0IG5vIHVubWVyZ2VkIGZpbGVzIGFyZSB3
aXRoaW4gZmlsZSBsaW1pdC4iCj4+ICttc2dzdHIgIuODleOCoeOCpOODq+OBjOmBuOaKnuOBleOC
jOOBpuOBhOOBvuOBm+OCk++8mi0tbWVyZ2Xjgqrjg5fjgrfjg6fjg7PjgYzmjIflrprjgZXjgozj
gZ/jga7jgavpgbjmip7jgZXjgozjgZ/jg5XjgqHjgqTjg6vmnKrjg57jg7zjgrjjg5XjgqHjgqTj
g6vjgpLlkKvjgb/jgb7jgZvjgpPjgIJObyBoYXkgYXJjaGl2b3Mgc2VsZWNjaW9uYWRvczogc2Ug
c2VsZWNjaW9uw7MgbGEgb3BjacOzbiAtLW1lcmdlIHBlcm8gbG9zIGFyY2hpdm9zIGVzcGVjaWZp
Y2Fkb3Mgbm8gbmVjZXNpdGFuIGZ1c2nDs24uIgo+Cj4gTm8gaGFibGEgRXNwYcOxb2wsIHBlcmTD
s25hbWUuCgpzL2hhYmxhL2hhYmxvLyA6KQoKLS0gCkZlbGlwZSBDb250cmVyYXMK
