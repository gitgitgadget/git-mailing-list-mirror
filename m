From: "Ramon Tayag" <ramon.tayag@gmail.com>
Subject: Unable to index file
Date: Fri, 12 Dec 2008 22:47:29 +0800
Message-ID: <f25d5ad20812120647m646698d7t9849c8ccb08c465e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 15:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB9Jy-0001yz-55
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 15:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbYLLOrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 09:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756578AbYLLOra
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 09:47:30 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:7100 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbYLLOra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 09:47:30 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1346919wfd.4
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 06:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MHyJ07vFCVwFLr997y5bxG942me4jTrNrnSCBlypNJ8=;
        b=jR23n90b36lVc1ktumMT+MoE6pt5EcijlNdqmCTjZerLYLAUMxUrGkk8wRQND27kBi
         HkF+9/a7wYd+jFPZyfhc0X2Tp2Bsl/BqOQ1E981kW7mnDEGtaiGclGhlf8Dnl/vGLf8o
         IwiiRwEcowHZu/75N3+Gz5atIDa5jqYYJTjQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=QYmoIw3M01bE3an0wFcO5Ns9FG6NGZ4c8W01oOLvlGkhlQqqC9p+ta9rs/hnQerC/+
         V8T/Rlrmkb7qVS9f+DEO8dEOdBjmJOCcnLbnY8OYgbkfwAXkxDPAGwVOz+ulUyt1Fmro
         enbQzal3X+lNWNOnLZVLKlV/dUlavzFm82tFs=
Received: by 10.142.48.14 with SMTP id v14mr1387361wfv.166.1229093249483;
        Fri, 12 Dec 2008 06:47:29 -0800 (PST)
Received: by 10.142.191.15 with HTTP; Fri, 12 Dec 2008 06:47:29 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102899>

Hi everyone,

I've come across a problem that I don't believe lies in Rails.  You
needn't be familiar, I think, with Rails to see what's wrong.

I can't seem to add the files that are in
http://dev.rubyonrails.org/archive/rails_edge.zip

1) Unpack the zip
2) Initialize a git repo inside the folder that was unpacked
3) git add .

See the errors.. :o http://pastie.org/337571

Thanks,
Ramon Tayag
