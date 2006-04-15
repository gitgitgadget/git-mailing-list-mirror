From: "Tony Luck" <tony.luck@intel.com>
Subject: Git web broken, or Linus' kernel tree in odd state
Date: Sat, 15 Apr 2006 11:55:55 -0700
Message-ID: <12c511ca0604151155j40c68a21qf684f77d2476605b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 20:56:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUpwE-0001Fb-5J
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 20:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWDOSz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 14:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWDOSz7
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 14:55:59 -0400
Received: from uproxy.gmail.com ([66.249.92.169]:56663 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030308AbWDOSz6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 14:55:58 -0400
Received: by uproxy.gmail.com with SMTP id c2so202094ugf
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 11:55:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ImW/RXqx2TfKSjd0xTeGbw09R/lQT4xhoTXy+GFVvAcoaLRWLgtMEGCO7nOs0rx12HeDPa6fXvg8e3JiYBoUZyPCDxb3f5FM/CtdRV9h/ThuoEx7yHOmuCUmch9ZzkoxV4ms4cl4IRo3+tSTlgXDRzReUZbh8EvCtINxDfmR/QA=
Received: by 10.78.20.13 with SMTP id 13mr105799hut;
        Sat, 15 Apr 2006 11:55:55 -0700 (PDT)
Received: by 10.78.46.14 with HTTP; Sat, 15 Apr 2006 11:55:55 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18756>

Git web is showing the "master" tag four commits back from HEAD on
the summary page for Linus' kernel tree, which is unusual (isn't it?).

I don't think that it is a mirror problem (it's been like it at least
an hour, and
shows the same at both www1 & www2.kernel.org)

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary

-Tony
