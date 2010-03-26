From: Eelis van der Weegen <eelis@eelis.net>
Subject: --color-words for gitk?
Date: Fri, 26 Mar 2010 15:58:01 +0100
Message-ID: <d1dd17db1003260758y4b658334m681c9a357742c89d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 15:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvAzF-0000T4-7Z
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 15:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0CZO6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 10:58:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63869 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0CZO6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 10:58:05 -0400
Received: by wyb38 with SMTP id 38so4016320wyb.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 07:58:01 -0700 (PDT)
Received: by 10.216.5.79 with HTTP; Fri, 26 Mar 2010 07:58:01 -0700 (PDT)
Received: by 10.216.90.77 with SMTP id d55mr594770wef.17.1269615481347; Fri, 
	26 Mar 2010 07:58:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143233>

I really like the word-by-word diff that one gets by saying

  git log -p --color-words

Unfortunately, I can't seem to find a way to get the same effect in gitk.

Am I overlooking something?
