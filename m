From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Benchmarks regarding git's gc
Date: Tue, 8 Nov 2011 13:34:09 +0200
Message-ID: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 12:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNjwW-0002sE-5s
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 12:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab1KHLeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 06:34:11 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36034 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1KHLeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 06:34:11 -0500
Received: by qao25 with SMTP id 25so286620qao.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Wm5hTAjuHjrQ+vI7NlItjB/uhHwPdiiKk8T9dgX9Bgw=;
        b=Ic27CtGnaW6W+oarMq6tsrGKDmP4ToyglvhdUAewJyOq/h+ZpPNzv3Rnw1lWK4wVdh
         VFzMwDdBnOYDijaYgIlRf/ZZHVJm/FlCkv5xrc3ByD5jf/qSANiERJ3XExwQqC3j6HaF
         ONrcx/lkfsHw/bhaXfWOCqXsg24QvRujqFcps=
Received: by 10.68.12.201 with SMTP id a9mr252483pbc.8.1320752050000; Tue, 08
 Nov 2011 03:34:10 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Tue, 8 Nov 2011 03:34:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185083>

Has anybody seen these?
http://draketo.de/proj/hg-vs-git-server/test-results.html#results

Seems like a potential area of improvement.

Cheers.

-- 
Felipe Contreras
