From: hen vertis <henvertis@gmail.com>
Subject: Git push stuck
Date: Sat, 21 Apr 2012 13:54:56 +0300
Message-ID: <4F929200.4010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 12:55:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLXy9-0006ER-8d
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 12:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab2DUKzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 06:55:01 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58579 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab2DUKzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 06:55:00 -0400
Received: by wgbdr13 with SMTP id dr13so10419205wgb.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=HvPtg7yDzE1k/zvqgnfMZlLbZ6kZPXq2XjIHIDRQ98M=;
        b=ds8bTIBkNoY7y0uojECITjPiJhgHCfPqiwEUokisXhuTEW6+TnwI6WCnALBPsr02bZ
         3mCv/8aFNmU5j7zXBJksEWK0X+Od9+W7VV5MfSkB/pCAIVMjVV32a5w3YGYx5JS5dpzu
         E+bAg2N8jnAAxNq8OZtbd6eniCa72EFYjR2X3d94qoYuW7PAoWnfpPqxLB9kSk8HnH9K
         5BOj2XiigcXfFlmI6Eo+oEGmeZR45v5nXC5H+1ip1K2cEBparz8o2J3fM5Iy7slCi905
         ufe8J6FrMCzYhQXud+Z8nhde3BM0/XOKPfyWSsIZVLtQTzXE49pNYzeSP4k6cXEIuPmR
         UUrQ==
Received: by 10.180.95.37 with SMTP id dh5mr5316212wib.8.1335005699567;
        Sat, 21 Apr 2012 03:54:59 -0700 (PDT)
Received: from [192.168.0.197] (bzq-84-109-50-207.red.bezeqint.net. [84.109.50.207])
        by mx.google.com with ESMTPS id ev10sm4726549wid.10.2012.04.21.03.54.57
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 03:54:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196047>

hi
i working with git version 1.7.10.msysgit.1 on windows 7.
my repository is on Ubuntu.
i can make fetch and merge.
but when i trying to push is not working.
any idea will be welcomed.

best regards
hen
