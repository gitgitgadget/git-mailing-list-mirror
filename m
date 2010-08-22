From: Guillermo Gonzalez <guillermog@tricuspide.com>
Subject: Creating a submodule and bringing history from the main project
Date: Sun, 22 Aug 2010 19:24:47 +0200
Message-ID: <AANLkTimoTN10EfeiE3Viim_x1Y3jRG89ANzRd69ah7jz@mail.gmail.com>
References: <AANLkTi=JWdp7ZneDpN5r4Zi4VaDfvW40QBZ-=sGx66O2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 22 19:25:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnEI4-0000HN-M6
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 19:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab0HVRYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 13:24:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51347 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab0HVRYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 13:24:48 -0400
Received: by iwn5 with SMTP id 5so2774977iwn.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 10:24:47 -0700 (PDT)
Received: by 10.231.157.143 with SMTP id b15mr5228053ibx.113.1282497887298;
 Sun, 22 Aug 2010 10:24:47 -0700 (PDT)
Received: by 10.231.32.9 with HTTP; Sun, 22 Aug 2010 10:24:47 -0700 (PDT)
In-Reply-To: <AANLkTi=JWdp7ZneDpN5r4Zi4VaDfvW40QBZ-=sGx66O2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154189>

Hello!

I have a big project, currently using GIT,  and I wish to take some
sudirectories -or libraries- and put them in a separate repo (and
incorporate them via submodule support), so other commiters can have
access to a specific part of the project only.

Is it possible to somehow export the history of say lib/componentX
into a new repository componentX.git?

Thank you very much!

Guillermo
