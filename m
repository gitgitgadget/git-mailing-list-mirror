From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Merging some existing svn code
Date: Mon, 4 Jul 2011 13:59:34 +0100
Message-ID: <CAHVO_930ECHRYR7RsKGa61OtBhwyFA5Mt9NxpD6Ysq9jJBgk-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 04 14:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdikZ-0007Lx-Ui
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 14:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab1GDM7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 08:59:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36312 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab1GDM7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 08:59:37 -0400
Received: by iwn6 with SMTP id 6so4423923iwn.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=edQpvZXzfmiH3Gt79lbXx9P6G59fU9Uhl4RupdACBYg=;
        b=t29HWy9l05VbUp4DyN7JFOsjkSIAWJbaYMfoHR7foj/1ypMo68Ta+sKHAug0Gei6qP
         KEG8RNTVlI7E1bQ2BvpygpEBmx98gXaPeF3E8uiAJuxgWwnA3kvQ/qK8QPzqeiSdVkrS
         ZCKS4cDga//PdPYcLxAF1fMXezRzDNMxGbBwo=
Received: by 10.231.91.16 with SMTP id k16mr5540568ibm.124.1309784377058; Mon,
 04 Jul 2011 05:59:37 -0700 (PDT)
Received: by 10.231.36.132 with HTTP; Mon, 4 Jul 2011 05:59:34 -0700 (PDT)
X-Google-Sender-Auth: aRaHmL3yUcRVgL5LNHoqZLsiGWs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176597>

Firstly I have an application "under" git....  years ago I wrote a
plugin for the app (and by that I mean that it does not affect the
main code in any way) and that used svn. I've cloned the svn
repository using git svn so I have the history. I'd like to pull this
into the main project by moving the history onto a new branch. There
will be no merge issues but I'm unsure of the steps to take. The file
structure is not the same as the svn repository only covered the
required directory.

Any help appreciated.
