From: leam hall <leamhall@gmail.com>
Subject: clone part of a repo?
Date: Mon, 3 Nov 2014 14:44:27 -0500
Message-ID: <CACv9p5ofpzKof7ed_pTskQmsLVt0XL1NdAkYXUC8+NK7fVGisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:44:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlNYG-0005iu-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbaKCTo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:44:29 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55555 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaKCTo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:44:27 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so12875012pab.27
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xYESdK4X+5M2ODFpRu+qK6xYw9WLc/4STU4sPi4Jwqo=;
        b=ONLheWyxhIm2PMIYHiDHRPLeJL4pf2apcDrxhbHhdI6a7DjxByGXM8MA23zS7B8R3M
         GIx8uG4/5xxRz1So9gNAeunRSUiui0IDTlaySXuzAuRkc3Xl1GsAobT0PWbeQYqDq+6A
         cazElNnNHYY7q1Oq+XQfJrbCTovKjoK1Y7vZC69rORSZ0ICeiV0/k90C9LMkRVAzdvGT
         +r7r/6MtG1anG7JbjbbO0E4GOE99s77ePLQiMvxl1dhPxJfvx7VyX5QhbYYI6hNvwfxd
         H9P1A+lpCcTBk3KZ07NFqprjKZZozVoR8GXpxsssbdOWESx3k19irLJFDu9xXB+gzV/0
         trsA==
X-Received: by 10.68.65.105 with SMTP id w9mr2916635pbs.160.1415043867203;
 Mon, 03 Nov 2014 11:44:27 -0800 (PST)
Received: by 10.70.20.34 with HTTP; Mon, 3 Nov 2014 11:44:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way to clone part of a repo? For example, if Joe has a repo
of great code and all I'm interested in is one section, can I clone
just that one section?

Thanks!

Leam


-- 
Mind on a Mission
