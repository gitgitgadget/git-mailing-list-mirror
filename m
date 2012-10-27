From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 10:32:48 +0200
Message-ID: <CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS1pJ-0008GP-5d
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab2J0Icu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:32:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65008 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2J0Ict (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:32:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3253924pbb.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=53MR7cHwkpO9ESd4urf5xHRdFXYfQEivm2X7fpSL+cE=;
        b=opct1hzTaTiNZNscMDYlJOh5reafX17bk49s3RuiawObCJexmoYzSkDm+3VsCWE+Xq
         NzFkbmdx9bjwbz3a9fXo8ULZBquukK0dD7tsgOHvp8oRJ8KUq1xyQCktPbvR5bGLUEnm
         XTGaNqHjJjfNSwAoTkdZqHAHQCXF/Pdd6IbCt9wAo5pnE/hbzcMfc7BrcXV/CBSTTy3v
         FhaJQ+g85hMKfVGgPv1e5tGim6/KQ+Ws2P/cWLdS+ZUqYxdsxfnsi/uJR5/Gt0Vlpzvo
         g4kyGY0roB5WlIF2/AMlrHm0FAwxddx0C1XRumKAgFXRr4cEkP4GkOlU4X2AzySz1TRc
         IqUA==
Received: by 10.68.209.170 with SMTP id mn10mr77137348pbc.11.1351326768743;
 Sat, 27 Oct 2012 01:32:48 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Sat, 27 Oct 2012 01:32:48 -0700 (PDT)
In-Reply-To: <m2bofo9v93.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208500>

Hi Andreas,

I wrote "value", but I meant "name". The first example I made contains
a name with a nonexistent section, the second a name with a
nonexistent key.

-Angelo
