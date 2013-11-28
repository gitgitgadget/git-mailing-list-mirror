From: Antoine Pelisse <apelisse@gmail.com>
Subject: Can't connect to git-scm.com
Date: Thu, 28 Nov 2013 14:47:03 +0100
Message-ID: <CALWbr2xdmh3DfgaJr=MEWwpwpoR0x=Go1oyUm9_ri31mvDyCEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 28 14:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm1w2-0000Mv-6j
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 14:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab3K1NrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 08:47:09 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:40349 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926Ab3K1NrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 08:47:07 -0500
Received: by mail-la0-f43.google.com with SMTP id n7so5982092lam.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 05:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=O0TQO1B6cFsPxDbgKAiWeS0R1zkvwpkYhTA5qDNNAxg=;
        b=cyp4bxTblx3T2idw9zvWTIAeOanZNZ+8MgsDLDCTMHYspq4CmZH/xQWUetsjLWLYvr
         fEw/H2VVoPVU/mWCo/urhL45OqRDe8szvzKT6G2RNFm+4NHsJZfLxknU6m0tJ/uu4K5c
         Tcn8+BH/7OM/5UZjitHnhQ7e2E0LZQmmH/tMEA5NsXdZY7L/F2GhwKF6ZKJr2LQZf+TV
         5LLtDA1oRDacB9GXWXZn2uKT1jA4dnjOGFb2PEu5yCb72ygcUrK85I/vCf4yudR9hMVP
         QYnyQo5G1tActZQ+f6VbjgP+065h6rbsHXzYTfQNt/4bX2Q6u0Rs21+Fcz0pg8ufvOr2
         +vJA==
X-Received: by 10.112.89.42 with SMTP id bl10mr30050390lbb.18.1385646424036;
 Thu, 28 Nov 2013 05:47:04 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Thu, 28 Nov 2013 05:47:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238494>

Hello,

Should we be worried by this behavior ?

git-scm.com is returning 301 to www.git-scm.com (I don't remember that
it was happening before)
And www.git-scm.com is returning 200: Sorry, no Host found.
