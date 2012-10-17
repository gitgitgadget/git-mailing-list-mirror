From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates for Swedish and Vietnamese
Date: Wed, 17 Oct 2012 09:54:11 +0800
Message-ID: <CANYiYbEhbH-FbSnV4+ZrJvOdR2f1Ey9AAre5_fqSXGsYdwR8uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOIqC-0001Qm-W9
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 03:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2JQByY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 21:54:24 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53160 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab2JQByM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 21:54:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so11001080iea.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 18:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=czh4tatDmdTi7ZHiBZvfzgqPGLRGCiESck/ObWceAEg=;
        b=Eap8noHvZ/BOCkHukFpuUu4EzXXPDQghEumGa5+3oeYAQh1/EglEfgJrzw3JXYi5MV
         9dUdqcj3vF4+m2aD5W9xjVKx8xFd93O332d7SwYKd5QzGN9qQgxK8SyRfpG+xOQMgBz6
         OhVq7pW0e7OXaYymJdlCa2KydpYdHDAkmRrH02oH3GdvkecvBrf5uOewWdYh+OuNPHyT
         YnBUaY+I2Z0WFKRJo7YDewC3d2Z3RQ6auvyRPvrI/Q/re1OYb2IvMttKY15+Zr859Bdz
         ZwDUyAJVqJmcttCQLmriB34U6+0GAi6GOfVp3iHRy8x6jMXwOzLIQFI1+OpArldQfJgy
         Jygw==
Received: by 10.43.57.5 with SMTP id we5mr5193102icb.23.1350438851950; Tue, 16
 Oct 2012 18:54:11 -0700 (PDT)
Received: by 10.50.186.135 with HTTP; Tue, 16 Oct 2012 18:54:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207888>

Hi, Junio

The following changes since commit d25c58ce43f45734ef74595b1e6fba1199651699:

  Documentation/RelNotes: remove "updated up to this revision" markers
(2012-10-16 15:35:00 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to b408887045e3e4abe1551936d4877f6b942c1916:

  Merge branch 'master' of https://github.com/nafmo/git-l10n-sv
(2012-10-17 09:38:30 +0800)

----------------------------------------------------------------

Jiang Xin (2):
      Merge branch 'master' of git://github.com/vnwildman/git
      Merge branch 'master' of https://github.com/nafmo/git-l10n-sv

Peter Krefting (1):
      l10n: Update Swedish translation (1964t0f0u)

Tran Ngoc Quan (1):
      l10n: vi.po: update from v1.8.0-rc2-4-g42e55

 po/sv.po | 879 +++++++++++++++++++++++++++++-----------------------------
 po/vi.po | 948 ++++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 913 insertions(+), 914 deletions(-)
