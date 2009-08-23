From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 14/14] Add README and gitignore file for MSVC build
Date: Sun, 23 Aug 2009 13:26:08 -0300
Message-ID: <a4c8a6d00908230926of0ea10bhd8f66e7d37c3b39b@mail.gmail.com>
References: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
	 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
	 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
	 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
	 <4b8b550914cfc4e638ff905d9b9aa416e45913f4.1250860247.git.mstormo@gmail.com>
	 <ba4e68ae32784d8e0c706fa665fbdbbfe67ce673.1250860247.git.mstormo@gmail.com>
	 <6dd71f163e5410e401fc66088405736d1978ec55.1250860247.git.mstormo@gmail.com>
	 <cover.1250860247.git.mstormo@gmail.com>
	 <54673ddb6bef681194e141e5e05e930cdfaa07bc.1250860247.git.mstormo@gmail.com>
	 <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 18:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfFtb-0001tR-7s
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 18:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbZHWQ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933923AbZHWQ0I
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 12:26:08 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:60034 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911AbZHWQ0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 12:26:06 -0400
Received: by yxe5 with SMTP id 5so1233904yxe.33
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jg6uECmx/FMy7o2oM/ZUMCChcoRNycOY50+Mo5XxziA=;
        b=nMFQQW6sH7fjxfa1l1IspyvSPDiH1snlYwdiuzYL660VLyDczVt2iUFEM1RqdYwF/x
         mFwPUL7Tei/nS32iOj9tyEsI+FzC8KeNTy9XNue4AvYMzJAqQEUIuYt3yWL6u/9Arnwr
         ZqDpaoCdaZ8B9nPxOT8YyM7binI9sXNiKoj7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hjjfMzgyQJTotg3eGuTFaV3tum2hwMngmwKQReyK6NQTQ06rrEGKHep3jXgPKR8CnO
         mrFIcIdYSkurmxXHgBQM9BwGZ2hp/rzpaEJAloUxI6m5SJbP1qeXSbxLJWZQhGdMnrlV
         IZZHVVkjhOdDDHlfQNXckJDpPIsmwavEWLKUY=
Received: by 10.101.113.12 with SMTP id q12mr3473249anm.124.1251044768467; 
	Sun, 23 Aug 2009 09:26:08 -0700 (PDT)
In-Reply-To: <e82f1930173966ebb6b2d2815e037a26e079f969.1250860247.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126859>

Hi,

On Fri, Aug 21, 2009 at 10:30 AM, Marius Storm-Olsen<mstormo@gmail.com> wrote:
> From: Frank Li <lznuaa@gmail.com>
>
> +3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
F7 does nothing in VS2008, to build the solution you have to press
Ctrl+Shift+B. To build and start debugging you have to press F5, and
for start without debbuging support is Ctrl+F5.

Regards
