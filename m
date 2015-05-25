From: Alangi Derick <alangiderick@gmail.com>
Subject: Suggestion to add a new command(git print-tree)
Date: Mon, 25 May 2015 17:17:40 +0100
Message-ID: <CAKB+oNunwVEc+UJxXN0y5U1VMKsZTyjQ-1zr_bdJbd+tOKeTPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 18:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywv4T-0000jw-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 18:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbbEYQRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 12:17:42 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33808 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbEYQRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 12:17:41 -0400
Received: by qkgx75 with SMTP id x75so67959842qkg.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=WOUkt2m7Y973VWSFvLc0nC9ov9F08D+alrdw4/o75+c=;
        b=ozQRnK+nbNKPc2QT6cLNzeZuCvgp0muYU0RD/1m9kbsmOAjsyaRGsCj+e6QFphBMI4
         rDyGeyBmmv4YudTdhiPq0NZdSbdnToX0shMK7nAd/hqXUNqsPN3QU/49TQH0TnriIhtW
         MC1mUCIDoQBnJhQMMPHp5eLFofETWg9Jk02rgHFH09OjPeTQAvTs/Jev7pfS/VQp/uYF
         tWb4vd3P31cmnWgExaNlOW22RTM0hba7zBVAN9t5LweXpNhr5kF53HFcPhZJKfcvO5QH
         YeERe+/qayZHw6AQv/gS72KJgqIKcqEfP8wqrxTGMiCvOszXYZkfd6MOgC3oHsG8RceS
         ebWw==
X-Received: by 10.55.33.23 with SMTP id h23mr1608899qkh.61.1432570660839; Mon,
 25 May 2015 09:17:40 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Mon, 25 May 2015 09:17:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269841>

Hello everyone,
     I will like us to discuss on this topic to add a new command into
git that will enable us to print the entire working tree in a git
repository. Something similar to work happens when you run the linux
command: "pstree".
     This is important in searching and also more that i will be
discussing while talking about the idea. Thanks and if there is
anything to say about this, feel free to comment.

Regards
Alangi Derick Ndimnain
