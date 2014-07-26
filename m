From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: old git documentation pages hosted at kernel.org
Date: Sat, 26 Jul 2014 12:31:25 +0100
Message-ID: <CAFY1edYN=hNyPm8oJxWTfMXTHbZdmCQnza+R5xpav9txb9fBrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XB0CI-00052K-N4
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 13:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaGZLb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 07:31:26 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:57362 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbaGZLb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2014 07:31:26 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so4755414iec.36
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=O3HgEOSw7csrBOkjP63Ixv6Q2GFr/WC8Gw6gjVf4Tms=;
        b=pL3GN1u4qvDbSldkZBE4h//KV3LfQLeCDa31r7fU/XWVT6jqiY7XrhDa4ptZOy+2XL
         UAPOaQxVGeeM1oUceD+/FYRBbh4K3ntwZvMp4i9nS91wvPhZEL19WY24OZ1uD7M2Y/G8
         p6sllEBH7OV7Bcgl9DWjKJE2dGkMqIep+fPjPuzpHJuFAwufyjDWgAkuCYCIV5Ee0Ut3
         be8Rveyvfx3p4/y/Z9jYhnD+HQiQ/o1yi96C3KmF1XiyY9C5As965F0zqTHoJ2DQzAO4
         CrkkVagxbIcAaVIDXpyUxAlCn0FtX/qxhxAlZbQD3DgsAqqMpSTnVSf48z5mVpHzPV6/
         lWfw==
X-Received: by 10.50.108.81 with SMTP id hi17mr13714705igb.30.1406374285365;
 Sat, 26 Jul 2014 04:31:25 -0700 (PDT)
Received: by 10.64.121.229 with HTTP; Sat, 26 Jul 2014 04:31:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254278>

The Git documentation pages hosted at kernel.org are a bit over a year
out of date ("Last updated 2013-02-15 19:24:31 UTC") - so from around
Git v1.8:

https://www.kernel.org/pub/software/scm/git/docs/

Are they fiddly to update? Should they be updated in celebration of
Git 2.0, or maybe instead redirect to http://git-scm.com/docs ?
