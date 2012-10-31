From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote SMB repo
Date: Wed, 31 Oct 2012 18:41:21 +0700
Message-ID: <CACsJy8B4mJ1XY8NDpKOGXDwmt0_37hz7r6D6ogagKuS94qtbYw@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
 <CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
 <CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
 <CACsJy8B3=33FE-SbOD6Su4v_DbyuYsxfh-DxAzbJbJa5B2pyLg@mail.gmail.com>
 <CAGHpTBLbPvkEGqh5PGbtNS0MKY5YutaQpx3D_Fv5oSWeR52K9A@mail.gmail.com> <CAGHpTB+o4gHfgFgLqie_hbjzWjxL94xRQi11GwS9F-Qhik0qVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTWgP-0003F6-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 12:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab2JaLlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 07:41:52 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47817 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab2JaLlv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 07:41:51 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1292376obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tABCADYAZjOF4al13ygUGK9gcVSMEdbuMk+jSmaths8=;
        b=JDAE1nh+t83SjocHgM/0yMJrQwTBlMKC5idXz784XLIYyxWEkFZ7v4/jT9jn2bVoBt
         XmSVGe968Kp5BMC+rlHmCdUbduaFEDUZifUAEs2RpxuABniQHm6eauAcYl45IodebDm3
         G1kjXNg07JTQ8eW4VxpnHtStmzdOUHFM+FVonBqDIo8BbRtBnzqDJSODKeeOtpf9bXz8
         3QF/OkWWRHMcZusbCZBQdqERRLAEtuOCEJESUN4J0HDNerXC3Za5a4FH8gaILFcDdTQe
         l4T9zF4RiBYunY965UgysmXlJJguE+NF7qsadsPGtzWlEBQJVFWw5ubJe8d75nTTTr6k
         zf4Q==
Received: by 10.60.32.137 with SMTP id j9mr32207085oei.133.1351683711377; Wed,
 31 Oct 2012 04:41:51 -0700 (PDT)
Received: by 10.182.4.134 with HTTP; Wed, 31 Oct 2012 04:41:21 -0700 (PDT)
In-Reply-To: <CAGHpTB+o4gHfgFgLqie_hbjzWjxL94xRQi11GwS9F-Qhik0qVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208807>

On Tue, Oct 30, 2012 at 4:28 PM, Orgad Shaneh
> Any news? This still doesn't work with 1.8.0.

Nope, sorry. It's still in my todo list.
-- 
Duy
