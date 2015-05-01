From: Alangi Derick <alangiderick@gmail.com>
Subject: Improve git help small idea
Date: Fri, 1 May 2015 18:32:39 +0100
Message-ID: <CAKB+oNtVR9aesBUcjRYY9AYVt5BWH8Cz3TrpCpF17DRvUWrZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 19:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEnt-00053Q-1Q
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbbEARcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 13:32:41 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35593 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbEARck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 13:32:40 -0400
Received: by qkhg7 with SMTP id g7so54395725qkh.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=5d5C0C5pXqR5ZXd6j3anHQt7H9okJGobdGLeB6laLuE=;
        b=GBbVydn4kFffQhYmIIRwtw5PCPcuWfmd2NitvL6E7wdc9I6f2g4N8rWvZ9WVUbX04B
         sJqDsdTnrjdvnf+NKASDGI4pimjwxmpBMAQFTD/O/pQib9kV9tCK6ywq1KBX0eJ4+58v
         KkZjV8KSJTEomDwibUXqna7cXpCo2glYpD9tk5hOqBiS19IUEZmtBtnx6DWWfK8cyOyB
         CTbOXPeRUrqxlPlV4Ip+xgrAh++J3vECkmrD6D7vmApxp1banZ98PbDUfo5aTstzbHfd
         R7ZW7GmB59ZPl8ClEnOxWs//De0h5yhkbTMgYXVUmqKpwbaTJvuC5L77dziWdNLBDifv
         cxAg==
X-Received: by 10.55.24.215 with SMTP id 84mr21261364qky.8.1430501559754; Fri,
 01 May 2015 10:32:39 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 10:32:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268163>

Hello,
     I have decided to work on one of the ideas as provided this link
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas. I will want
to work on improving the "help message" to be like the one in "bzr
help". I will work on it and submit a patch very soon.

Regards
Alangi Derick Ndimnain
