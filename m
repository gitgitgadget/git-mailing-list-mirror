From: Adam GROSZER <agroszer@gmail.com>
Subject: opening an editor from git-gui on a file
Date: Mon, 16 Nov 2015 08:58:51 +0100
Message-ID: <56498CBB.4070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 08:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyEgl-0006br-Dn
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 08:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbKPH6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 02:58:55 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36698 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbbKPH6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 02:58:54 -0500
Received: by wmww144 with SMTP id w144so98410282wmw.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 23:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=L+9puPI2hrc6cbwWKOg2EpwZ/n68f2BQjb/xyOLDrfI=;
        b=dBC3thJyF52+fz7Y0IYw2l24CbRiojE4d/Zo6HcTlqNAYZg713/x2UZTAed5N1U7B9
         XAx4c6pgscr6SeX6/82oLxMbbWn6gisFrk/aVb2MiO3yjZ70+GaWuWXEeKxuHW1DPVzn
         Isb2LUDZ1k/S0jYfD5ck9i55B0iM5NL+EwH4gh43HRqhrv0rX+ZIt0wTMuVbHktdR+/p
         AbhbSO4s/djWyRR1CK4WHRjXD+/orITHGDpaV9FYi0F8APFItXJ9QLmzDo39/rvOy7nb
         0mn6U0NxtZBBjM2y5k/KaLHSiWR/clUhrf7yIwhF45emCCPxPeHZiumDCQ407/BwwzN6
         0+jg==
X-Received: by 10.194.78.112 with SMTP id a16mr35434664wjx.70.1447660733504;
        Sun, 15 Nov 2015 23:58:53 -0800 (PST)
Received: from [192.168.1.247] (catv-78-139-38-214.catv.broadband.hu. [78.139.38.214])
        by smtp.googlemail.com with ESMTPSA id l81sm17247584wmb.2.2015.11.15.23.58.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Nov 2015 23:58:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281328>

Hi there,

Hopefully sending the question/idea to the right list...

I'm missing the feature to open a (configurable) editor with the 
currently selected file in git gui.

E.g. Looking at

https://cdn.tutsplus.com/net/uploads/legacy/2081_gitwin/git-gui-stage.jpg

I'd like to open my editor with the "request.php".

Any chance to have that? Or do I miss something?

-- 
Best regards,
  Adam GROSZER
--
Quote of the day:
As of next week, passwords will be entered in Morse code.
