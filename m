From: Alangi Derick <alangiderick@gmail.com>
Subject: Improving Readability of the entire Codebase
Date: Fri, 1 May 2015 16:08:45 +0100
Message-ID: <CAKB+oNv1q=62a0-T7CCcOAOU+sfXPiyZPMB1qWxf-8zX=4PPpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 17:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCYc-0005wq-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbbEAPIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:08:46 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36382 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbEAPIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:08:45 -0400
Received: by qku63 with SMTP id 63so52098424qku.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=bNGIv01vUNs5/6riwGvlydjcbjXutjyJlDKdMwqBSyI=;
        b=0cBriu7+Jk7pGzBUWcdc/iAbCvXJMn3RIC0p5JwnEMXbKgl40nfhyFuIUtJlX/dWuq
         WZgiw9Hsra7uHdC83wa7N3midYNEtOZINkRWeTnirBo3y5GYHKwVADLU3cnYpxRMqD0T
         wIAK14Dqn1czhlhzUHbPN1H0KdzLZQWQIyZF0pnxXRi0q3dMxmWDnvHhTNS/OVKAxrJR
         hq2NMTPiK/KzoaOWZBKuAEe3oCcYvkWvy8u73KuwHg1tM+gwl7/WfBvO3mPxNsxVfoGw
         Nhy8OzjsWehhFG5VUXN9AD6HIvW7551NU3M11qefKZ6hWkGbGXYwb3nQWkyg/wj9CJnY
         BxTQ==
X-Received: by 10.55.40.132 with SMTP id o4mr19784765qko.61.1430492925280;
 Fri, 01 May 2015 08:08:45 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 08:08:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268143>

Hello,
    While reading the source codes of Git, i found something. Some
sentences and words are not in their correct cases. For example like
starting a sentence with a lower case whereas it should be in upper
case. I want to go through the entire code base and correct the cases
of these letters to improve on readability. I will also use this
opportunity to learn the source codes and familiarize myself with the
code base. If its a nice idea, someone should please give me the go
ahead. I will be waiting.

Regards
Alangi Derick Ndimnain
