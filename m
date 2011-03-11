From: Ryan Sun <ryansun81@gmail.com>
Subject: test
Date: Fri, 11 Mar 2011 14:49:23 -0500
Message-ID: <AANLkTinBa09Hj0aSA0xHJz+VStQWtOAE5dWKhd_v7HSR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 20:49:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py8L3-00024y-V2
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 20:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab1CKTtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 14:49:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51051 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1CKTtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 14:49:24 -0500
Received: by iwn34 with SMTP id 34so2958664iwn.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=CVVs+m1vZHavvae9PLOsqxmgB5vuti1CpVPrA1z/0Sex3ZDHwz6zAv2MoYy4y4CKd8
         dE/QwAbiqJ3B4DVoSqb+8kYlJrsFJZO5AaAjjO4+V3Dwjc5vq3B+IiEgMlqypwbahNfu
         jVSeOVgK/aNjpzMSibACsgulnl8k1MdkfklV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FbjUx3uaK7dGUc0XeKRK+i4K4BtMvjenqxFCE817bdCD/275d1F4FgDBh3xlvkRgsu
         hSOp8qJlRxMUrrP7yT8zebIV/3QF4BAt5sz7UMz9Ct09Na6mEW1AWz1BIcZvgQn34/rC
         sser16hfVYOnurj/cZDY6YGH8EMoTNzDqR6y0=
Received: by 10.43.71.13 with SMTP id yi13mr12214233icb.432.1299872963470;
 Fri, 11 Mar 2011 11:49:23 -0800 (PST)
Received: by 10.42.228.74 with HTTP; Fri, 11 Mar 2011 11:49:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168922>

