From: "Ping Yin" <pkufranky@gmail.com>
Subject: Why empty directory for submodule not checked out?
Date: Fri, 7 Dec 2007 23:36:58 +0800
Message-ID: <46dff0320712070736qc4a0966pf75a5b1372f3a131@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 16:37:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0fGe-0004h6-Av
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 16:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbXLGPhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbXLGPhJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 10:37:09 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:16119 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbXLGPhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 10:37:07 -0500
Received: by py-out-1112.google.com with SMTP id u77so1525301pyb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=R1LztrHXRZoGTnVoitZ2sUrPf82E5434ZdUXSyvVeos=;
        b=MVCBeli+QwNZY4o97ie53HLmeXrEqJ10Rkafa5umG0P7f31YWk6s+guxpFUsEgsh4u5DZpmpoM2aqGRBvoB//bQFaD0oIejIZ+UQBt9rhtdYUasUYHhg0FwWy3mAra9IlHAZGzb2tjfJitxKV4rYd5f3gCFGttBu3M0mEZZwgpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TMXt/f08sR860DN2UuawAq4MtgowBERySO9KHxiFzLJhTaSdaZK2vAJTLW5V7/oBKjQTt7jXty/VP26ecc2t11d87fjudkmj5uzaatgKGC9CUWaBXGm0Oz7eKeP0KKRgK+t69jq2OQ5YlAdEQ+dK24yWWd89h3JlI4Gw0AlkZyw=
Received: by 10.35.96.11 with SMTP id y11mr3546201pyl.1197041818299;
        Fri, 07 Dec 2007 07:36:58 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Fri, 7 Dec 2007 07:36:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67429>

It's so annoying to see so many empty directories when only few of all
submodules are checked out.

So, why empty directories? Does we have to technically or other considerations?

-- 
Ping Yin
