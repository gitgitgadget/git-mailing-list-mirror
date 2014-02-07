From: =?ISO-8859-1?B?R+Fib3IgTGlwdOFr?= <gabor.liptak@gmail.com>
Subject: Fwd: Git Directory Diff for submodule
Date: Fri, 7 Feb 2014 10:15:05 +0100
Message-ID: <CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>
	<CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 10:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBhWm-0000ra-4y
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 10:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaBGJPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 04:15:09 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:49908 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaBGJPG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 04:15:06 -0500
Received: by mail-vb0-f50.google.com with SMTP id w8so2374418vbj.23
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=SiBF+6joapk5jOsZhjbtkNMRHPYK2dOrIo1PGum2bAY=;
        b=ERzVBiL9u4/XD+Dw08zkW0ZsOtf5BeLXPrKaEV/294WYijBtKbelAuvtr0W7ts43LR
         XJtc0flfI4cIIZvEsgRDbtJa7yK4Az5+jkdJq4441WjN727nzORPOxO/xHP4ViC2zGDO
         7aIndSmTi3Fdo8vP0TjLQVbz2JIBnRuP9MYoqGzluVYXjZIG9euIengeIpkmeNszBku+
         lE2j7YQwxmNlRP1MVkQqAFfyXNeahlOAjbBrMt2d5HMg1YwhfqRiNOiS1vvwHF6gjjOG
         gtGE0Y3z8swYN8XZBRzRXLw/b2k3SXo2vtTh44LTAdKDmDJdU4c9qkyCZL8hmfmjnzp/
         ivog==
X-Received: by 10.220.131.210 with SMTP id y18mr9602068vcs.12.1391764505311;
 Fri, 07 Feb 2014 01:15:05 -0800 (PST)
Received: by 10.58.186.232 with HTTP; Fri, 7 Feb 2014 01:15:05 -0800 (PST)
In-Reply-To: <CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241763>

Hi,

I think I have found a bug related to submodules and directory diff.
See the details at hXXp://stackoverflow.com/q/21623155/337621.
If you need any further details, just ask.

Regards,

G=E1bor Lipt=E1k
