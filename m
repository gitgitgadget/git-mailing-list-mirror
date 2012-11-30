From: Jiang Xin <worldhello.net@gmail.com>
Subject: New git.pot is generated for git 1.8.1 l10n round 2
Date: Fri, 30 Nov 2012 13:01:23 +0800
Message-ID: <CANYiYbHJ5P3AJcRSEtT_5Awa0cO6ideACtg7vaS6uk9KrV59Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Fri Nov 30 06:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeIjM-0003lN-Rz
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 06:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab2K3FBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 00:01:25 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65328 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab2K3FBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 00:01:24 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so72741iay.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=7OqJbaFAL3xnigvYMaDdqBqIi+8w7htkKsbmLXixQQU=;
        b=U17RP90IFTuk2JBuMiIuLlzvk9TYkH7asespVFMipIYq+LaUCfC9UT5f/iH5oceSr9
         JrPYdg1SBwelxYUHe5+XAlDn/gOOJBuB4EKcdPdbI+WSRFC2fyxK6NGmiXRek37AiWmQ
         TpfdYm3Z1dPXh0364sks/59TkoKDb804M76SHRm6gLehx3DhhqBI1A7jJgbuLUx0XdQS
         np8WqfgGhs0bfcQsPd3I53KaLQ0Nu3kaUpybU4nOOgCscOdahQr6mg0HaTfJfm35fnvP
         EaMazT6MehmiliBUWYKt0Cy6Va4GW5XJMGdrKyD5oYsK24b1DDgrgJSPeIKzkWJk65Q7
         3zKw==
Received: by 10.50.202.73 with SMTP id kg9mr27949942igc.51.1354251684016; Thu,
 29 Nov 2012 21:01:24 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Thu, 29 Nov 2012 21:01:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

New "git.pot" is generated from v1.8.0.1-347-gf94c3 in the master branch.

    l10n: Update git.pot (5 new, 1 removed messages)

    L10n for git 1.8.1 round 2: Generate po/git.pot from v1.8.0.1-347-gf94c3.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of upcoming git 1.8.1. You can get it from
the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
