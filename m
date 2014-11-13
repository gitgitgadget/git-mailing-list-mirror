From: lennart spitzner <lsp@informatik.uni-kiel.de>
Subject: appropriate mailing list for gitk patches
Date: Thu, 13 Nov 2014 22:10:00 +0100
Message-ID: <54651E28.9090100@informatik.uni-kiel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 22:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1ke-000482-TT
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbaKMVQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:16:21 -0500
Received: from miraculix-out.informatik.uni-kiel.de ([134.245.248.209]:60821
	"EHLO miraculix.informatik.uni-kiel.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753906AbaKMVQU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 16:16:20 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2014 16:16:20 EST
X-Virus-Scanned: amavisd-new at informatik.uni-kiel.de
Received: from [192.168.178.21] (kiel-4d066c64.pool.mediaways.net [77.6.108.100])
	(authenticated bits=0)
	by miraculix.informatik.uni-kiel.de (8.14.9/8.14.9) with ESMTP id sADLB9e6016908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 13 Nov 2014 22:11:12 +0100 (MET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=informatik.uni-kiel.de; s=ifi-200807; t=1415913072;
	bh=PBzWAiVY2gYFn2jlr2SoE0EeuC+HvhWbL+NPiVZrT3E=;
	h=Message-ID:Date:From:MIME-Version:To:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=Lzv4SFmlovXdPDe8R0vBFxDTShMGLrquIqZTptj7LLo3L0rOm8Phe6p+N46D82qEn
	 t2KMM3QOyw2gJPq9BFlXutEssjbiYJmCxUjKvsHnwDv8HRVTJThp17gnkB1BcY7SyL
	 6apxuq9L7Sb9pHPx3VnsdTjzRT8INdN1N2G8GEtI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Null-Tag: ab479eba4d6e293fe9d2e8704e9a7741
X-Authenticated-Sender: user lsp from 77.6.108.100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

I have a patch for gitk. Should i send it to this list, or is there some
other?  git/Documentation/SubmittingPatches mentions
git://ozlabs.org/~paulus/gitk (the master of which i based my commit
on), but never mentions any list(s) by name (only "the Git mailing
list", which i presume is this one).

Also, a minor question regarding patches: I wondered why patches do not
mention the commit id that the patch(es) are based on. My current guess
is that the diffs containing the sha1's is considered sufficient. Is
this the case? Are there more/other aspects?

Lennart
